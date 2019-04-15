--[[
		 The script is releases for free
		 This is a Youtuber Menu with only Permission
		 Author:Gimi#0001
		 All rights reserved
		 Do not copy the resource without my permission
		 Only for vRP
--]]
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPyt = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_youtuber")
BMclient = Tunnel.getInterface("vRP_youtuber","vRP_youtuber")
Tunnel.bindInterface("vRP_youtuber",vRPyt)
Proxy.addInterface("vRP_youtuber",vRPyt)

ytUtils = {}
ytCars = {}
ytTags = {}

local function yt_fixCar(player, choice)
	user_id = vRP.getUserId({player})
	if(ytUtils[user_id] ~= true)then
		ytUtils[user_id] = true
		TriggerClientEvent('murtaza:fix', player)
		vRPclient.notify(player, {"~y~[Youtuber] ~g~You fixed the Vehicle!"})
	else
		vRPclient.notify(player, {"~y~[Youtuber] ~r~Wait 1 minute to recharge the abilities!"})
		return
	end
end

local function yt_skyfall(player, choice)
	user_id = vRP.getUserId({player})
	if(ytUtils[user_id] ~= true)then
		ytUtils[user_id] = true
		TriggerClientEvent('Skyfall:DoFall', player)
		vRPclient.notify(player, {"~r~[Youtuber] ~g~Ai grija sa activezi parasuta!"})
	else
		vRPclient.notify(player, {"~r~[Waiting]~r~Wait 1 minute to recharge the abilities"})
	end	
end

local function yt_rev(player, choice)
	user_id = vRP.getUserId({player})
		vRPclient.isInComa(player,{}, function(in_coma)
			if in_coma then
				vRPclient.varyHealth(player,{100}) 
				SetTimeout(1000, function()
					vRPclient.varyHealth(player,{100})
			end)
				vRPclient.notify(player,{"~r~[Youtuber]~g~You have received revive!"})
		else
				vRPclient.notify(player,{"~r~[Youtuber] ~r~You are not dead!"})
		end
	end)
end

local function yt_revive(player, choice)
	user_id = vRP.getUserId({player})
	if(ytUtils[user_id] ~= true)then
		ytUtils[user_id] = true
		vRPclient.varyHealth(player,{200})
		vRP.varyThirst({user_id, -100})
		vRP.varyHunger({user_id, -100})
		SetTimeout(500, function()
			vRPclient.varyHealth(player,{200})
			vRP.varyThirst({user_id, -100})
			vRP.varyHunger({user_id, -100})
		end)
		vRPclient.notify(player, {"~y~[Youtuber] ~g~You have the full HealthBar now!"})
	else
		vRPclient.notify(player, {"~y~[Youtuber] ~r~Wait 1 minute to recharge the abilities!"})
		return
	end
end

local function yt_weapons(player, choice)
	user_id = vRP.getUserId({player})
	if(ytUtils[user_id] ~= true)then
		ytUtils[user_id] = true
		vRPclient.giveWeapons(player,{{
			["WEAPON_COMBATPISTOL"] = {ammo=100},
			["WEAPON_ASSAULTSMG"] = {ammo=200},
			["WEAPON_MACHETE"] = {ammo=1},
			["WEAPON_SPECIALCARBINE"] = {ammo=200},
			["WEAPON_PUMPSHOTGUN"] = {ammo=100},
			["WEAPON_MG"] = {ammo=100}
		}})
		vRPclient.notify(player, {"~y~[Youtuber] ~g~You received the Weapons Pack!"})
	else
		vRPclient.notify(player, {"~y~[Youtuber] ~r~Wait 1 minute to recharge the abilities!"})
		return
	end
end

local function yt_ChildSkin(player, choice)
	BMclient.setYoutuberSkin(player,{4})
end

local function yt_blackracerSkin(player, choice)
	BMclient.setGimiSkin(player,{4})
end

local function yt_ytawnCar(player, choice)
	BMclient.spawnYoutuberCar(player, {})
end


vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		if vRP.hasGroup({user_id, "youtuber"}) then
			choices["🎥Youtuber Menu🎥"] = {function(player,choice)
				vRP.buildMenu({"🎥Youtuber Menu🎥", {player = player}, function(menu)
					menu.name = "🎥Youtuber Menu🎥"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
					menu["Sky Fall"] = {yt_skyfall,"☁️  > Change the text with your description"}
					menu["Fix Vehicle"] = {yt_fixCar,"🔧 > Change the text with your description"}
					menu["Give Health&Food&Drink"] = {yt_revive,"🏥 > Change the text with your description"}
					menu["Youtuber Revive"] =  {yt_rev,"🔮 > Change the text with your description"}
					menu["Weapons Pack"] = {yt_weapons,"🔫 > Change the text with your description"}
					menu["Youtuber Car"] = {yt_ytawnCar,"🏎️ > Change the text with your description"}
					menu["Black Racer"] = {yt_blackracerSkin,"💥 > Change the text with your description</br>(Change the text with your description)"}
					menu["Child Skin"] = {yt_ChildSkin,"👶🏻 > Change the text with your description</br>(Change the text with your description)"}
					vRP.openMenu({player,menu})
				end})
			end, "🎥Youtuber Facilities🎥"}
		end
		add(choices)
	end
end})

function vRPyt.denyYoutuberCarDriving()
	user_id = vRP.getUserId({source})
	if not(vRP.hasGroup({user_id, "youtuber"}))then
		BMclient.denyYoutuberCarDriving(source, {})
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		users = vRP.getUsers({})
		for i, v in pairs(users) do
			if(vRP.hasGroup({i, "youtuber"})) and (ytUtils[i] == true)then
				ytUtils[i] = nil
				vRPclient.notify(v, {"~y~[Youtuber] ~b~Now you can use the Youtuber Facilities!"})
			end
		end
	end
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
	if(ytCars[user_id] ~= nil)then
		BMclient.deleteYoutuberCar(-1, {ytCars[user_id]})
		ytCars[user_id] = nil
	end
	if(ytTags[user_id] ~= nil)then
		ytTags[user_id] = nil
	end
end)

RegisterNetEvent("baseevents:enteringVehicle")
AddEventHandler("baseevents:enteringVehicle", function(theVehicle, theSeat, vehicleName)
	thePlayer = source
	user_id = vRP.getUserId({thePlayer})
	if(theSeat == -1) and (vehicleName == "DELUXO")then
		if not(vRP.hasGroup({user_id, "youtuber"}))then
			BMclient.teleportOutOfCar(thePlayer, {theVehicle})
			vRPclient.notify(thePlayer, {"[Youtuber] ~w~You do not drive a ~r~Youtuber Car"})
		end
	end
end)

RegisterNetEvent("baseevents:enteredVehicle")
AddEventHandler("baseevents:enteredVehicle", function(theVehicle, theSeat, vehicleName)
	thePlayer = source
	user_id = vRP.getUserId({thePlayer})
	if(theSeat == -1) and (vehicleName == "DELUXO")then
		if not(vRP.hasGroup({user_id, "youtuber"}))then
			BMclient.teleportOutOfCar(thePlayer, {theVehicle})
			vRPclient.notify(thePlayer, {"[Youtuber]~w~You do not drive a ~r~Youtuber Car"})
		end
	end
end)