--[[
	         PROJECT: vRP_turfs_Wars
		 The Resource is free software 
		 This is my version of Turs-Wars
		 Author:JimmyX#3054
		 Do not copy the resource without my permission
		 C All Rights reserved
                 Fixed by :"Name#3999
--]]

MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPtw = Tunnel.getInterface("vRP_turf_wars","vRP_turf_wars")
vRPclient = Tunnel.getInterface("vRP","vRP_turf_wars")

vRPtwar = {}
Tunnel.bindInterface("vRP_turf_wars",vRPtwar)
Proxy.addInterface("vRP_turf_wars",vRPtwar)

MySQL.createCommand("vRP/add_turf", "INSERT IGNORE INTO vrp_turfs(id, x, y, z, radius, blipColor, faction) VALUES(@id, @x, @y, @z, @radius, @blipColor, @factionID)")
MySQL.createCommand("vRP/get_turfs", "SELECT * FROM vrp_turfs")
MySQL.createCommand("vRP/get_turf", "SELECT * FROM vrp_turfs WHERE id = @turfID")
MySQL.createCommand("vRP/get_turf_radius", "SELECT radius FROM vrp_turfs WHERE id = @turfID")
MySQL.createCommand("vRP/get_faction_turfs", "SELECT * FROM vrp_turfs WHERE faction = @theFaction")

theTurfs = {}

function vRPtwar.spawnTurfs(source)
	turfuri = 0
	MySQL.query("vRP/get_turfs", {}, function(turfs, affected)
		if #turfs > 0 then
			for i, v in ipairs(turfs) do
				turfuri = turfuri + 1
				id = v.id
				x = v.x
				y = v.y
				z = v.z 
				radius = v.radius
				blipColor = v.blipColor
				vRPtw.createTurfZone(source, {id, x, y, z, radius, blipColor})
			end
		end
	end)
end

AddEventHandler("onResourceStart", function(res)
	if(res == "vrp_turf_wars")then
		SetTimeout(2000, function()
			MySQL.query("vRP/get_turfs", {}, function(turfs, affected)
				if #turfs > 0 then
					for i, v in ipairs(turfs) do
						if(theTurfs[v.faction] == nil)then
							theTurfs[v.faction] = 0
						end
						theTurfs[v.faction] = theTurfs[v.faction] + 1
					end
				end
			end)
		end)
	end
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	vRPtwar.spawnTurfs(source)
	--vRPtw.initTurf(source,{})
end)

local ch_createTurf = {function(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRP.prompt({player,"Arie Acoperire:","",function(player,radius)
			radius = radius
			vRP.prompt({player,"Culoare Turf:","",function(player,blipColor)
				blipColor = blipColor
				vRP.prompt({player,"ID Factiune:","",function(player,factionID)
					factionID = factionID
					if factionID ~= "" or factionID ~= nil then
						vRPclient.getPosition(player,{},function(x,y,z)
							turfuri = turfuri + 1
							MySQL.query("vRP/add_turf", {id = turfuri, x = x, y = y, z = z, radius = radius, blipColor = blipColor, factionID = factionID})
							vRPclient.notify(player,{"~w~[TURF] ~g~Turf cu ID-ul ~r~#"..turfuri.." ~g~a fost creeat!"})
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
end, "Creaza zona turf pentru mafii"}

local ch_delTurf = {function(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRP.prompt({player,"Arie Acoperire:","",function(player,turfID)
			MySQL.query("vRP/get_turf", {turfID = turfID}, function(turfs, affected)
				if #turfs > 0 then
					vRPclient.notify(player,{"~w~[TURF] ~g~Turf cu ID-ul ~r~#"..turfID.." ~g~a fost sters!"})
					local users = vRP.getUsers({})
					for k, thePlayer in pairs(users) do
						vRPtw.deleteTurfZone(thePlayer,{turfID})
						turfuri = turfuri - 1
					end
				else
					vRPclient.notify(player,{"~w~[TURF] ~r~Turf-ul cu ID-ul ~w~#"..turfID.." ~r~nu a fost gasit"})
				end
			end)
		end})
	end
end, "Sterge zona turf"}

vRP.registerMenuBuilder({"admin", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
	
		if vRP.hasGroup({user_id, "superadmins"}) then
			choices["Create Turf"] = ch_createTurf
			choices["Delete Turf"] = ch_delTurf
		end
		add(choices)
	end
end})

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1800000)
		local users = vRP.getUsers({})
		for i, v in pairs(users) do
			local user_id = i
			local player = vRP.getUserSource({user_id})
			if(vRP.hasUserFaction({user_id}))then
				local theFaction = vRP.getUserFaction({user_id})
				if(vRP.getFactionType({theFaction}) == "Mafie")then
					local totalTurfs = tonumber(theTurfs[theFaction]) or 0
					if(totalTurfs > 0)then
						thePay = totalTurfs * 10000
						vRP.giveBankMoney({user_id,thePay})
						vRPtw.notifyPicture(player,{"CHAR_LESTER_DEATHWISH", 9, "FLEECA BANK", false, "Taxa Teritorii: ~g~$"..thePay})
					end	
				end
			end
		end
	end
end)

