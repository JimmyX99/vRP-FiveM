--[[
	                PROJECT: vRP_turfs_Wars
			 The Resource is free software 
			 This is my version of Turs-Wars
			 Author:JimmyX#3054
			 Do not copy the resource without my permission
			 C All Rights reserved
--]]

vRP = Proxy.getInterface("vRP")

local start = true

local secondsRemaining = 5*60

function turf_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

Citizen.CreateThread(function()
	TriggerServerEvent('spawnturf')
end)

RegisterNetEvent('timer')
AddEventHandler('timer', function(name,blipColor)
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			if not start then
				secondsRemaining = secondsRemaining - 1
				if secondsRemaining == 0 then
					TriggerServerEvent('vrp:givemoney',name,blipColor)
					TriggerEvent('xdgimi:notify_turfs',50000,blipColor)
					Citizen.Wait(30*60*1000)
					start = true
				end
				if secondsRemaining < 0 then
					secondsRemaining = 5*60
					break
				end
			else
				secondsRemaining = 5*60
				break
			end
		end
	end)
end)

AddEventHandler('timer', function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if not start then
				if secondsRemaining < 300 and secondsRemaining > 0 then
					turf_drawTxt(0.66, 1.44, 1.0,1.0,0.4, "You will win a Turf in : ~b~" .. secondsRemaining .. "~w~ seconds!", 255, 255, 255, 255)
				end
			end
		end
	end)
end)

RegisterNetEvent('createTurfZone:perm')
AddEventHandler('createTurfZone:perm',function(id, x, y, z, blipColor,name)	
	Citizen.CreateThread(function()
		local blip = AddBlipForCoord(x,y,z)
		SetBlipSprite(blip, 161)
		SetBlipScale(blip, 1.2)
		SetBlipColour(blip, blipColor)
		SetBlipAsShortRange(blip, true)
		vRP_createBlip(x,y,z,name,blipColor)
		while true do
			Citizen.Wait(0)
			if start then
				if Vdist(x,y,z,GetEntityCoords(GetPlayerPed(-1))) < 5 then
					info("Press ~INPUT_CONTEXT~ to start a ~b~WAR~w~!")
					if IsControlJustPressed(1, 51) then

						TriggerServerEvent('startwar', id,name,x, y, z,blipColor)

						notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~b~You won the area~w~!", "~r~Be careful, you will be attacked coming soon~w~! ~b~#turf")

						TriggerEvent('timer',name,blipColor)

						start = false
					end
				end
			else
				if Vdist(x,y,z,GetEntityCoords(GetPlayerPed(-1))) < 5 then
					info("The Turf has already started ~b~WAR~w~!")
				end
			end
		end
	end)
end)

RegisterNetEvent('createTurfZone:noperm')
AddEventHandler('createTurfZone:noperm',function(id, x, y, z, blipColor)	
	Citizen.CreateThread(function()
		blip = AddBlipForCoord(x,y,z)
		SetBlipSprite(blip, 161)
		SetBlipScale(blip, 1.2)
		SetBlipColour(blip, blipColor)
		SetBlipAsShortRange(blip, true)

		vRP_createBlip(x,y,z,name,blipColor)

		while true do
			Citizen.Wait(0)
			if Vdist(x,y,z,GetEntityCoords(GetPlayerPed(-1))) < 5 then
				info("You do not have permission to start the ~b~WAR~w~!")
			end
		end
	end)
end)

RegisterNetEvent('createTurfZone:cop')
AddEventHandler('createTurfZone:cop',function(id, x, y, z, blipColor)	
	Citizen.CreateThread(function()
		blip = AddBlipForCoord(x,y,z)
		SetBlipSprite(blip, 161)
		SetBlipScale(blip, 1.2)
		SetBlipColour(blip, blipColor)
		SetBlipAsShortRange(blip, true)

		vRP_createBlip(x,y,z,name,blipColor)

		while true do
			Citizen.Wait(0)
			if Vdist(x,y,z,GetEntityCoords(GetPlayerPed(-1))) < 5 then
				info("~r~You are in a Guvernamental Faction!")
			end
		end
	end)
end)

function vRP_createBlip(x,y,z,name,blipColor)
	Citizen.CreateThread(function()
		local blip = AddBlipForCoord(x, y, z)
		SetBlipSprite(blip, 42)
		SetBlipScale(blip, 1.2)
		SetBlipColour(blip, blipColor)
		SetBlipAsShortRange(blip, true)
		if blipColor == 1 then -- Red
			nameblip = "Los Santos" -- Dangerous Area
		elseif blipColor == 2 then --Blue 
			nameblip = "Las Venturas"  
		elseif blipColor == 3 then -- Green Color
			nameblip = "San Fransisco"
		elseif blipColor == 5 then --Yellow Color
			nameblip = "California" -- Dangerous Area
		elseif blipColor == 27 then -- Purple Color
			nameblip = "Grove Street"
		end
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Mafia: Turf "..nameblip)
		EndTextCommandSetBlipName(blip)
	end)
end

RegisterNetEvent('xdgimi:blip_vcreate')
AddEventHandler('xdgimi:blip_vcreate',function(id,name,x,y,z,blipColor)
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			if not start then
				if Vdist(x,y,z,GetEntityCoords(GetPlayerPed(-1))) > 50 then
					TriggerServerEvent('endwar',id,name,blipColor)
					start = true
					Citizen.Wait(3*1000)
					permite = true
					break
				end
				if vRP.isInComa() then
					TriggerServerEvent('endwar',id,name,blipColor)
					start = true
					Citizen.Wait(3*1000)
					permite = true
					break
				end
			end
		end
	end)
end)

RegisterNetEvent('xdgimi:chat')
AddEventHandler('xdgimi:chat',function(id,name,blipColor)
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(30000)
			if blipColor == 1 then -- Red
				nameblip = "^8Los Santos"
			elseif blipColor == 2 then --Blue 
				nameblip = "^4Las Venturas"
			elseif blipColor == 3 then -- Green Color
				nameblip = "^3San Fransisco"
			elseif blipColor == 5 then --Yellow Color
				nameblip = "^6California"
			elseif blipColor == 27 then -- Purple Color
				nameblip = "^7Grove Street"
			end
			if not started then
				TriggerEvent('chatMessage', '^0[^4TURF^0] ', {255, 0, 0}, "^0 The Turf ^4" .. nameblip .. "^r^0 is conqured by ^9^*".. name .. "^r^0,find the location and kill the boss!")
			end
		end
	end)
end)

function info(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function notifyPicture(icon, type, sender, title, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, type, sender, title, text)
    DrawNotification(false, true)
end

RegisterNetEvent('vrp:notify_endwar')
AddEventHandler('vrp:notify_endwar',function(name,blipColor)
	if blipColor == 1 then
		nameblip = "~r~Los Santos~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 2 then
		nameblip = "~b~Las Venturas~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 3 then
		nameblip = "~y~San Fransisco~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 5 then
		nameblip = "~g~California~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 27 then
		nameblip = "~o~Grove Street~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	end
end)


RegisterNetEvent('xdgimi:notify_turfs_wars_owner')
AddEventHandler('xdgimi:notify_turfs_wars_owner',function(name,blipColor)
	if blipColor == 1 then
		nameblip = "~r~Los Santos~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 2 then
		nameblip = "~b~Las Venturas~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 3 then
		nameblip = "~y~San Fransisco~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 5 then
		nameblip = "~g~California~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 27 then
		nameblip = "~o~Grove Street~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	end
end)


RegisterNetEvent('xdgimi:notify_turfs_wars')
AddEventHandler('xdgimi:notify_turfs_wars',function(name,blipColor)
	if blipColor == 1 then
		nameblip = "~r~Los Santos~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 2 then
		nameblip = "~b~Las Venturas~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 3 then
		nameblip = "~y~San Fransisco~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 5 then
		nameblip = "~g~California~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 27 then
		nameblip = "~o~Grove Street~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	end
end)


RegisterNetEvent('xdgimi:notify_turfs_wars_continue')
AddEventHandler('xdgimi:notify_turfs_wars_continue',function(money,blipColor)
	if blipColor == 1 then
		nameblip = "~r~Los Santos~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 2 then
		nameblip = "~b~Las Venturas~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 3 then
		nameblip = "~y~San Fransisco~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 5 then
		nameblip = "~g~California~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	elseif blipColor == 27 then
		nameblip = "~o~Grove Street~w~"
		notifyPicture("CHAR_AMMUNATION", 2, "~r~Turfs ~g~| Notificare", "~w~The Turf "..nameblip.." is down by~w~!", "~b~"..name.."~w~the boss is die or left the are ~b~#turf")
	end
end)
