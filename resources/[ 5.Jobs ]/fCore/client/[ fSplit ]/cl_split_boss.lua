ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societysplitmoney = nil
local societyblacksplitmoney = nil

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
    --ESX.TriggerServerCallback('split:getBlackMoneySociety', function(inventory)
        --argent = inventory
    --end)
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

function Bosssplit()
  local fsplit = RageUI.CreateMenu("Actions Patron", "Split Sides")
  fsplit:SetRectangleBanner(5, 0, 0)
    RageUI.Visible(fsplit, not RageUI.Visible(fsplit))

            while fsplit do
                Wait(0)
                    RageUI.IsVisible(fsplit, true, true, true, function()

                    if societysplitmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societysplitmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'split', amount)
                                RefreshsplitMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'split', amount)
                                RefreshsplitMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            splitboss()
                            RageUI.CloseAll()
                        end
                    end)

                        RageUI.Separator("↓ Argent Sale ↓")
            

                        if societyblacksplitmoney ~= nil then
                            RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblacksplitmoney}, true, function()
                            end)
                        end
    
                        RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                            if Selected then
                                    local count = KeyboardInput("Combien ?", "", 100)
                                    TriggerServerEvent('split:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                    Deposerargentsale()
                                    ESX.TriggerServerCallback('split:getBlackMoneySociety', function(inventory) 
                                end)
                                RefreshblacksplitMoney()
                            end
                        end)
    
                        RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                            if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                ESX.TriggerServerCallback('split:getBlackMoneySociety', function(inventory) 
                                TriggerServerEvent('split:getItem', 'item_account', 'black_money', tonumber(count))
                                Retirerargentsalesplit()
                                RefreshblacksplitMoney()
                                end)
                            end
                        end)
                    end, function()
                end)
            if not RageUI.Visible(fsplit) then
            fsplit = RMenu:DeleteType("Actions Patron", true)
        end
    end
end   

---------------------------------------------

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'split' and ESX.PlayerData.job.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Split.pos.boss.position.x, Split.pos.boss.position.y, Split.pos.boss.position.z)
        if dist3 <= 7.0 and Split.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Split.pos.boss.position.x, Split.pos.boss.position.y, Split.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 1, 140, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~g~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        RefreshsplitMoney()   
                        RefreshblacksplitMoney()        
                        Bosssplit()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function RefreshsplitMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietysplitMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function RefreshblacksplitMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('split:getBlackMoneySociety', function(inventory)
            UpdateSocietyblacksplitMoney(inventory)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietyblacksplitMoney(inventory)
    societyblacksplitmoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietysplitMoney(money)
    societysplitmoney = ESX.Math.GroupDigits(money)
end

function splitboss()
    TriggerEvent('esx_society:openBossMenu', 'split', function(data, menu)
        menu.close()
    end, {wash = false})
end

function Deposerargentsale()
    ESX.TriggerServerCallback('split:getPlayerInventoryBlack', function(inventory)
        while DepositBlackSplit do
            Wait(0)
        end
    end)
end

function Retirerargentsalesplit()
	ESX.TriggerServerCallback('split:getBlackMoneySociety', function(inventory)
	    while StockBlackSplit do
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
