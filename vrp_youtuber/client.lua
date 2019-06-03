--[[
		 The script is releases for free
		 This is a Youtuber Menu with only Permission
		 Author:Gimi#0001
		 All rights reserved
		 Do not copy the resource without my permission
		 Only for vRP
--]]

vRPCyoutuber = {}
Tunnel.bindInterface("vRP_youtuber",vRPCyoutuber)
Proxy.addInterface("vRP_youtuber",vRPCyoutuber)
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP_youtuber","vRP_youtuber")

local lastVehicle

function vRPCyoutuber.setYoutuberSkin(skinID)
	if(skinsID == 2)then
		model = "sithyoda"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	elseif(skinID == 3)then
		model = "leona"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	elseif(skinID == 4)then
		model = "Child"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	end
end

function vRPCyoutuber.setXDSkin(skinID)
	if(skinsID == 2)then
		model = "Idk"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
	elseif(skinID == 4)then
		model = "sithyoda"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	end
end

function vRPCyoutuber.setGimiSkin(skinID)
	if(skinsID == 2)then
		model = "Idk"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
	elseif(skinsID == 3)then
		model = "sithyoda"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	elseif(skinID == 4)then
		model = "blackracer"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	end
end

function vRPCyoutuber.setDXSkin(skinID)
	if(skinsID == 2)then
		model = "Idk"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
	elseif(skinID == 4)then
		model = "JackSparrow"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	end
end


function vRPCyoutuber.teleportOutOfCar(theVehicle)
	thePed = GetPlayerPed(-1)
	local pos = GetEntityCoords(theVehicle, true)
	SetEntityCoords(thePed, pos.x, pos.y, pos.z+1.0)
end

function vRPCyoutuber.spawnYoutuberCar()
	model = GetHashKey("deluxo")--Youtuber Car
	ped = GetPlayerPed(-1)
	
	if not lastVehicle and GetVehiclePedIsIn(ped, false) then
		lastVehicle = GetVehiclePedIsIn(ped, false)
	end
	
	x, y, z = table.unpack(GetEntityCoords(ped, true))
	
	local i = 0
	while not HasModelLoaded(model) and i < 1000 do
		RequestModel(model)
		Citizen.Wait(10)
		i = i+1
	end
	if HasModelLoaded(model) then
		local veh = CreateVehicle( model, x, y, z + 1, heading, true, true )
		
		SetPedIntoVehicle(ped, veh, -1)
	
		if (lastVehicle) then
			SetEntityAsMissionEntity(lastVehicle, true, true)
			DeleteVehicle(lastVehicle)
		end
		
		lastVehicle = veh
		UpdateVehicleFeatureVariables( veh )
		toggleRadio(ped)

		SetModelAsNoLongerNeeded( veh )
	end
end

---SkyFAll for Youtuber ---

local isSkyfall = false

function DisplayHelpText(message)
	SetTextComponentFormat("STRING")
	AddTextComponentString(message)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


-----------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and antiShuffleEnabled then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					vRPserver.denySponsorCarDriving({})
				end
			end
		end
	end
end)

function vRPCyoutuber.denySponsorCarDriving()
	SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
end
