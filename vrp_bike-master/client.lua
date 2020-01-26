--[[
		 The script is releases for free
		 This is a Premium Menu with only Permission
		 Author:Jimmy#9999
		 All rights reserved
		 Do not copy the resource without my permission
		 Only for vRP
--]]

local table = { 
    {x = -522.17541503906, y = -256.66757202148, z = 35.645778656006},
    {x = -11.1693277359, y = -1099.5509033204, z = 26.672046661376},
}

local blips = { --Add location here
   {title="Free Bikes!", colour=2, id=376, x = -522.17541503906, y = -256.66757202148, z = 35.645778656006},
   {title="Free Bikes!", colour=2, id=376, x = -11.1693277359, y = -1099.5509033204, z = 26.672046661376},
}

--------------------------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 3)
    SetBlipScale(info.blip, 0.7)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
  end
end)

function hash_bike()
  local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
  local hash = GetHashKey("bmx")  
  local ve =   CreateVehicle(hash,plyCoords, true, false)
  local ped = GetPlayerPed(-1)
  
  RequestModel(hash)
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Citizen.Wait(0)
    end
  
    if ve then
        SetPedIntoVehicle(ped, ve, -1)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(table) do
            -- Draw Marker Here --
            DrawMarker(38, -523.30078125,-257.3540649414,35.646186828614, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 0, 255, 200, 1, 0, 2, 1, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(table) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -522.53924560546,-257.52703857422,35.639526367188)
            if dist <= 1.40 then
                AddTextEntry("FREE_BIKE", "Press ~INPUT_CONTEXT~ for buy a free bmx!")
                DisplayHelpTextThisFrame("FREE_BIKE",false )
                if IsControlJustPressed(0,51) and IsPedOnFoot(PlayerPedId()) then
                    Citizen.Wait(100)  
                    hash_bike()
                end
            end
        end
    end
end)

