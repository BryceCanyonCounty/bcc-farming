game 'rdr3'
fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'
author 'Jake2k4'
description 'bcc-farming'

shared_scripts {
    'configs/*.lua',
    'locale.lua',
    'languages/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '/server/helpers/functions.lua',
    '/server/helpers/*.lua',
    '/server/services/*.lua',
    '/server/*.lua'
}

client_scripts {
    '/client/helpers/functions.lua',
    '/client/helpers/*.lua',
    '/client/*.lua',
    '/client/services/*.lua'
}

dependencies {
    'vorp_character',
    'vorp_inventory',
    'bcc-utils'
}

version '2.2.0'
