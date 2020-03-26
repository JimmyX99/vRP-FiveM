local lang = vRP.lang

local playerMoney = {}

-- Money module, wallet/bank API
-- The money is managed with direct SQL requests to prevent most potential value corruptions
-- the wallet empty itself when respawning (after death)

MySQL.createCommand("vRP/money_tables", [[
CREATE TABLE IF NOT EXISTS vrp_user_moneys(
  user_id INTEGER,
  wallet INTEGER,
  bank INTEGER,
  transfer_limit INTEGER,
  last_transfer_time TIMESTAMP,
  CONSTRAINT pk_user_moneys PRIMARY KEY(user_id),
  CONSTRAINT fk_user_moneys_users FOREIGN KEY(user_id) REFERENCES vrp_users(id) ON DELETE CASCADE
);
]])


MySQL.createCommand("vRP/money_logs", [[
CREATE TABLE IF NOT EXISTS vrp_money_logs(
  from_user_id INTEGER,
  to_user_id INTEGER,
  amount INTEGER,
  time TIMESTAMP
);
]])

--MySQL.createCommand("vRP/money_init_user","INSERT IGNORE INTO vrp_user_moneys(user_id,wallet,bank,xzCoins,diamonds, transfer_limit, last_transfer_time) VALUES(@user_id,@wallet,@bank, @xzCoins, @diamonds, 1000000, SYSDATE())")
MySQL.createCommand("vRP/get_money","SELECT * FROM vrp_users WHERE id = @user_id")
MySQL.createCommand("vRP/set_money","UPDATE vrp_user_moneys SET transfer_limit = @transfer_limit, last_transfer_time = FROM_UNIXTIME(@last_transfer_time) WHERE user_id = @user_id")
MySQL.createCommand("vRP/log_money","INSERT IGNORE INTO vrp_money_logs (from_user_id, to_user_id, amount,time) VALUES(@from_user_id,@to_user_id, @amount, SYSDATE())")

--SAVE
MySQL.createCommand("vRP/save_xzCoins","UPDATE vrp_users SET xzCoins = @xzCoins WHERE id = @user_id")
MySQL.createCommand("vRP/save_diamonds","UPDATE vrp_users SET diamonds = @diamonds WHERE id = @user_id")
MySQL.createCommand("vRP/save_bank","UPDATE vrp_users SET bankMoney = @bank WHERE id = @user_id")
MySQL.createCommand("vRP/save_wallet","UPDATE vrp_users SET walletMoney = @wallet WHERE id = @user_id")

-- init tables
MySQL.execute("vRP/money_logs")

-- load config
local cfg = module("cfg/money")

-- API

-- get money
-- cbreturn nil if error
function vRP.getMoney(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].wallet
	else
		return 0
	end
end

-- set xzCoins
function vRP.setXZCoins(user_id,value)

	if(playerMoney[user_id])then
		playerMoney[user_id].xzCoins = value
	end
	MySQL.execute("vRP/save_xzCoins", {xzCoins = value, user_id = user_id})

	-- update client display
	local source = vRP.getUserSource(user_id)
	if source ~= nil then
		vRPclient.setDivContent(source,{"xzCoins",lang.money.xzCoins({vRP.formatMoney(value)})})
	end
end

-- set diamonds
function vRP.setdiamonds(user_id,value)
	if(playerMoney[user_id])then
		playerMoney[user_id].diamonds = value
	end
	MySQL.execute("vRP/save_diamonds", {diamonds = value, user_id = user_id})

  -- update client display
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    vRPclient.setDivContent(source,{"diamonds",lang.money.diamonds({vRP.formatMoney(value)})})
  end
end

-- get xzCoins
-- cbreturn nil if error
function vRP.getXZCoins(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].xzCoins
	else
		return 0
	end
end

-- get diamonds
-- cbreturn nil if error
function vRP.getdiamonds(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].diamonds
	else
		return 0
	end
end

-- set money
function vRP.setMoney(user_id,value)
	if(tonumber(value) >= 0)then
		if(playerMoney[user_id])then
			playerMoney[user_id].wallet = value
		end
		MySQL.execute("vRP/save_wallet", {wallet = value, user_id = user_id})
	end

  -- update client display
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    vRPclient.setDivContent(source,{"money",lang.money.display({vRP.formatMoney(value)})})
  end
end

--[[
-- get transfer limit 
function vRP.getTransferLimit(user_id)
    return 1000000
end

-- set transfer limit 
function vRP.setTransferLimit(user_id,value)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.transfer_limit = value
	end
end
--]]

-- try a payment
-- return true or false (debited if true)
function vRP.tryPayment(user_id,amount)
  local money = vRP.getMoney(user_id)
  if (money >= amount) and (amount >= 0) then
    vRP.setMoney(user_id,money-amount)
    return true
  else
    return false
  end
end

 -- try a payment BTC
-- return true or false (debited if true)
function vRP.tryXZPayment(user_id,amount)
  local money = vRP.getXZCoins(user_id)
  if money >= amount then
    vRP.setXZCoins(user_id,money-amount)
    return true
  else
    return false
  end
end 

--try Diamonds Payments
function vRP.tryDMPayment(user_id,amount)
  local money = vRP.getdiamonds(user_id)
  if money >= amount then
    vRP.setdiamonds(user_id,money-amount)
    return true
  else
    return false
  end
end 

-- give money
function vRP.giveMoney(user_id,amount)
  local money = vRP.getMoney(user_id)
  vRP.setMoney(user_id,money+amount)
end

-- take money
function vRP.takeMoney(user_id,amount)
	local Money = vRP.getMoney(user_id)
	local newMoney = Money - amount
	vRP.setMoney(user_id,newMoney)
end

-- take btc
function vRP.takebtc(user_id,amount)
	local BTC = vRP.getXZCoins(user_id)
	local newBTC = BTC - amount
	vRP.setXZCoins(user_id,newBTC)
end

-- take dmd
function vRP.takedmd(user_id,amount)
	local DMD = vRP.getdiamonds(user_id)
	local newDMD = DMD - amount
	vRP.setdiamonds(user_id,newDMD)
end

-- give xzCoins
function vRP.giveXZCoins(user_id,amount)
  local xzCoins = vRP.getXZCoins(user_id)
  vRP.setXZCoins(user_id,xzCoins+amount)
end

-- give diamonds
function vRP.givediamonds(user_id,amount)
  local diamonds = vRP.getdiamonds(user_id)
  vRP.setdiamonds(user_id,diamonds+amount)
end

-- get bank money
function vRP.getBankMoney(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].bank
	else
		return 0
	end
end

-- set bank money
function vRP.setBankMoney(user_id,value)
	if(playerMoney[user_id])then
		playerMoney[user_id].bank = value
	end
	MySQL.execute("vRP/save_bank", {bank = value, user_id = user_id})
	local source = vRP.getUserSource(user_id)
	if source ~= nil then
		vRPclient.setDivContent(source,{"bmoney",lang.money.bdisplay({vRP.formatMoney(value)})})
	end
end

-- give bank money
function vRP.giveBankMoney(user_id,amount)
  if amount > 0 then
    local money = vRP.getBankMoney(user_id)
    vRP.setBankMoney(user_id,money+amount)
  end
end

-- try a withdraw
-- return true or false (withdrawn if true)
function vRP.tryWithdraw(user_id,amount)
  local money = vRP.getBankMoney(user_id)
  if amount > 0 and money >= amount then
    vRP.setBankMoney(user_id,money-amount)
    vRP.giveMoney(user_id,amount)
    return true
  else
    return false
  end
end

-- try a deposit
-- return true or false (deposited if true)
function vRP.tryDeposit(user_id,amount)
  if amount > 0 and vRP.tryPayment(user_id,amount) then
    vRP.giveBankMoney(user_id,amount)
    return true
  else
    return false
  end
end

-- try full payment (wallet + bank to complete payment)
-- return true or false (debited if true)
function vRP.tryFullPayment(user_id,amount)
  local money = vRP.getMoney(user_id)
  if money >= amount  and (amount >= 0) then -- enough, simple payment
    return vRP.tryPayment(user_id, amount)
  else  -- not enough, withdraw -> payment
    if vRP.tryWithdraw(user_id, amount-money) then -- withdraw to complete amount
      return vRP.tryPayment(user_id, amount)
    end
  end

  return false
end

--function vRP.logMoney(from_user_id,to_user_id,amount)
  --MySQL.execute("vRP/log_money", {from_user_id = from_user_id, to_user_id = to_user_id,amount = amount})
  --return false
--end

-- events, init user account if doesn't exist at connection
AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	MySQL.query("vRP/get_money", {user_id = user_id}, function(rows, affected)
		if #rows > 0 then
			playerMoney[user_id] = {bank = rows[1].bankMoney, wallet = rows[1].walletMoney, xzCoins = rows[1].xzCoins, diamonds = rows[1].diamonds}
		end
	end)
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
	playerMoney[user_id] = nil
end)

-- money hud
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    -- add money display
    vRPclient.setDiv(source,{"money",cfg.display_css,lang.money.display({vRP.formatMoney(vRP.getMoney(user_id))})})
	vRPclient.setDiv(source,{"bmoney",cfg.display_css,lang.money.bdisplay({vRP.formatMoney(vRP.getBankMoney(user_id))})})
	vRPclient.setDiv(source,{"xzCoins",cfg.display_css,lang.money.xzCoins({vRP.formatMoney(vRP.getXZCoins(user_id))})})
	vRPclient.setDiv(source,{"diamonds",cfg.display_css,lang.money.diamonds({vRP.formatMoney(vRP.getdiamonds(user_id))})})
  end
end)

local function ch_give(player,choice)
	-- get nearest player
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRPclient.getNearestPlayers(player,{15},function(nplayers)
			usrList = ""
			for k,v in pairs(nplayers) do
				usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
			end
			if usrList ~= "" then
				vRP.prompt(player,"Players Nearby: " .. usrList .. "","",function(player,nuser_id) 
					nuser_id = nuser_id
					if nuser_id ~= nil and nuser_id ~= "" then 
						local target = vRP.getUserSource(tonumber(nuser_id))
						if target ~= nil then
							vRP.prompt(player,lang.money.give.prompt(),"",function(player,amount)
								local amount = parseInt(amount)
								if amount > 0 then
										if vRP.tryPayment(user_id,amount) then
											local pID = vRP.getUserId(target)
											local money = vRP.getMoney(pID)										
											vRP.giveMoney(pID,amount)
											vRPclient.notify(player,{lang.money.given({amount})})
											vRPclient.notify(target,{lang.money.received({amount})})
										else
											vRPclient.notify(player,{lang.money.not_enough()})
										end
								else
									vRPclient.notify(player,{lang.common.invalid_value()})
								end
							end)
						else
							vRPclient.notify(player,{lang.common.no_player_near()})
						end
					else
						vRPclient.notify(player,{lang.common.no_player_near()})
					end
				end)
			end
		end)
	end
end

local function ch_givebtc(player,choice)
  -- get nearest player
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayers(player,{15},function(nplayers)
      usrList = ""
      for k,v in pairs(nplayers) do
        usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
      end
      if usrList ~= "" then
        vRP.prompt(player,"Jucatori: " .. usrList .. "","",function(player,nuser_id) 
          nuser_id = nuser_id
          if nuser_id ~= nil and nuser_id ~= "" then 
            local target = vRP.getUserSource(tonumber(nuser_id))
            if target ~= nil then
              vRP.prompt(player,lang.money.give.prompt(),"",function(player,amount)
                local amount = parseInt(amount)
                if amount > 0 and vRP.tryXZPayment(user_id,amount) then
                      local pID = vRP.getUserId(target)
                      local money = vRP.getXZCoins(pID)
                      vRP.giveXZcoins(pID,amount)
					  vRPclient.notify(player,{"Ai dat suma de"..amount.."Diamante"})
                      vRPclient.notify(target,{"Ai primit suma de"..amount.."Diamante"})
                    else
						vRPclient.notify(player,{"Nu ai destule Diamante"})
                    end
                  end)
                else
                vRPclient.notify(player,{"~r~Acest ID este invalid!"})
            end
          else
            vRPclient.notify(player,{"~r~Nici un ID selectat!"})
          end
        end)
      else
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  else
    vRPclient.notify(player,{lang.common.no_player_near()})
  end
end

local function ch_givedmd(player,choice)
  -- get nearest player
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.getNearestPlayers(player,{15},function(nplayers)
      usrList = ""
      for k,v in pairs(nplayers) do
        usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
      end
      if usrList ~= "" then
        vRP.prompt(player,"Jucatori: " .. usrList .. "","",function(player,nuser_id) 
          nuser_id = nuser_id
          if nuser_id ~= nil and nuser_id ~= "" then 
            local target = vRP.getUserSource(tonumber(nuser_id))
            if target ~= nil then
              vRP.prompt(player,lang.money.give.prompt(),"",function(player,amount)
                local amount = parseInt(amount)
                if amount > 0 and vRP.tryDMPayment(user_id,amount) then
                      local pID = vRP.getUserId(target)
                      local money = vRP.getdiamonds(pID)
                      vRP.givediamonds(pID,amount)
                      vRPclient.notify(player,{"Ai dat suma de"..amount.."Diamante"})
                      vRPclient.notify(target,{"Ai primit suma de"..amount.."Diamante"})
                    else
                      vRPclient.notify(player,{"Nu ai destule Diamante"})
                    end
                  end)
                else
                vRPclient.notify(player,{"~r~Acest ID este invalid!"})
            end
          else
            vRPclient.notify(player,{"~r~Nici un ID selectat!"})
          end
        end)
      else
        vRPclient.notify(player,{lang.common.no_player_near()})
      end
    end)
  else
    vRPclient.notify(player,{lang.common.no_player_near()})
  end
end

-- add player give money to main menu
vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}
	choices[lang.money.give.title()] = {ch_give, lang.money.give.description()}
	--choices["Ofera Bitcoins"] = {ch_givebtc, "Ofera <font color='yellow'>BTC </font> Celui mai apropiat jucator"}
	--choices["Ofera Diamante"] = {ch_givedmd, "Ofera <font color='blue'>Diamante </font> Celui mai apropiat jucator"}

    add(choices)
  end
end)
