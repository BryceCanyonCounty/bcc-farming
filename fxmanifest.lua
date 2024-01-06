game 'rdr3'
fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'
author 'Jake2k4'
description 'bcc-farming'

server_scripts {
    '/server/server.lua',
    '@oxmysql/lib/MySQL.lua',
}

shared_scripts {
    'config.lua',
    'shared/locale.lua',
    'languages/*.lua'
}


client_scripts {
    '/client/client.lua',
    '/client/functions.lua',
}

dependencies {
    'vorp_core',
    'vorp_character',
    'vorp_inventory',
    'bcc-utils'
}

version '1.0.5'
