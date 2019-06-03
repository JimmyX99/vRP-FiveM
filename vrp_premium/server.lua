--[[
		 The script is releases for free
		 This is a Premium Menu with only Permission
		 Author:Jimmy#9999
		 All rights reserved
		 Do not copy the resource without my permission
		 Only for vRP

--]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPp = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_premium")
BMclient = Tunnel.getInterface("vRP_premium","vRP_premium")
Tunnel.bindInterface("vRP_premium",vRPp)
Proxy.addInterface("vRP_premium",vRPp)

spUtils = {}
spCars = {}
spTags = {}

local function sp_fixCar(player, choice)
	user_id = vRP.getUserId({player})
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		TriggerClientEvent('murtaza:fix', player)
		vRPclient.notify(player, {"~y~[Premium] ~g~You fixed this car!"})
	else
		vRPclient.notify(player, {"~y~[Premium] ~r~Wait 1 minute to recharge the abilities"})
		return
	end
end

local function sp_revive(player, choice)
	user_id = vRP.getUserId({player})
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		vRPclient.varyHealth(player,{200})
		vRP.varyThirst({user_id, -100})
		vRP.varyHunger({user_id, -100})
		SetTimeout(500, function()
			vRPclient.varyHealth(player,{200})
			vRP.varyThirst({user_id, -100})
			vRP.varyHunger({user_id, -100})
		end)
		vRPclient.notify(player, {"~y~[Premium] ~g~The healthbar is full"})
	else
		vRPclient.notify(player, {"~y~[Premium] ~r~Wait 1 minute to recharge the abilities"})
		return
	end
end

local function sp_weapons(player, choice)
	user_id = vRP.getUserId({player})
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		vRPclient.giveWeapons(player,{{
			["WEAPON_COMBATPISTOL"] = {ammo=100},
			["WEAPON_ASSAULTSMG"] = {ammo=200},
			["WEAPON_MACHETE"] = {ammo=1},
			["WEAPON_SPECIALCARBINE"] = {ammo=200},
			["WEAPON_PUMPSHOTGUN"] = {ammo=100},
			["WEAPON_MG"] = {ammo=100}
		}})
		vRPclient.notify(player, {"~y~[Premium] ~g~You got a pack with weapons"})
	else
		vRPclient.notify(player, {"~y~[Premium] ~r~Wait 1 minute to recharge the abilities!"})
		return
	end
end

local function sp_spawnCar(player, choice)
	BMclient.spawnSponsorCar(player, {})
end

local function sp_chatTag(player, choice)
	vRP.prompt({player, "Tag:", "", function(player, theTag)
		if(string.len(theTag) <= 10)then
			user_id = vRP.getUserId({player})
			spTags[user_id] = tostring(theTag)
			vRPclient.notify(player, {"[Premium] ~g~Custom tag : ~b~"..theTag})
		else
			vRPclient.notify(player, {"[Premium] ~r~Your chat tag is!"})
			return
		end
	end})
end

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		if vRP.hasPermission({user_id, "player.premium"}) then
			choices["Premium Menu"] = {function(player,choice)
				vRP.buildMenu({"💰Premium Menu💰", {player = player}, function(menu)
					menu.name = "💰Premium Menu💰"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
					menu["Sky Dive"] = {sp_skyfall,"☁️  > Description"}
					menu["Fix Vehicle"] = {sp_fixCar,"🔧 > Description"}
					menu["Full HealthBar"] = {sp_revive,"🏥 > Description"}
					menu["Weapons Packet "] = {sp_weapons,"🔫 > Description"}
					menu["Premium Car"] = {sp_spawnCar,"🏎️ > Description"}
					menu["Custom Chat Tag"] = {sp_chatTag,"🏷️ > Description"}
					vRP.openMenu({player,menu})
				end})
			end, "Premium Menu"}
		end
		add(choices)
	end
end})

function vRPp.denySponsorCarDriving()
	user_id = vRP.getUserId({source})
	if not(vRP.hasPermission({user_id, "player.premium"}))then
		BMclient.denySponsorCarDriving(source, {})
	end
end

function vRPp.getSponsorTag(user_id)
	user_id = tonumber(user_id)
	if(spTags[user_id] == nil)then
		return false
	else
		theTag = spTags[user_id]
		return theTag
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		users = vRP.getUsers({})
		for i, v in pairs(users) do
			if(vRP.hasPermission({i, "player.premium"})) and (spUtils[i] == true)then
				spUtils[i] = nil
				vRPclient.notify(v, {"~y~[Premium] ~b~Now, you can use your abilities!"})
			end
		end
	end
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
	if(spCars[user_id] ~= nil)then
		BMclient.deleteSponsorCar(-1, {spCars[user_id]})
		spCars[user_id] = nil
	end
	if(spTags[user_id] ~= nil)then
		spTags[user_id] = nil
	end
end)

RegisterNetEvent("baseevents:enteringVehicle")
AddEventHandler("baseevents:enteringVehicle", function(theVehicle, theSeat, vehicleName)
	thePlayer = source
	user_id = vRP.getUserId({thePlayer})
	if(theSeat == -1) and (vehicleName == "t20")then
		if not(vRP.hasPermission({user_id, "player.premium"}))then
			BMclient.teleportOutOfCar(thePlayer, {theVehicle})
			vRPclient.notify(thePlayer, {"[Premium] ~r~You can not drive the Premium car!"})
		end
	end
end)

RegisterNetEvent("baseevents:enteredVehicle")
AddEventHandler("baseevents:enteredVehicle", function(theVehicle, theSeat, vehicleName)
	thePlayer = source
	user_id = vRP.getUserId({thePlayer})
	if(theSeat == -1) and (vehicleName == "t20")then
		if not(vRP.hasPermission({user_id, "player.premium"}))then
			BMclient.teleportOutOfCar(thePlayer, {theVehicle})
			vRPclient.notify(thePlayer, {"[Premium] ~r~You can not drive the Premium car!"})
		end
	end
end)
