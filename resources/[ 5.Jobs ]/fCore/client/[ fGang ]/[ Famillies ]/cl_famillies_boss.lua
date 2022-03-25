ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societyfamilliesmoney = nil
local societyblackfamilliesmoney = nil

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
    ESX.TriggerServerCallback('famillies:getBlackMoneySociety', function(inventory)
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

function BossFamillies()
  local BFamillies = RageUI.CreateMenu("Actions Patron", "Famillies")

    RageUI.Visible(BFamillies, not RageUI.Visible(BFamillies))

            while BFamillies do
                Wait(0)
                    RageUI.IsVisible(BFamillies, true, true, true, function()

                    if societyfamilliesmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societyfamilliesmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'famillies', amount)
                                RefreshfamilliesMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'famillies', amount)
                                RefreshfamilliesMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            familliesboss()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Argent Sale ↓")
            

                    if societyblackfamilliesmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblackfamilliesmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                TriggerServerEvent('famillies:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                fDeposerargentsale()
                                ESX.TriggerServerCallback('famillies:getBlackMoneySociety', function(inventory) 
                            end)
                            RefreshblackfamilliesMoney()
                        end
                    end)

                    RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local count = KeyboardInput("Combien ?", "", 100)
                            ESX.TriggerServerCallback('famillies:getBlackMoneySociety', function(inventory) 
                            TriggerServerEvent('famillies:getItem', 'item_account', 'black_money', tonumber(count))
                            fRetirerargentsale()
                            RefreshblackfamilliesMoney()
                            end)
                        end
                    end)
                end, function()
            end)
            if not RageUI.Visible(BFamillies) then
            BFamillies = RMenu:DeleteType("BFamillies", true)
        end
    end
end   

---------------------------------------------

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'famillies' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'famillies' and ESX.PlayerData.job2.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, famillies.pos.boss.position.x, famillies.pos.boss.position.y, famillies.pos.boss.position.z)
        if dist3 <= 10.0 and famillies.jeveuxmarker then
            Timer = 0
            DrawMarker(20, famillies.pos.boss.position.x, famillies.pos.boss.position.y, famillies.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 34, 139, 34, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            RefreshfamilliesMoney()
                            RefreshblackfamilliesMoney()
                            BossFamillies()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function RefreshfamilliesMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyfamilliesMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function RefreshblackfamilliesMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('famillies:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackfamilliesMoney(inventory)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyblackfamilliesMoney(inventory)
    societyblackfamilliesmoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietyfamilliesMoney(money)
    societyfamilliesmoney = ESX.Math.GroupDigits(money)
end

function familliesboss()
    TriggerEvent('esx_society:openBossMenu', 'famillies', function(data, menu)
        menu.close()
    end, {wash = false})
end

function fDeposerargentsale()
    ESX.TriggerServerCallback('famillies:getPlayerInventoryBlack', function(inventory)
        while DepositBlackFamillies do
            Wait(0)
        end
    end)
end

function fRetirerargentsale()
	ESX.TriggerServerCallback('famillies:getBlackMoneySociety', function(inventory)
	    while StockBlackFamillies do
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