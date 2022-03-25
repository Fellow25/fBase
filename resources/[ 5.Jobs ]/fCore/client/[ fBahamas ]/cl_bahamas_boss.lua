ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societybahamasmoney = nil
local societyblackbahamasmoney = nil

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
    ESX.TriggerServerCallback('bahamas:getBlackMoneySociety', function(inventory)
        argent = inventory
    end)
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

---------------- FONCTIONS ------------------

function Bossbahamas()
  local fbahamas = RageUI.CreateMenu("Actions Patron", "Bahamas")
  fbahamas:SetRectangleBanner(153, 50, 204)
    RageUI.Visible(fbahamas, not RageUI.Visible(fbahamas))

            while fbahamas do
                Wait(0)
                    RageUI.IsVisible(fbahamas, true, true, true, function()

                    if societybahamasmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societybahamasmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'bahamas', amount)
                                RefreshbahamasMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'bahamas', amount)
                                RefreshbahamasMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            bahamasboss()
                            RageUI.CloseAll()
                        end
                    end)

                        RageUI.Separator("↓ Argent Sale ↓")
            

                        if societyblackbahamasmoney ~= nil then
                            RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblackbahamasmoney}, true, function()
                            end)
                        end
    
                        RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                            if Selected then
                                    local count = KeyboardInput("Combien ?", "", 100)
                                    TriggerServerEvent('bahamas:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                    Deposerargentsale()
                                    ESX.TriggerServerCallback('bahamas:getBlackMoneySociety', function(inventory) 
                                end)
                                RefreshblackbahamasMoney()
                            end
                        end)
    
                        RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                            if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                ESX.TriggerServerCallback('bahamas:getBlackMoneySociety', function(inventory) 
                                TriggerServerEvent('bahamas:getItem', 'item_account', 'black_money', tonumber(count))
                                Retirerargentsalebahamas()
                                RefreshblackbahamasMoney()
                                end)
                            end
                        end)
                    end, function()
                end)
            if not RageUI.Visible(fbahamas) then
            fbahamas = RMenu:DeleteType("Actions Patron", true)
        end
    end
end   

---------------------------------------------

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bahamas' and ESX.PlayerData.job.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Bahamas.pos.boss.position.x, Bahamas.pos.boss.position.y, Bahamas.pos.boss.position.z)
        if dist3 <= 7.0 and Bahamas.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Bahamas.pos.boss.position.x, Bahamas.pos.boss.position.y, Bahamas.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 153, 50, 204, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~p~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        RefreshbahamasMoney()   
                        RefreshblackbahamasMoney()        
                        Bossbahamas()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function RefreshbahamasMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietybahamasMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function RefreshblackbahamasMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('bahamas:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackbahamasMoney(inventory)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietyblackbahamasMoney(inventory)
    societyblackbahamasmoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietybahamasMoney(money)
    societybahamasmoney = ESX.Math.GroupDigits(money)
end

function bahamasboss()
    TriggerEvent('esx_society:openBossMenu', 'bahamas', function(data, menu)
        menu.close()
    end, {wash = false})
end

function Deposerargentsale()
    ESX.TriggerServerCallback('bahamas:getPlayerInventoryBlack', function(inventory)
        while DepositBlackBahamas do
            Wait(0)
        end
    end)
end

function Retirerargentsalebahamas()
	ESX.TriggerServerCallback('bahamas:getBlackMoneySociety', function(inventory)
	    while StockBlackBahamas do
		    Wait(0)
	    end
    end)
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