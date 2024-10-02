Config = {}

Config.Props = {
    { 
        props = {
            -- List of prop hashes for the props you can search for loot
            GetHashKey('prop_rub_carwreck_2'),
            GetHashKey('prop_rub_carwreck_3'),
            GetHashKey('prop_rub_carwreck_5'),
            GetHashKey('prop_rub_carwreck_7'),
            GetHashKey('prop_rub_carwreck_8'),
            GetHashKey('prop_rub_carwreck_9'),
            GetHashKey('prop_rub_carwreck_10'),
            GetHashKey('prop_rub_carwreck_11'),
            GetHashKey('prop_rub_carwreck_12'),
            GetHashKey('prop_rub_carwreck_13'),
            GetHashKey('prop_rub_carwreck_14'),
            GetHashKey('prop_rub_carwreck_15'),
            GetHashKey('prop_rub_carwreck_16'),
            GetHashKey('prop_rub_carwreck_17'),
            GetHashKey('prop_rub_buswreck_01'),
            GetHashKey('prop_rub_buswreck_03'),
            GetHashKey('prop_rub_buswreck_06'),
            GetHashKey('prop_rub_railwreck_1'),
            GetHashKey('prop_rub_railwreck_2'),
            GetHashKey('prop_rub_railwreck_3'),
            GetHashKey('prop_rub_bike_03'),
            GetHashKey('prop_rub_trukwreck_1'),
            GetHashKey('prop_rub_trukwreck_2')
        }, 
        loot = { 
            -- Loot items and the possible amount range
            { item = 'scrap', amount = {1, 5} },
            { item = 'rubber', amount = {1, 3} }
        }, 
        -- Maximum number of searches before cooldown is triggered
        maxSearches = 3, 
        -- Cooldown duration in seconds (300 seconds = 5 minutes)
        cooldown = 300,
        -- Text that appears when interacting with the prop using the target system
        label = 'Search for useful items', 
        -- Text displayed on the progress bar while searching
        progressBarText = 'Collecting useful items...',
        -- Duration of the progress bar in milliseconds (8000ms = 8 seconds)
        searchDuration = 8000
        -- Custom animation and prop for vehicle wrecks
        animation = {
            dict = 'amb@world_human_welding@male@base',
            clip = 'base',
            prop = 'prop_weld_torch',
            bone = 57005, -- Right hand bone
            pos = { x = 0.1, y = 0.02, z = 0.0 },
            rot = { x = 165.0, y = 0.0, z = 180.0 }
        }
    },
    { 
        props = {
            -- List of tree props
            GetHashKey('prop_haybale_02')
        }, 
        loot = { 
            { item = 'wood', amount = {1, 5} }
        }, 
        maxSearches = 3, 
        cooldown = 300,
        label = 'Chop down the tree',
        progressBarText = 'Chopping wood...',
        searchDuration = 8000,
        -- Custom animation and prop for tree interaction (no prop, using hands to collect)
        animation = {
            dict = 'amb@prop_human_bum_bin@base', -- Animation for collecting with hands reaching forward
            clip = 'base', -- The base clip of the animation
            prop = false, -- No prop is used, just hands
            bone = 0, -- No specific bone is required
            pos = { x = 0.0, y = 0.0, z = 0.0 }, -- No position adjustment needed
            rot = { x = 0.0, y = 0.0, z = 0.0 } -- No rotation adjustment needed
        }
    }
    -- Add more here if you want to add more props
}

Config.Texts = {
    -- Notification text when an item is received
    itemReceived = "You have received %sx %s.",
    -- Notification text when the prop is on cooldown
    propOnCooldown = "There is nothing left to gather here, try again later.",
    -- Notification text when the player doesn't have enough space to carry items
    notEnoughSpace = "You cannot carry any more!"
}
