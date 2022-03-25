ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societycripsmoney = nil
local societyblackcripsmoney = nil

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
    ESX.TriggerServerCallback('crips:getBlackMoneySociety', function(inventory)
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

function BossCrips()
  local BCrips = RageUI.CreateMenu("Actions Patron", "Crips")

    RageUI.Visible(BCrips, not RageUI.Visible(BCrips))

            while BCrips do
                Wait(0)
                    RageUI.IsVisible(BCrips, true, true, true, function()

                    if societycripsmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societycripsmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'crips', amount)
                                RefreshcripsMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'crips', amount)
                                RefreshcripsMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            cripsboss()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Argent Sale ↓")
            

                    if societyblackcripsmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblackcripsmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                TriggerServerEvent('crips:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                Deposerargentsale()
                                ESX.TriggerServerCallback('crips:getBlackMoneySociety', function(inventory) 
                            end)
                            RefreshblackcripsMoney()
                        end
                    end)

                    RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local count = KeyboardInput("Combien ?", "", 100)
                            ESX.TriggerServerCallback('crips:getBlackMoneySociety', function(inventory) 
                            TriggerServerEvent('crips:getItem', 'item_account', 'black_money', tonumber(count))
                            Retirerargentsale()
                            RefreshblackcripsMoney()
                            end)
                        end
                    end)
                end, function()
            end)
            if not RageUI.Visible(BCrips) then
            BCrips = RMenu:DeleteType("BCrips", true)
        end
    end
end   

---------------------------------------------

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'crips' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'crips' and ESX.PlayerData.job2.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, crips.pos.boss.position.x, crips.pos.boss.position.y, crips.pos.boss.position.z)
        if dist3 <= 10.0 and crips.jeveuxmarker then
            Timer = 0
            DrawMarker(20, crips.pos.boss.position.x, crips.pos.boss.position.y, crips.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 100, 149, 237, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            RefreshcripsMoney()
                            RefreshblackcripsMoney()
                            BossCrips()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function RefreshcripsMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietycripsMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function RefreshblackcripsMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('crips:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackcripsMoney(inventory)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyblackcripsMoney(inventory)
    societyblackcripsmoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietycripsMoney(money)
    societycripsmoney = ESX.Math.GroupDigits(money)
end

function cripsboss()
    TriggerEvent('esx_society:openBossMenu', 'crips', function(data, menu)
        menu.close()
    end, {wash = false})
end

function Deposerargentsale()
    ESX.TriggerServerCallback('crips:getPlayerInventoryBlack', function(inventory)
        while DepositBlackcrips do
            Wait(0)
        end
    end)
end

function Retirerargentsale()
	ESX.TriggerServerCallback('crips:getBlackMoneySociety', function(inventory)
	    while StockBlackcrips do
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