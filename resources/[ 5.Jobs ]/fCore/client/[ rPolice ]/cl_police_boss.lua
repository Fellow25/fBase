ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societypolicemoney = nil
local camera = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Wait(5000) 
end)

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

---------------- FONCTIONS ------------------

function BossPolice()
  local rPolice = RageUI.CreateMenu("Actions Patron", "Police")

    RageUI.Visible(rPolice, not RageUI.Visible(rPolice))

            while rPolice do
                Wait(0)
                    RageUI.IsVisible(rPolice, true, true, true, function()

                    if societypolicemoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societypolicemoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'police', amount)
                                RefreshpoliceMoney()
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:depositMoney', 'police', amount)
                                RefreshpoliceMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            policeboss()
                            RageUI.CloseAll()
                        end
                    end)

              RageUI.Checkbox("Ouvrir/Fermer le système de caméra",nil, camera,{},function(Hovered,Ative,Selected,Checked)
                if Selected then
                    camera = Checked;

                    if Checked then
                        camera = true
                    else
                        camera = false
                    end
                end
            end)

                    if camera then
                    RageUI.ButtonWithStyle("Caméra 1", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 25) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 2", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 26) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 3", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 27) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 4", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 1) 
                        end
                    end)
            
            
                    RageUI.ButtonWithStyle("Caméra 5", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 2) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 6", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 3) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 7", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 4) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 8", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 5) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 9", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 6) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 10", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 7) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 11", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 8) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 12", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 9) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 13", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 10) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 14", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 11) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 15", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 12) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 16", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 13) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 17", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 14) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 18", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 15) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 19", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 16) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 20", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 17) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 21", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 18) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 22", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 19) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 23", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 20) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 24", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 21) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 25", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 22) 
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Caméra 26", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
                        if Selected then   
                            TriggerEvent('cctv:camera', 23) 
                        end
                    end)
                end


                end, function()
            end)
            if not RageUI.Visible(rPolice) then
            rPolice = RMenu:DeleteType("Actions Patron", true)
        end
    end
end   

---------------------------------------------

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, rPolice.pos.boss.position.x, rPolice.pos.boss.position.y, rPolice.pos.boss.position.z)
        if dist3 <= 7.0 and rPolice.jeveuxmarker then
            Timer = 0
            DrawMarker(20, rPolice.pos.boss.position.x, rPolice.pos.boss.position.y, rPolice.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        RefreshpoliceMoney()           
                            BossPolice()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function RefreshpoliceMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietypoliceMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietypoliceMoney(money)
    societypolicemoney = ESX.Math.GroupDigits(money)
end

function policeboss()
    TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
        menu.close()
    end, {wash = false})
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end