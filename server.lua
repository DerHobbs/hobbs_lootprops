RegisterNetEvent('check_if_can_carry')
AddEventHandler('check_if_can_carry', function(item, amount, entityId)
    local source = source
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)

    local canCarry = exports.ox_inventory:CanCarryAmount(source, item)
    
    if canCarry > 0 then
        local toCarry = math.min(canCarry, amount)
        exports.ox_inventory:AddItem(source, item, toCarry)
        local remainder = amount - toCarry
        if remainder > 0 then
            exports.ox_inventory:CustomDrop('Loot', {
                { item, remainder }
            }, playerCoords)
        end
        TriggerClientEvent('give_loot_client', source, item, toCarry)
    else
        exports.ox_inventory:CustomDrop('Loot', {
            { item, amount }
        }, playerCoords)

        TriggerClientEvent('ox_lib:notify', source, { description = Config.Texts.notEnoughSpace, type = 'error' })
    end
end)

RegisterNetEvent('give_loot')
AddEventHandler('give_loot', function(item, amount)
    local xPlayer = source
    exports.ox_inventory:AddItem(xPlayer, item, amount)
end)