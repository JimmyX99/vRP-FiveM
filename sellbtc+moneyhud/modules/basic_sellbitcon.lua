--[[ 
This Script is created for basic implementation to sell Bitcoins
The Credits : ZED#1337
--]]

local lang = vRP.lang

local SellBTC = {-763.25256347656,-2302.4289550782,13.368670463562}

local function atm_choice_withdraw(player,choice)
	local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        if vRP.tryXZPayment(user_id,5) then
			vRP.giveMoney(user_id,200000)
        else
      vRPclient.notify(player, {"~r~Not enought BTC"})
        end
      end
end

local function atm_choice_withdraw3(player,choice)
	local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        if vRP.tryXZPayment(user_id,500) then
			vRP.giveMoney(user_id,20000000)
        else
      vRPclient.notify(player, {"~r~Not enought BTC"})
        end
      end
end

local function atm_choice_withdraw4(player,choice)
	local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        if vRP.tryXZPayment(user_id,5000) then
			vRP.giveMoney(user_id,200000000)
        else
			vRPclient.notify(player, {"~r~Not enought BTC"})
        end
      end
end

local function atm_choice_withdraw2(player,choice)
	local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        if vRP.tryXZPayment(user_id,50) then
			vRP.giveMoney(user_id,2000000)
        else
			vRPclient.notify(player, {"~r~Not enought BTC"})
        end
      end
end

local btc_menu = {
  name="Bitcoins Trade",
  css={top = "75px", header_color="rgba(0,255,125,0.75)"}
}

----------------------------------------------------------------------------------------------
btc_menu["Sell 5 ₿"] = {atm_choice_withdraw,"Sell 5 ₿ for 200.000💲"}
btc_menu["Sell 50 ₿"] = {atm_choice_withdraw2,"Sell 50 ₿ for 2.000.000💲"}
btc_menu["Sell 500 ₿"] = {atm_choice_withdraw3,"Sell 500 ₿ for 20.000.000💲"}
btc_menu["Sell 5000 ₿"] = {atm_choice_withdraw4,"Sell 5000 ₿ for 200.000.000💲"}

local function btc_enter()
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.openMenu(source,btc_menu) 
  end
end

local function btc_leave()
  vRP.closeMenu(source)
end
-------------------------------------------------------------------------


local function build_client_btc(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
  local x, y, z = table.unpack(SellBTC)
    k = 1
      vRPclient.addMarkerNames(source,{x,y,z, "~w~Sell ~g~BTC", 1, 1.5}) -- BTC MADE BY ME
      vRPclient.addMarkerSign(source,{29,x,y,z-1.9,0.9,0.7,0.9,0,255,72,150,150,true,0,0})
      vRPclient.addBlip(source,{x,y,z,500,3,"BTC Exchange"}) -- BTC MADE BY ME
      vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,255,125,125,150}) -- BTC MADE BY ME

      vRP.setArea(source,"vRP:btc"..k,x,y,z,1,1.5,btc_enter,btc_leave) -- BTC MADE BY ME
  end
end

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
  if first_spawn then
  build_client_btc(source)
  end
end)
