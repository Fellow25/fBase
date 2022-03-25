ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societyunicornmoney = nil
local societyblackunicornmoney = nil

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
    ESX.TriggerServerCallback('unicorn:getBlackMoneySociety', function(inventory)
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

function Bossunicorn()
  local funicorn = RageUI.CreateMenu("Actions Patron", "Vanilla Unicorn")
  funicorn:SetRectangleBanner(147, 112, 219)
    RageUI.Visible(funicorn, not RageUI.Visible(funicorn))

            while funicorn do
                Wait(0)
                    RageUI.IsVisible(funicorn, true, true, true, function()

                    if societyunicornmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societyunicornmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'unicorn', amount)
                                RefreshunicornMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'unicorn', amount)
                                RefreshunicornMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            unicornboss()
                            RageUI.CloseAll()
                        end
                    end)

                        RageUI.Separator("↓ Argent Sale ↓")
            

                        if societyblackunicornmoney ~= nil then
                            RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblackunicornmoney}, true, function()
                            end)
                        end
    
                        RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                            if Selected then
                                    local count = KeyboardInput("Combien ?", "", 100)
                                    TriggerServerEvent('unicorn:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                    Deposerargentsale()
                                    ESX.TriggerServerCallback('unicorn:getBlackMoneySociety', function(inventory) 
                                end)
                                RefreshblackunicornMoney()
                            end
                        end)
    
                        RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                            if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                ESX.TriggerServerCallback('unicorn:getBlackMoneySociety', function(inventory) 
                                TriggerServerEvent('unicorn:getItem', 'item_account', 'black_money', tonumber(count))
                                Retirerargentsaleunicorn()
                                RefreshblackunicornMoney()
                                end)
                            end
                        end)
                    end, function()
                end)
            if not RageUI.Visible(funicorn) then
            funicorn = RMenu:DeleteType("Actions Patron", true)
        end
    end
end   

---------------------------------------------

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' and ESX.PlayerData.job.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Unicorn.pos.boss.position.x, Unicorn.pos.boss.position.y, Unicorn.pos.boss.position.z)
        if dist3 <= 7.0 and Unicorn.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Unicorn.pos.boss.position.x, Unicorn.pos.boss.position.y, Unicorn.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 147, 112, 219, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~p~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        RefreshunicornMoney()   
                        RefreshblackunicornMoney()        
                        Bossunicorn()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function RefreshunicornMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyunicornMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function RefreshblackunicornMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('unicorn:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackunicornMoney(inventory)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietyblackunicornMoney(inventory)
    societyblackunicornmoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietyunicornMoney(money)
    societyunicornmoney = ESX.Math.GroupDigits(money)
end

function unicornboss()
    TriggerEvent('esx_society:openBossMenu', 'unicorn', function(data, menu)
        menu.close()
    end, {wash = false})
end

function Deposerargentsale()
    ESX.TriggerServerCallback('unicorn:getPlayerInventoryBlack', function(inventory)
        while DepositBlackUnicorn do
            Wait(0)
        end
    end)
end

function Retirerargentsaleunicorn()
	ESX.TriggerServerCallback('unicorn:getBlackMoneySociety', function(inventory)
	    while StockBlackUnicorn do
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