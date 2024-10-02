local ox_target = exports.ox_target
local searchedProps = {}
local weldTorch = nil

Citizen.CreateThread(function()
    for _, propData in ipairs(Config.Props) do
        for _, propHash in ipairs(propData.props) do
            ox_target:addModel(propHash, {
                {
                    name = 'collect_scrap',
                    label = propData.label,
                    icon = 'fas fa-recycle',
                    distance = 1.5,
                    event = 'collect_scrap',
                    canInteract = function(entity)
                        return GetEntityModel(entity) == propHash
                    end,
                }
            })
        end
    end
end)

local function createWeldingProp(playerPed)
    local propModel = GetHashKey(Config.Animations.prop)
    
    RequestModel(propModel)
    while not HasModelLoaded(propModel) do
        Wait(0)
    end

    weldTorch = CreateObject(propModel, 1.0, 1.0, 1.0, true, true, true)
    AttachEntityToEntity(weldTorch, playerPed, GetPedBoneIndex(playerPed, Config.Animations.bone),
        Config.Animations.pos.x, Config.Animations.pos.y, Config.Animations.pos.z,
        Config.Animations.rot.x, Config.Animations.rot.y, Config.Animations.rot.z,
        false, false, false, true, 2, true)
end

local function removeWeldingProp()
    if weldTorch and DoesEntityExist(weldTorch) then
        DeleteObject(weldTorch)
        weldTorch = nil
    end
end

local function getItemLabel(itemName)
    local itemData = exports.ox_inventory:Items()[itemName]
    if itemData then
        return itemData.label
    else
        return itemName
    end
end

RegisterNetEvent('collect_scrap')
AddEventHandler('collect_scrap', function(data)
    local playerPed = PlayerPedId()
    local entityId = data.entity

    local selectedProp = nil
    for _, propData in ipairs(Config.Props) do
        for _, hash in ipairs(propData.props) do
            if GetEntityModel(entityId) == hash then
                selectedProp = propData
                break
            end
        end
        if selectedProp then break end
    end

    if not selectedProp then
        print("Prop not found in Config.Props")
        return
    end

    if not searchedProps[entityId] then
        searchedProps[entityId] = {count = 0, cooldown = 0}
    end
    
    local currentTime = GetGameTimer()
    local searchData = searchedProps[entityId]

    if searchData.count >= selectedProp.maxSearches then
        if currentTime - searchData.cooldown < selectedProp.cooldown * 1000 then
            lib.notify({ description = Config.Texts.propOnCooldown, type = 'error' })
            return
        else
            searchData.count = 0
        end
    end

    RequestAnimDict(Config.Animations.dict)
    while not HasAnimDictLoaded(Config.Animations.dict) do
        Wait(0)
    end

    TaskPlayAnim(playerPed, Config.Animations.dict, Config.Animations.clip, 3.0, -8.0, selectedProp.searchDuration / 1000, 15, 0, false, false, false)
    createWeldingProp(playerPed)

    if lib.progressBar({
        duration = selectedProp.searchDuration,
        label = selectedProp.progressBarText,
        canCancel = false,
        disable = {
            move = true,
            combat = true,
            car = true,
        }
    }) then
        local randomLoot = selectedProp.loot[math.random(1, #selectedProp.loot)]
        local amount = math.random(randomLoot.amount[1], randomLoot.amount[2])

        TriggerServerEvent('check_if_can_carry', randomLoot.item, amount, entityId)
    end

    StopAnimTask(playerPed, Config.Animations.dict, Config.Animations.clip, 2.0)
    Wait(500)
    removeWeldingProp()

    searchData.count = searchData.count + 1
    if searchData.count >= selectedProp.maxSearches then
        searchData.cooldown = GetGameTimer()
    end
end)

RegisterNetEvent('give_loot_client')
AddEventHandler('give_loot_client', function(item, amount)
    local itemLabel = getItemLabel(item)
    lib.notify({ description = string.format(Config.Texts.itemReceived, amount, itemLabel), type = 'success' })
end)