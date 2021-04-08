description "vRP Faction 2.0"
author "Jimmy#1337"
--ui_page "ui/index.html"

dependency "vrp"

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "cfg/factions.lua"
}

server_scripts{
    '@vrp/lib/utils.lua',
    '@vrp/lib/Tools.lua',
    'server.lua'
}
