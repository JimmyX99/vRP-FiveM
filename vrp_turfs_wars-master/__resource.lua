--[[
	 PROJECT: vRP_turfs_Wars
     The Resource is free software 
	 This is my version of Turs-Wars
	 Author:JimmyX#3054
	 Do not copy the resource without my permission
	 C All Rights reserved
--]]

description "vRP_turfs_wars"

dependency "vrp"
dependency "vrp_mysql"

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}
