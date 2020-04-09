local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_biju")

--Reward ZED NU UITA---
local biju = math.random(3,13)
local banirec = math.random(525,5974)
local primesti = math.random(5120,7421)

RegisterServerEvent("jaflabijuterii:serverstart")
AddEventHandler("jaflabijuterii:serverstart", function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local sias = vRP.getOnlineUsersByFaction({"SIAS"}) 
    local cops = vRP.getOnlineUsersByFaction({"Politie"})
    local sriagent = vRP.getOnlineUsersByFaction({"SRI"})
    local smurd = vRP.getOnlineUsersByFaction({"Smurd"})
     if (vRP.isUserInFaction({user_id,"SIAS"}) or vRP.isUserInFaction({user_id,"Politie"}) or vRP.isUserInFaction({user_id,"Smurd"}) or vRP.isUserInFaction({user_id,"SRI"})) then
         vRPclient.notify(player,{"~r~Factiunile guvernamentale nu pot da jaf."})
         return		
     else
         local enforcers = tonumber(#cops) + tonumber(#sias) + tonumber(#sriagent) + tonumber(#smurd)
        if (enforcers >= 4) then
            TriggerClientEvent("jaflabijuterii:start", source)
            for i, v in pairs(sias) do
                local thePlayer = vRP.getUserSource({v})
                TriggerClientEvent('chatMessage', thePlayer, '[Magazin de Bijuteri]', {255, 0, 0}, "Jaf in progres la Magazinul ^9Vangelico(Jewllery) ^7Info:vezi pe harta blips ul diamant")
            end
            for i, v in pairs(cops) do
                local thePlayer = vRP.getUserSource({v})
                TriggerClientEvent('chatMessage', thePlayer, '[Magazin de Bijuteri]', {255, 0, 0}, "Jaf in progres la Magazinul ^99Vangelico(Jewllery) ^7Info:vezi pe harta blips ul diamant")
            end
            for i, v in pairs(cops) do
                local thePlayer = vRP.getUserSource({v})
                TriggerClientEvent('chatMessage', thePlayer, '[Magazin de Bijuteri]', {255, 0, 0}, "Jaf in progres la Magazinul ^9ZED(Jewllery) ^7Info:vezi pe harta blips ul diamant")
            end
            TriggerClientEvent('chatMessage', -1, '[Magazin de Bijuteri]', {255, 0, 0}, "^4Politia ^0alerteaza ^3civili ^0sa aiba grija la ^9Magazinul ZED(Jewllery)^7Info:vezi pe harta blips ul diamant")
        else
             vRPclient.notify(player,{"~r~Nu sunt destui politisti in oras."})
        end
    end
end)


RegisterServerEvent('jaflabijuterii:sucess')
AddEventHandler('jaflabijuterii:sucess', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if(user_id)then
        vRP.giveInventoryItem({user_id,"bijuterii",biju,true})
        vRPclient.setGPS(player,{1524.5561523438,1709.8217773438,110.01612091064})
    end
end)

RegisterServerEvent('jaflabijuterii:sucessRW1')
AddEventHandler('jaflabijuterii:sucessRW1', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if(user_id)then
        vRP.giveInventoryItem({user_id,"bijuterii",1,true})
        vRPclient.setGPS(player,{1524.5561523438,1709.8217773438,110.01612091064})
    end
end)

RegisterServerEvent('jaflabijuterii:sucessMO')
AddEventHandler('jaflabijuterii:sucessMO', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if(user_id)then
        vRP.giveInventoryItem({user_id,"dirty_money",banirec,true})
    end
end)

RegisterServerEvent('jaflabijuterii:allarmpolice')
AddEventHandler('jaflabijuterii:allarmpolice', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local sias = vRP.getOnlineUsersByFaction({"SIAS"}) 
    local cops = vRP.getOnlineUsersByFaction({"Politie"})
    local sriagent = vRP.getOnlineUsersByFaction({"SRI"})
    if #cops or #sias or #sriagent then
        vRPclient.setGPS(player,-630.17553710938,-236.52540588379,38.0570602416992-0.95)
        vRPclient.notifyPicture(player,{"CHAR_CALL911",1,"Alerta Politie",false,"~r~In acest monment este jaf la magazinul de bijuterii"})
    end
end)
