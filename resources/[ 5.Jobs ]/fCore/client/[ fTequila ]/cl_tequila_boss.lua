ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societytequilamoney = nil
local societyblacktequilamoney = nil

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
    --ESX.TriggerServerCallback('tequila:getBlackMoneySociety', function(inventory)
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

function Bosstequila()
  local ftequila = RageUI.CreateMenu("Actions Patron", "Tequila")
  ftequila:SetRectangleBanner(173, 248, 2)
    RageUI.Visible(ftequila, not RageUI.Visible(ftequila))

            while ftequila do
                Wait(0)
                    RageUI.IsVisible(ftequila, true, true, true, function()

                    if societytequilamoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societytequilamoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'tequila', amount)
                                RefreshtequilaMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'tequila', amount)
                                RefreshtequilaMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tequilaboss()
                            RageUI.CloseAll()
                        end
                    end)

                        RageUI.Separator("↓ Argent Sale ↓")
            

                        if societyblacktequilamoney ~= nil then
                            RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblacktequilamoney}, true, function()
                            end)
                        end
    
                        RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                            if Selected then
                                    local count = KeyboardInput("Combien ?", "", 100)
                                    TriggerServerEvent('tequila:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                    Deposerargentsale()
                                    ESX.TriggerServerCallback('tequila:getBlackMoneySociety', function(inventory) 
                                end)
                                RefreshblacktequilaMoney()
                            end
                        end)
    
                        RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                            if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                ESX.TriggerServerCallback('tequila:getBlackMoneySociety', function(inventory) 
                                TriggerServerEvent('tequila:getItem', 'item_account', 'black_money', tonumber(count))
                                Retirerargentsaletequila()
                                RefreshblacktequilaMoney()
                                end)
                            end
                        end)
                    end, function()
                end)
            if not RageUI.Visible(ftequila) then
            ftequila = RMenu:DeleteType("Actions Patron", true)
        end
    end
end   

---------------------------------------------

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tequila' and ESX.PlayerData.job.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Tequila.pos.boss.position.x, Tequila.pos.boss.position.y, Tequila.pos.boss.position.z)
        if dist3 <= 7.0 and Tequila.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Tequila.pos.boss.position.x, Tequila.pos.boss.position.y, Tequila.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 173, 248, 2, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~g~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        RefreshtequilaMoney()   
                        RefreshblacktequilaMoney()        
                        Bosstequila()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function RefreshtequilaMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietytequilaMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function RefreshblacktequilaMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('tequila:getBlackMoneySociety', function(inventory)
            UpdateSocietyblacktequilaMoney(inventory)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietyblacktequilaMoney(inventory)
    societyblacktequilamoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietytequilaMoney(money)
    societytequilamoney = ESX.Math.GroupDigits(money)
end

function tequilaboss()
    TriggerEvent('esx_society:openBossMenu', 'tequila', function(data, menu)
        menu.close()
    end, {wash = false})
end

function Deposerargentsale()
    ESX.TriggerServerCallback('tequila:getPlayerInventoryBlack', function(inventory)
        while DepositBlackTequila do
            Wait(0)
        end
    end)
end

function Retirerargentsaletequila()
	ESX.TriggerServerCallback('tequila:getBlackMoneySociety', function(inventory)
	    while StockBlackTequila do
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
