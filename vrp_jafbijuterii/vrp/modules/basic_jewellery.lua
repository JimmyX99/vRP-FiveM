--[[
           Sell Jewllery Script 
           Author:Jimmy#1337
           Don't upload the resource without my permission
           All rights reserved ©
--]]

local lang = vRP.lang

---------Don t touch --------------
local x = 1524.5561523438
local y = 1709.8217773438
local z = 110.01612091064

-------------Require for vrp_biju Script-------------------

--Jewellery SELLING | FIXED--
local function biju_jimmy(player,choice)
  local user_id = vRP.getUserId(source)
  local suma = math.random(20000,30000)
  local bij1 = 5
  local bij = "bijuterii"
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id,bij,bij1,true) then
        vRP.giveMoney(user_id,suma)
        vRPclient.notify(player, {"Ai primit ~g~"..suma.." de $"})
      else
        vRPclient.notify(player,{"~r~Ti s-au terminat bijuteriile!"})
      end
    end
end

local function biju_jimmy2(player,choice)
  local user_id = vRP.getUserId(source)
  local suma1 = math.random(30000,40000)
  local bij2 = 10
  local bij = "bijuterii"
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id,bij,bij2,true) then
          vRP.giveMoney(user_id,suma1)
          vRPclient.notify(player, {"Ai primit ~g~"..suma1.." de $"})
      else
        vRPclient.notify(player,{"~r~Ti s-au terminat bijuteriile!"})
      end
    end
end

local function biju_jimmy3(player,choice)
  local user_id = vRP.getUserId(source)
  local suma2 = math.random(40000,50000)
  local bij3 = 15
  local bij = "bijuterii"
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id,bij,bij3,true) then
          vRP.giveMoney(user_id,suma2)
          vRPclient.notify(player, {"Ai primit ~g~"..suma2.." de $"})
      else
        vRPclient.notify(player,{"~r~Ti s-au terminat bijuteriile!"})
      end
    end
end

local biju_menu = {
  name="Vanzare Bijuterii",
  css={top = "75px", header_color="rgba(0,255,125,0.75)"}
}


biju_menu["Sell 5💎"] = {biju_jimmy,"Sell 5💎 for a random amount"}
biju_menu["Sell 10💎"] = {biju_jimmy2,"Sell 10💎 for a random amount"}
biju_menu["Sell 15💎"] = {biju_jimmy3,"Sell 15💎 for a random amount"}


local function sell_inside()
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.openMenu(source,biju_menu) 
  end
end

local function sell_outside()
  vRP.closeMenu(source)
end

local function jimmy_biju(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
	  k = 1
      vRPclient.addBlip(source,{x,y,z,431,49,"Sell Jewllery"})
      vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,255,178,0,125,150})
      vRPclient.addMarkerSign(source,{x,y,z-1.25,0.45, 0.45, 0.45, 255, 178, 0,150,150,1,false,0})
      vRPclient.addMarkerNames(source,{x,y,z+0.570, "~r~Sell\n~b~Jewellery", 1, 1.2})
      vRP.setArea(source,"vRP:biju"..k,x,y,z,1,1.5,sell_inside,sell_outside)
  end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
  if first_spawn then
    jimmy_biju(source)
  end
end)

