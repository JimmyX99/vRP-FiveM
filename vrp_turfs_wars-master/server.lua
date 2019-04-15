--[[
	         PROJECT: vRP_turfs_Wars
		 The Resource is free software 
		 This is my version of Turs-Wars
		 Author:JimmyX#3054
		 Do not copy the resource without my permission
		 C All Rights reserved
--]]

MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPtw = Tunnel.getInterface("vrp_turfs_wars","vrp_turfs_wars")
vRPclient = Tunnel.getInterface("vRP","vrp_turfs_wars")

vRPtwar = {}
Tunnel.bindInterface("vrp_turfs_wars",vRPtwar)
Proxy.addInterface("vrp_turfs_wars",vRPtwar)

--MySql init
MySQL.createCommand("vRP/add_turf", "INSERT IGNORE INTO vrp_turfs_wars(id, x, y, z, blipColor) VALUES(@id, @x, @y, @z, @blipColor)")
MySQL.createCommand("vRP/remove_turf", "DELETE FROM vrp_turfs_wars WHERE id = @id")
MySQL.createCommand("vRP/get_turfs", "SELECT * FROM vrp_turfs_wars")
MySQL.createCommand("vRP/get_turf_radius", "SELECT radius FROM vrp_turfs_wars WHERE id = @turfID")
MySQL.createCommand("vRP/get_faction_turfs", "SELECT * FROM vrp_turfs_wars WHERE faction = @theFaction")

local a = 0

RegisterServerEvent('spawnturf')
AddEventHandler('spawnturf',function()
	user_id = vRP.getUserId({source})
	player = vRP.getUserSource({user_id})
	name = vRP.getPlayerName({player})
	turfuri = 0
	MySQL.query("vRP/get_turfs", {}, function(turfs, affected)
		if #turfs > 0 then
			for i, v in ipairs(turfs) do
				turfuri = turfuri + 1
				id = v.id
				x = v.x
				y = v.y
				z = v.z 
				blipColor = v.blipColor
				if vRP.hasGroup({user_id,"cop1"}) or vRP.hasGroup({user_id,"cop"}) then
			       TriggerClientEvent('createTurfZone:cop',player,id,x, y, z, blipColor)
				end
				if vRP.hasPermission({user_id,"admin.turf"}) or vRP.hasGroup({user_id,"admin"}) then
					TriggerClientEvent('createTurfZone:perm',player,id,x, y, z, blipColor,name)
				else
					TriggerClientEvent('createTurfZone:noperm',player,id,x, y, z, blipColor)
				end
			end
		end
	end)
end)

RegisterServerEvent('vrp:givemoney')
AddEventHandler('vrp:givemoney',function(name,blipColor)
	user_id = vRP.getUserId({source})
	player = vRP.getUserSource({user_id})
	vRP.giveMoney({user_id, 50000})
	TriggerClientEvent('xdgimi:notify_turfs_wars_continue',-1,name,blipColor)
end)

RegisterServerEvent('startwar')
AddEventHandler('startwar',function(id,name,x,y,z,blipColor)
	owner_id = vRP.getUserId({source})
	TriggerClientEvent('xdgimi:notify_turfs_wars_owner',-1,tostring(name),blipColor)
	TriggerClientEvent('xdgimi:blip_vcreate',-1,id,name,x,y,z,blipColor)
	if blipColor == 1 then -- Red Color
		nameblip = "Los Santos"
	elseif blipColor == 2 then --Blue Color
		nameblip = "Las Venturas"
	elseif blipColor == 3 then -- Green Color
		nameblip = "San Fransisco"
	elseif blipColor == 5 then --Yellow Color
		nameblip = "California"
	elseif blipColor == 27 then -- Purple Color
		nameblip = "Grove Street"
	end
	TriggerEvent('chatMessage',-1,'^0[^4TURF^0] ', {255, 0, 0}, "^0 The Turf ^4" .. nameblip .. "^r^0 is conqured by ^9^*".. name .. "^r^0,find the location and kill the boss!")
end)

RegisterServerEvent('endwar')
AddEventHandler('endwar',function(id,name,blipColor)
	TriggerClientEvent('vrp:notify_endwar',-1,tostring(name),blipColor)
end)

local ch_delTurf = {function(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRP.prompt({player,"ID Turf:","",function(player,turfID)
			MySQL.query("vRP/get_turfs", {}, function(turfs, affected)
				if #turfs > 0 then
					for i,v in pairs(turfs) do
						id = v.id
						if tonumber(turfID) > 0 and tonumber(turfID) == tonumber(id) then
							MySQL.query("vRP/remove_turf", {id = id})
							vRPclient.notify(player,{"~w~[Turf-Wars] ~g~The Turfs with ID ~r~#"..turfID.." ~g~was deleted!"})
						end
					end
				end
			end)
		end})
	end
end, "Delete Turf Area"}

local ch_createTurf = {function(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRP.prompt({player,"Area:","[range ex: 50]",function(player,radius)
			radius = radius
			vRP.prompt({player,"Color Blip:","[ex:1,2,3,4,5]",function(player,blipColor)
				blipColor = blipColor
				vRP.prompt({player,"ID Faction:","[ex:1,2,3,4]",function(player,factionID)
					factionID = factionID
					if factionID ~= "" or factionID ~= nil then
						vRPclient.getPosition(player,{},function(x,y,z)
							turfuri = turfuri + 1
							MySQL.query("vRP/add_turf", {id = turfuri, x = x, y = y, z = z, radius = radius, blipColor = blipColor, factionID = factionID})
							vRPclient.notify(player,{"~w~[Turf-Wars] ~g~The Turfs with ID ~r~#"..turfID.." ~g~was created!"})
							local users = vRP.getUsers({})
							for k, thePlayer in pairs(users) do
								vRPtw.createTurfZone(thePlayer,{turfuri, x, y, z, radius, blipColor})
							end
						end)
					end
				end})
			end})
		end})
	end
end, "Create Area for Mafia"}

vRP.registerMenuBuilder({"admin", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
	    if vRP.hasGroup({user_id,"admin"}) then
			choices["Create Turf Wars"] = ch_createTurf
			choices["Delete Turf Wars"] = ch_delTurf
		end
		add(choices)
	end
end})

