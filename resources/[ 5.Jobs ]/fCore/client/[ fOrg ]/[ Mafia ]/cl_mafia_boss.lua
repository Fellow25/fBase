ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societymafiamoney = nil
local societyblackmafiamoney = nil

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

function Bossmafia()
  local fmafia = RageUI.CreateMenu("Actions Patron", "Mafia")

    RageUI.Visible(fmafia, not RageUI.Visible(fmafia))

            while fmafia do
                Wait(0)
                    RageUI.IsVisible(fmafia, true, true, true, function()

                    if societymafiamoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societymafiamoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'mafia', amount)
                                RefreshmafiaMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'mafia', amount)
                                RefreshmafiaMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            mafiaboss()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Argent Sale ↓")
            

                    if societyblackmafiamoney ~= nil then
                        RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblackmafiamoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                TriggerServerEvent('mafia:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                Deposerargentsale()
                                ESX.TriggerServerCallback('mafia:getBlackMoneySociety', function(inventory) 
                            end)
                            RefreshblackmafiaMoney()
                        end
                    end)

                    RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local count = KeyboardInput("Combien ?", "", 100)
                            ESX.TriggerServerCallback('mafia:getBlackMoneySociety', function(inventory) 
                            TriggerServerEvent('mafia:getItem', 'item_account', 'black_money', tonumber(count))
                            Retirerargentsale()
                            RefreshblackmafiaMoney()
                            end)
                        end
                    end)

                end, function()
            end)
            if not RageUI.Visible(fmafia) then
            fmafia = RMenu:DeleteType("Actions Patron", true)
        end
    end
end   

---------------------------------------------

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'mafia' and ESX.PlayerData.job2.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Mafia.pos.boss.position.x, Mafia.pos.boss.position.y, Mafia.pos.boss.position.z)
        if dist3 <= 7.0 and Mafia.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Mafia.pos.boss.position.x, Mafia.pos.boss.position.y, Mafia.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        RefreshmafiaMoney()   
                        RefreshblackmafiaMoney()        
                            Bossmafia()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function RefreshmafiaMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietymafiaMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function RefreshblackmafiaMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('mafia:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackmafiaMoney(inventory)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyblackmafiaMoney(inventory)
    societyblackmafiamoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietymafiaMoney(money)
    societymafiamoney = ESX.Math.GroupDigits(money)
end

function mafiaboss()
    TriggerEvent('esx_society:openBossMenu', 'mafia', function(data, menu)
        menu.close()
    end, {wash = false})
end

function Deposerargentsale()
    ESX.TriggerServerCallback('mafia:getPlayerInventoryBlack', function(inventory)
        while DepositBlackmafia do
            Wait(0)
        end
    end)
end

function Retirerargentsale()
	ESX.TriggerServerCallback('mafia:getBlackMoneySociety', function(inventory)
	    while StockBlackmafia do
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