fx_version 'cerulean'
games { 'gta5' };

client_scripts {
    "client/*.lua",  
}

server_scripts {
    'server/*.lua',
    '@mysql-async/lib/MySQL.lua',  
}

shared_scripts {
    "shared/*.lua"
}
