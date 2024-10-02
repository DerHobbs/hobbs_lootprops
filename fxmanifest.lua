fx_version 'cerulean'
game 'gta5'

author 'DerHobbs'
description 'Collecting Loot'

shared_script 'config.lua'
client_scripts {
    '@ox_lib/init.lua',
    'client.lua'
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

dependencies {
    'ox_lib',
    'ox_target',
    'ox_inventory'
}

lua54 'yes'