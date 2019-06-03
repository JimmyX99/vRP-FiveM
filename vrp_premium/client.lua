--[[
		 The script is releases for free
		 This is a Premium Menu with only Permission
		 Author:Jimmy#9999
		 All rights reserved
		 Do not copy the resource without my permission
		 Only for vRP

--]]

vRPCpremium = {}
Tunnel.bindInterface("vRP_premium",vRPCpremium)
Proxy.addInterface("vRP_premium",vRPCpremium)
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP_premium","vRP_premium")

local lastVehicle

function vRPCpremium.teleportOutOfCar(theVehicle)
	thePed = GetPlayerPed(-1)
	local pos = GetEntityCoords(theVehicle, true)
	SetEntityCoords(thePed, pos.x, pos.y, pos.z+1.0)
end

function vRPCpremium.spawnpremiumCar()
	model = GetHashKey("t20")
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

--Car Wash--
RegisterNetEvent('wash:car')
AddEventHandler('wash:car', function ()
	WashDecalsFromVehicle(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1.0)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
end)

-----------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and antiShuffleEnabled then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					vRPserver.denypremiumCarDriving({})
				end
			end
		end
	end
end)

function vRPCpremium.denypremiumCarDriving()
	SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
end
-------------------------------------------------------------------------------------------
