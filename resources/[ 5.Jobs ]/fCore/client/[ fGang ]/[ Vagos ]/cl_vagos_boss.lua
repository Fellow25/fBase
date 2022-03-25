ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societyvagosmoney = nil
local societyblackvagosmoney = nil

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
    ESX.TriggerServerCallback('vagos:getBlackMoneySociety', function(inventory)
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

function BossVagos()
  local BVagos = RageUI.CreateMenu("Actions Patron", "Vagos")

    RageUI.Visible(BVagos, not RageUI.Visible(BVagos))

            while BVagos do
                Wait(0)
                    RageUI.IsVisible(BVagos, true, true, true, function()

                    if societyvagosmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societyvagosmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'vagos', amount)
                                RefreshvagosMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'vagos', amount)
                                RefreshvagosMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vagosboss()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Argent Sale ↓")
            

                    if societyblackvagosmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblackvagosmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                TriggerServerEvent('vagos:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                VDeposerargentsale()
                                ESX.TriggerServerCallback('vagos:getBlackMoneySociety', function(inventory) 
                            end)
                            RefreshblackvagosMoney()
                        end
                    end)

                    RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local count = KeyboardInput("Combien ?", "", 100)
                            ESX.TriggerServerCallback('vagos:getBlackMoneySociety', function(inventory) 
                            TriggerServerEvent('vagos:getItem', 'item_account', 'black_money', tonumber(count))
                            VRetirerargentsale()
                            RefreshblackvagosMoney()
                            end)
                        end
                    end)
                end, function()
            end)
            if not RageUI.Visible(BVagos) then
            BVagos = RMenu:DeleteType("BVagos", true)
        end
    end
end   

---------------------------------------------

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vagos' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vagos' and ESX.PlayerData.job2.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vagos.pos.boss.position.x, vagos.pos.boss.position.y, vagos.pos.boss.position.z)
        if dist3 <= 10.0 and vagos.jeveuxmarker then
            Timer = 0
            DrawMarker(20, vagos.pos.boss.position.x, vagos.pos.boss.position.y, vagos.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            RefreshvagosMoney()
                            RefreshblackvagosMoney()
                            BossVagos()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function RefreshvagosMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyvagosMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function RefreshblackvagosMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('vagos:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackvagosMoney(inventory)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyblackvagosMoney(inventory)
    societyblackvagosmoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietyvagosMoney(money)
    societyvagosmoney = ESX.Math.GroupDigits(money)
end

function vagosboss()
    TriggerEvent('esx_society:openBossMenu', 'vagos', function(data, menu)
        menu.close()
    end, {wash = false})
end

function VDeposerargentsale()
    ESX.TriggerServerCallback('vagos:getPlayerInventoryBlack', function(inventory)
        while DepositBlackvagos do
            Wait(0)
        end
    end)
end

function VRetirerargentsale()
	ESX.TriggerServerCallback('vagos:getBlackMoneySociety', function(inventory)
	    while StockBlackVagos do
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