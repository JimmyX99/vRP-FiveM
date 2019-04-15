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

---Sky Fall ---

local isSkyfall = false

function DisplayHelpText(message)
	SetTextComponentFormat("STRING")
	AddTextComponentString(message)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("Skyfall:DoFall")
AddEventHandler('Skyfall:DoFall', function()
	if not isSkyfall then
		isSkyfall = true

		CreateThread(function()
			local playerPed = PlayerPedId()
			local playerPos = GetEntityCoords(playerPed)

			GiveWeaponToPed(playerPed, GetHashKey('gadget_parachute'), 1, true, true)

			DoScreenFadeOut(3000)

			while not IsScreenFadedOut() do
				Wait(0)
			end

			SetEntityCoords(playerPed, playerPos.x, playerPos.y, playerPos.z + 500.0)

			DoScreenFadeIn(2000)

			Wait(2000)

			DisplayHelpText('Skyfall ~b~activated')

			SetPlayerInvincible(playerPed, true)
			SetEntityProofs(playerPed, true, true, true, true, true, false, 0, false)

			while true do
				if isSkyfall then			
					if IsPedInParachuteFreeFall(playerPed) and not HasEntityCollidedWithAnything(playerPed) then
						ApplyForceToEntity(playerPed, true, 0.0, 200.0, 2.5, 0.0, 0.0, 0.0, false, true, false, false, false, true)
					else
						isSkyfall = false
					end
				else

					break
				end

				Wait(0)
			end

			RemoveWeaponFromPed(playerPed, GetHashKey('gadget_parachute'))

			Wait(3000)

			SetPlayerInvincible(playerPed, false)
			SetEntityProofs(playerPed, false, false, false, false, false, false, 0, false)
		end)
	end
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