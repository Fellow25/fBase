ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societymechanicmoney = nil

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

function Bossbennys()
  local bbennys = RageUI.CreateMenu("Actions Patron", "Benny's")
  local MEmployees = RageUI.CreateSubMenu(bbennys, "Actions Patron", "Gestion employés")
  local MEmployees2 = RageUI.CreateSubMenu(MEmployees, "Actions Patron", "Gestion employés")
  bbennys:SetRectangleBanner(150, 0, 0)
  MEmployees:SetRectangleBanner(150, 0, 0)
  MEmployees2:SetRectangleBanner(150, 0, 0)
    RageUI.Visible(bbennys, not RageUI.Visible(bbennys))
            while bbennys do
                Wait(0)
                    RageUI.IsVisible(bbennys, true, true, true, function()

                    RageUI.Separator("~y~Patron de la société : "..GetPlayerName(PlayerId()))

                    if societymechanicmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societymechanicmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'mechanic', amount)
                                RefreshmechanicMoney()
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Déposer argent de société",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:depositMoney', 'mechanic', amount)
                                RefreshmechanicMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Gestion employés", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                            if Selected then
                                local society = 'mechanic'
                                loadEmployes(society)
                            end
                        end, MEmployees)
                end, function()
            end)

                    RageUI.IsVisible(MEmployees, true, true, true, function()
                           for i=1, #EmployeesList do
                            local ply = EmployeesList[i]
                            RageUI.ButtonWithStyle(ply.name, false, {RightLabel = "~y~"..ply.job.grade_label.."~s~ →→"}, true, function(Hovered, Active, Selected)
                                if Selected then 
                                    employer = ply
                                end
                            end, MEmployees2)
                        end
                 end, function()
            end) 

                    RageUI.IsVisible(MEmployees2, true, true, true, function()
                        RageUI.Separator("~y~Emloyés :~s~ "..employer.name)
                        RageUI.Separator("~y~Grade :~s~ "..employer.job.grade_label)
                        RageUI.ButtonWithStyle("Virer", nil, {RightLabel = "~y~Exécuter~s~ →→"}, true, function(Hovered,Active,Selected)
                            if Selected then 
                                ESX.TriggerServerCallback('esx_society:setJob', function()
                                    RageUI.GoBack()
                                    Wait(500)
                                    RageUI.GoBack()
                                end, employer.identifier, 'unemployed', 0, 'fire')
                            end
                        end)
                  end, function()
            end)       
            if not RageUI.Visible(bbennys) and not RageUI.Visible(MEmployees) and not RageUI.Visible(MEmployees2) then
            bbennys = RMenu:DeleteType("Actions Patron", true)
        end
    end
end


function loadEmployes(society)
    EmployeesList = {}
    ESX.TriggerServerCallback('esx_society:getEmployees', function(employees)
        for i=1, #employees, 1 do
            table.insert(EmployeesList,  employees[i])
        end
    end, society)
end

---------------------------------------------

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' and ESX.PlayerData.job.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Bennys.pos.boss.position.x, Bennys.pos.boss.position.y, Bennys.pos.boss.position.z)
        if dist3 <= 7.0 and Bennys.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Bennys.pos.boss.position.x, Bennys.pos.boss.position.y, Bennys.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 125, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            local society = 'mechanic'
                            loadEmployes(society)
                            RefreshmechanicMoney()           
                            Bossbennys()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function RefreshmechanicMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietymechanicMoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function UpdateSocietymechanicMoney(money)
    societymechanicmoney = ESX.Math.GroupDigits(money)
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