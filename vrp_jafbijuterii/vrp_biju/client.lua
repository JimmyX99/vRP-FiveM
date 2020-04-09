
--[[
      Sctipt: Jaf la Magazin
      Author: Jimmy#1337
      Don t upload the resource without my permission 
      All rights reserved
]]

--Checkpoint for red circle 
inprogres1 = false
inprogres2 = false
inprogres3 = false
inprogres4 = false
inprogres5 = false
inprogres6 = false
inprogres7 = false
inprogres8 = false
inprogres9 = false
inprogres10 = false
inprogres11 = false
inprogres12 = false
inprogres13 = false
inprogres14 = false
inprogres15 = false
inprogres16 = false
inprogres17 = false
inprogres18 = false
inprogres19 = false
inprogres20 = false
inprogres21 = false
inprogres22 = false
inprogres23 = false
inprogres24 = false
inprogres25 = false
---Requirement--
jaf = false
nextjaf = true
oprit = false
verifica = true

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)
        if jaf == false then
            if nextjaf == true then
                DrawMarker(27, -631.1552734375,-229.40916442871,38.057052612305-0.95, 0, 0, 0, 0, 0, 0, 1.401, 1.401, 1.401, 255, 0, 0, 200, 0, 0, 0, 1)
                if position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -631.1552734375,-229.40916442871,38.057052612305-0.95, 2) then
                    help_message("Apasa ~INPUT_CONTEXT~ ca sa incepi jaf ul")
                    if IsControlJustReleased(1, 38) then
                        TriggerServerEvent("jaflabijuterii:serverstart")
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('jaflabijuterii:start')
AddEventHandler('jaflabijuterii:start', function()
    notifypicture_message("CHAR_DETONATEPHONE",2,"JAF LA MAGAZINUL DE BIJUTERII",false,"~r~Jaf ul a inceput,fura tot ce poti!")
    notifypicture_message("CHAR_DETONATEPHONE",2,"JAF LA MAGAZINUL DE BIJUTERII",false,"~r~Ai 30 secunde sa furi tot inainte de a se declansa alarma!")
    jaf = true
    nextjaf = false
    if oprit == false then
        SetTimeout(30000, function()
            if oprit == false then
                --notifypicture_message("CHAR_CALL911",1,"Alerta Politie",false,"~r~In acest monment este jaf la magazinul de bijuterii")
                TriggerServerEvent('InteractSound_SV:PlayOnSource', 'allarm', 0.1)
                TriggerServerEvent('jaflabijuterii:allarmpolice')
                
            end
        end)
    elseif oprit == true  then
        notifypicture_message("CHAR_DETONATEPHONE",1,"JAF TERMINAT",false,"~g~Ai reusit sa furi totul cu succes!")
    end
    SetTimeout(3600000, function()
        jaf = false
        nextjaf = true
        oprit = false
    end)
end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)
        if jaf == true then
            if nextjaf == false then
                if position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -632.86700439453,-238.65907287598,38.07377243042-0.95, 2.5) then
                    notifypicture_message("CHAR_DETONATEPHONE",1,"Jaf la magazinul de bijuterii",false,"~r~Jaf ul a fost oprit deoarece jucatorul a fugit din magazin!")
                    oprit = true
                    jaf = false
                    SetTimeout(3600000, function()
                        jaf = false
                        nextjaf = true
                        oprit = false
                    end)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if jaf == true then
        if inprogres1 == false then
            DrawMarker(1, -626.39184570313,-239.2056427002,39.243705749512-1.40, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres2 == false then
            DrawMarker(1, -625.21459960938,-238.34736633301,39.223617553711-1.35, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres3 == false then
            DrawMarker(1, -627.29907226563,-234.87519836426,38.966594696045-1.15, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres4 == false then
            DrawMarker(1, -626.46722412109,-233.53826904297,39.223575592041-1.40, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres5 == false then
            DrawMarker(1, -626.10083007813,-234.11917114258,39.218456268311-1.40, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres6 == false then
            DrawMarker(1, -627.44964599609,-234.31884765625,38.862445831299-1.05, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres7 == false then
            DrawMarker(1, -622.44360351563,-229.92840576172,38.057010650635-0.95, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres8 == false then
            DrawMarker(1, -624.39660644531,-224.11256408691,38.057052612305-0.95, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres9 == false then
            DrawMarker(1, -625.56530761719,-223.91967773438,38.057052612305-0.95, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres10 == false then
            DrawMarker(1, -626.81958007813,-224.28707885742,38.057060241699-0.95, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres11 == false then
            DrawMarker(1, -627.46771240234,-225.21870422363,38.057060241699-0.95, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres12 == false then
            DrawMarker(1, -627.53582763672,-226.63664245605,38.057037353516-0.95, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres13 == false then
            DrawMarker(1, -619.77795410156,-237.37419128418,38.057048797607-0.95, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres14 == false then
            DrawMarker(1, -618.57702636719,-237.54234313965,38.057048797607-0.95, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres15 == false then
            DrawMarker(1, -617.32000732422,-237.18495178223,38.057048797607-0.95, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres16 == false then
            DrawMarker(1, -616.51922607422,-236.22741699219,38.057048797607-0.95, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres17 == false then
            DrawMarker(1, -616.59136962891,-234.95397949219,38.057048797607-0.95, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres18 == false then
            DrawMarker(1, -625.42498779297,-227.33630371094,39.223571777344-1.40, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres19 == false then
            DrawMarker(1, -624.21508789063,-226.62153625488,39.218448638916-1.40, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres20 == false then
            DrawMarker(1, -619.8193359375,-226.34170532227,39.223571777344-1.40, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres21 == false then
            DrawMarker(1, -619.23901367188,-227.3199005127,39.243709564209-1.40, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres22 == false then
            DrawMarker(1, -617.91809082031,-229.13171386719,39.223617553711-1.40, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres23 == false then
            DrawMarker(1, -617.11437988281,-230.2271270752,39.243701934814-1.40, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres24 == false then
            DrawMarker(1, -618.77655029297,-234.12934875488,39.223613739014-1.40, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        if inprogres25 == false then
            DrawMarker(1, -619.76385498047,-234.82135009766,39.223579406738-1.40, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.21, 255, 0, 0, 200, 0, 0, 0, 1)
        end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)

            if jaf == true then
                if position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -626.39184570313,-239.2056427002,39.243705749512-1.40, 1) then
                    if inprogres1 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres1 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -625.21459960938,-238.34736633301,39.223617553711-1.35, 1) then
                    if inprogres2 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres2 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -627.29907226563,-234.87519836426,38.966594696045-1.15, 1) then
                    if inprogres3 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres3 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -626.46722412109,-233.53826904297,39.223575592041-1.40, 1) then
                    if inprogres4 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres4 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -626.10083007813,-234.11917114258,39.218456268311-1.40, 1) then
                    if inprogres5 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres5 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -627.44964599609,-234.31884765625,38.862445831299-1.05, 1) then
                    if inprogres6 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres6 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -622.44360351563,-229.92840576172,38.057010650635-0.95, 1) then
                    if inprogres7 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ sa iei banii")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucessMO')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres7 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -624.39660644531,-224.11256408691,38.057052612305-0.95, 1) then
                    if inprogres8 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucessRW1')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres8 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -625.56530761719,-223.91967773438,38.057052612305-0.95, 1) then
                    if inprogres9 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucessRW1')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres9 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -626.81958007813,-224.28707885742,38.057060241699-0.95, 1) then
                    if inprogres10 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucessRW1')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres10 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -627.46771240234,-225.21870422363,38.057060241699-0.95, 1) then
                    if inprogres11 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucessRW1')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres11 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -627.53582763672,-226.63664245605,38.057037353516-0.95, 1) then
                    if inprogres12 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucessRW1')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres12 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -619.77795410156,-237.37419128418,38.057048797607-0.95, 1) then
                    if inprogres13 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucessRW1')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres13 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -618.57702636719,-237.54234313965,38.057048797607-0.95, 1) then
                    if inprogres14 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucessRW1')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres14 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -617.32000732422,-237.18495178223,38.057048797607-0.95, 1) then
                    if inprogres15 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucessRW1')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres15 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -616.51922607422,-236.22741699219,38.057048797607-0.95, 1) then
                    if inprogres16 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucessRW1')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres16 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -616.59136962891,-234.95397949219,38.057048797607-0.95, 1) then
                    if inprogres17 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucessRW1')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres17 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -625.42498779297,-227.33630371094,39.223571777344-1.40, 1) then
                    if inprogres18 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres18 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -624.21508789063,-226.62153625488,39.218448638916-1.40, 1) then
                    if inprogres19 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres19 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -619.8193359375,-226.34170532227,39.223571777344-1.40, 1) then
                    if inprogres20 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres20 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -619.23901367188,-227.3199005127,39.243709564209-1.40, 1) then
                    if inprogres21 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres21 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -617.91809082031,-229.13171386719,39.223617553711-1.40, 1) then
                    if inprogres22 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres22 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -617.11437988281,-230.2271270752,39.243701934814-1.40, 1) then
                    if inprogres23 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres23 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -618.77655029297,-234.12934875488,39.223613739014-1.40, 1) then
                    if inprogres24 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres24 = true
                        end
                    end
                elseif position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -619.76385498047,-234.82135009766,39.223579406738-1.40, 1) then
                    if inprogres25 == false then
                        help_message("Apasa ~INPUT_CONTEXT~ pentru a lua bijuteriile")
                        if IsControlJustReleased(1, 38) then
                            TriggerServerEvent('jaflabijuterii:sucess')
                            loadAnimDict( "missheist_jewel" ) 
						    TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, 5000, 2, 0, false, false, false) 
                            inprogres25 = true
                        end
                    end
                end
            end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)

        if inprogres1 == true and inprogres2 == true and inprogres3 == true and inprogres4 == true and inprogres5 == true and inprogres6 == true and inprogres7 == true and inprogres8 == true and inprogres8 == true and inprogres9 == true and inprogres10 == true and inprogres11 == true and inprogres12 == true and inprogres13 == true and inprogres14 == true and inprogres15 == true and inprogres16 == true and inprogres17 == true and inprogres18 == true and inprogres19 == true and inprogres20 == true and inprogres21 == true and inprogres22 == true and inprogres23 == true and inprogres24 == true and inprogres25 == true then
            if verifica == true then
                notifypicture_message("CHAR_DETONATEPHONE",2,"Magazin de bijuterii",false,"~g~Ai furat tot!")
                verifica = false
            end
            if position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -630.17553710938,-236.52540588379,38.0570602416992-0.95, 3) then
                help_message("~r~Asteapta 60 de minute pentru a putea sparge magazinul din nou!")
            end
            SetTimeout(3600000, function()
                jaf = false
                nextjaf = true
                oprit = false
                verifica = true
            end)
        end
        if position_verf(playerLoc.x, playerLoc.y, playerLoc.z, -630.17553710938,-236.52540588379,38.0570602416992-0.95, 3) then
            if canceled == true then
                help_message("~r~Asteapta 60 de minute pentru a putea sparge magazinul din nou!")
            end
        end
    end
end)

Citizen.CreateThread(function()
    blip = AddBlipForCoord(-622.24560546875,-230.86483764648,38.057060241699)
    SetBlipSprite(blip, 617)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 18)
    SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Zed (Jewelry)")
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    blip = AddBlipForCoord(-631.1552734375,-229.40916442871,38.057052612305)
    SetBlipSprite(blip, 276)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Magazin de bijuterii")
    EndTextCommandSetBlipName(blip)
end)


function position_verf(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end

function help_message(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function notify_message(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

function notifypicture_message(icon, type, sender, title, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, type, sender, title, text)
    DrawNotification(false, true)
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 