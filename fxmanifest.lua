game 'rdr3'
fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'
author 'BCC Team'
description 'bcc-farming'

shared_scripts {
    'configs/*.lua',
    'locale.lua',
    'languages/*.lua',
    'shared/init.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/services/*.lua'
}

client_scripts {
    'client/main.lua',
    'client/services/*.lua'
}

dependencies {
    'vorp_character',
    'vorp_inventory',
    'bcc-utils'
}

version '2.7.0'
