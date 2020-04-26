--[[
		 The script is releases for free
		 Author:Jimmy#9999
		 All rights reserved
		 Do not copy the resource without my permission
		 Only for vRP
--]]

local locatie = {x = -522.17541503906, y = -256.66757202148, z = 35.645778656006}

local culoareblips = { --Add location here
   {title="Free Bikes!", colour=2, id=376, x = -522.17541503906, y = -256.66757202148, z = 35.645778656006},
   {title="Free Bikes!", colour=2, id=376, x = -11.1693277359, y = -1099.5509033204, z = 26.672046661376},
}

--------------------------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    for _, info in pairs(culoareblips) do
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

function bicicleta_jimmy()
  local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
  local hash = GetHashKey("bmx") -- Request Model Hash add everything you want
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
        for k in pairs(locatie) do
            -- Draw Marker Here --
            DrawMarker(38, locatie.x,locatie.y,locatie.z, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 0, 255, 200, 1, 0, 2, 1, 0, 0, 0)
            --List Of all Markers is on Fivem Natives
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(locatie) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, -522.53924560546,-257.52703857422,35.639526367188)
            if dist <= 1.40 then
                AddTextEntry("FREE_BIKE", "Apasa ~INPUT_CONTEXT~ Ca sa cumperi o bicicleta gratis!")
                DisplayHelpTextThisFrame("FREE_BIKE",false )
                if IsControlJustPressed(0,51) and IsPedOnFoot(PlayerPedId()) then
                    Citizen.Wait(100)
                    bicicleta_jimmy()
                end
            end
        end
    end
end)


