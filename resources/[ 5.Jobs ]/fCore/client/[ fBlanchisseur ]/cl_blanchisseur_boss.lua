ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societyblanchisseurmoney = nil
local societyblackblanchisseurmoney = nil

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
    ESX.TriggerServerCallback('blanchisseur:getBlackMoneySociety', function(inventory)
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

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

---------------- FONCTIONS ------------------

function BossBlanchisseur()
  local BBlanchisseur = RageUI.CreateMenu("Actions Patron", "Blanchisseur")

    RageUI.Visible(BBlanchisseur, not RageUI.Visible(BBlanchisseur))

            while BBlanchisseur do
                Wait(0)
                    RageUI.IsVisible(BBlanchisseur, true, true, true, function()

                    if societyblanchisseurmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societyblanchisseurmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'blanchisseur', amount)
                                RefreshblanchisseurMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'blanchisseur', amount)
                                RefreshblanchisseurMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            blanchisseurboss()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Argent Sale ↓")
            

                    if societyblackblanchisseurmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblackblanchisseurmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                TriggerServerEvent('blanchisseur:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                Deposerargentsale()
                                ESX.TriggerServerCallback('blanchisseur:getBlackMoneySociety', function(inventory) 
                            end)
                            RefreshblackblanchisseurMoney()
                        end
                    end)

                    RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local count = KeyboardInput("Combien ?", "", 100)
                            ESX.TriggerServerCallback('blanchisseur:getBlackMoneySociety', function(inventory) 
                            TriggerServerEvent('blanchisseur:getItem', 'item_account', 'black_money', tonumber(count))
                            Retirerargentsaleblanchisseur()
                            RefreshblackblanchisseurMoney()
                            end)
                        end
                    end)
                end, function()
            end)
            if not RageUI.Visible(BBlanchisseur) then
            BBlanchisseur = RMenu:DeleteType("BBlanchisseur", true)
        end
    end
end   

---------------------------------------------

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'blanchisseur' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'blanchisseur' and ESX.PlayerData.job2.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, blanchisseur.pos.boss.position.x, blanchisseur.pos.boss.position.y, blanchisseur.pos.boss.position.z)
        if dist3 <= 10.0 and blanchisseur.jeveuxmarker then
            Timer = 0
            DrawMarker(20, blanchisseur.pos.boss.position.x, blanchisseur.pos.boss.position.y, blanchisseur.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 175, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            RefreshblanchisseurMoney()
                            RefreshblackblanchisseurMoney()
                            BossBlanchisseur()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function RefreshblanchisseurMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyblanchisseurMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function RefreshblackblanchisseurMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('blanchisseur:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackblanchisseurMoney(inventory)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyblackblanchisseurMoney(inventory)
    societyblackblanchisseurmoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietyblanchisseurMoney(money)
    societyblanchisseurmoney = ESX.Math.GroupDigits(money)
end

function blanchisseurboss()
    TriggerEvent('esx_society:openBossMenu', 'blanchisseur', function(data, menu)
        menu.close()
    end, {wash = false})
end

function Deposerargentsale()
    ESX.TriggerServerCallback('blanchisseur:getPlayerInventoryBlack', function(inventory)
        while DepositBlackBlanchisseur do
            Wait(0)
        end
    end)
end

function Retirerargentsaleblanchisseur()
	ESX.TriggerServerCallback('blanchisseur:getBlackMoneySociety', function(inventory)
	    while StockBlackBlanchisseur do
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