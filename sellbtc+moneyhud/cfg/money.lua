
local cfg = {}

-- start wallet/bank values
cfg.open_wallet = 1000
cfg.open_bank = 5000000
cfg.open_xzCoins = 0
cfg.open_diamonds = 0

cfg.display_css = [[
  .div_money{    
  position:absolute;
  float: right;
  top: 40px;
  padding: 15px 44px;
  padding-right: 19px;
  right: 21px;
  font-size: 15px;
  animation: logomove 6.0s infinite;
  font-family: arial;
  border-radius: 20px;
  background-color: rgba(0,0,0,0.95);
  background-size: 25px;
  background-image:url('https://i.ibb.co/sP9KhvG/icons8-coins-filled-100.png');
  background-position: 15px;
  font-weight: 600;
  color: white;
  background-repeat: no-repeat;
}

.div_bmoney{
  position:absolute;
  float: right;
  top: 90px;
  padding: 15px 44px;
  padding-right: 19px;
  right: 21px;
  font-size: 15px;
  font-family: arial;
  border-radius: 20px;
  animation: logomove 6.0s infinite;
  background-color: rgba(0,0,0,0.95);
  background-image: url('https://i.imgur.com/77G1c4i.png');
  background-size: 25px;
  background-position: 15px;
  font-weight: 600;
  color: white;
  background-repeat: no-repeat;
}

.div_xzCoins{
  position:absolute;
  float: right;
  top: 140px;
  padding: 15px 44px;
  padding-right: 19px;
  right: 21px;
  font-size: 15px;
  animation: logomove 2.1s infinite;
  font-family: arial;
  border-radius: 20px;
  animation: logomove 6.0s infinite;
  background-color: rgba(0,0,0,0.95);
  background-image: url('https://i.imgur.com/4EGsCLn.png');
  background-size: 25px;
  background-position: 15px;
  font-weight: 600;
  color: white ;
  background-repeat: no-repeat;
}
.div_diamonds{
  position:absolute;
  float: right;
  top: 190px;
  padding: 15px 44px;
  padding-right: 19px;
  right: 21px;
  font-size: 15px;
  font-family: arial;
  animation: logomove 6.0s infinite;
  border-radius: 20px;
  background-color: rgba(0,0,0,0.95);
  background-size: 25px;
  background-image: url('https://i.imgur.com/1F0ZWtS.png');
  animation: logomove 6.0s infinite;
  background-position: 15px;
  font-weight: 600;
  color: white;
  background-repeat: no-repeat;
}
@keyframes logomove {
  0%{opacity: 0.6;}
  50%{opacity: 1;}
  100%{opacity: 0.5;}
}

.div_money .symbol{

}

.div_bmoney .symbol{

}

.div_xzCoins .symbol{
}

.div_diamonds .symbol{
 
}
]]


--content: url('https://i.imgur.com/NvJ8yUF.png'); --Diamante
return cfg
