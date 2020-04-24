--[[
	                PROJECT: vRP_turfs_Wars
			 The Resource is free software 
			 This is my version of Turs-Wars
			 Author:JimmyX#3054
			 Do not copy the resource without my permission
			 C All Rights reserved
                     
--]]

vRPtwc = {}
Tunnel.bindInterface("vRP_turf_wars",vRPtwc)
Proxy.addInterface("vRP_turf_wars",vRPtwc)
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP_turf_wars","vRP_turf_wars")

turfAreas = {}
turfIcons = {}

function vRPtwc.createTurfZone(id, x, y, z, radius, blipColor)	
	turfAreas[id] = AddBlipForRadius(x, y, z, radius)
	SetBlipSprite(turfAreas[id], 9)
	SetBlipAlpha(turfAreas[id], 80)
	SetBlipColour(turfAreas[id], blipColor)
	
	vRPtwc.createTurfIcon(id, x, y, z)
end

function vRPtwc.createTurfIcon(id, x, y, z)
	turfIcons[id] = AddBlipForCoord(x, y, z)
	SetBlipSprite(turfIcons[id], 310)
	SetBlipScale(turfIcons[id], 1.0)
	SetBlipColour(turfIcons[id], 1)
	SetBlipAsShortRange(turfIcons[id], true)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Turf")
    EndTextCommandSetBlipName(turfIcons[id])
end

function vRPtwc.notifyPicture(icon, type, sender, title, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, type, sender, title, text)
    DrawNotification(false, true)
end
