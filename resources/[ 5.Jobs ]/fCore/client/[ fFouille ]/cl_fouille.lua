ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

local Items = {}      -- Item que le joueur possède (se remplit lors d'une fouille)
local Armes = {}    -- Armes que le joueur possède (se remplit lors d'une fouille)
local ArgentSale = {}  -- Argent sale que le joueur possède (se remplit lors d'une fouille)
local IsHandcuffed, DragStatus = false, {}
DragStatus.IsDragged          = false

local PlayerData = {}

local function MarquerJoueur()
        local ped = GetPlayerPed(ESX.Game.GetClosestPlayer())
        local pos = GetEntityCoords(ped)
        local target, distance = ESX.Game.GetClosestPlayer()
end

-- Reprise du menu fouille du pz_core (modifié)
local function getPlayerInv(player)
    Items = {}
    Armes = {}
    ArgentSale = {}
    
    ESX.TriggerServerCallback('fellow:getOtherPlayerData', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
                table.insert(ArgentSale, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'black_money',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })
    
                break
            end
        end
    
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(Items, {
                    label    = data.inventory[i].label,
                    right    = data.inventory[i].count,
                    value    = data.inventory[i].name,
                    itemType = 'item_standard',
                    amount   = data.inventory[i].count
                })
            end
        end
    end, GetPlayerServerId(player))
    end

--menu

function MenuFouille()
    local fFouille = RageUI.CreateMenu("Menu Fouille", "Interactions")
    local fFouilleSub = RageUI.CreateSubMenu(fFouille, "Menu Fouille", "Interactions")
        RageUI.Visible(fFouille, not RageUI.Visible(fFouille))
            while fFouille do
                Wait(0)
                    RageUI.IsVisible(fFouille, true, true, true, function()

            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            local target, distance = ESX.Game.GetClosestPlayer()
            playerheading = GetEntityHeading(PlayerPedId())
            playerlocation = GetEntityForwardVector(PlayerPedId())
            playerCoords = GetEntityCoords(PlayerPedId())
            local target_id = GetPlayerServerId(target)
            local searchPlayerPed = GetPlayerPed(target)
            RageUI.ButtonWithStyle('Fouiller', nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, function(_, a, s)
                if a then
                    MarquerJoueur()
                    if s then
                    getPlayerInv(closestPlayer)
                    --ExecuteCommand("me fouille l'individu")
                end
            end
            end, fFouilleSub) 


                    local searchPlayerPed = GetPlayerPed(target)
            
        RageUI.ButtonWithStyle("Carte d'identité", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
                    playerheading = GetEntityHeading(PlayerPedId())
                    playerlocation = GetEntityForwardVector(PlayerPedId())
                    playerCoords = GetEntityCoords(PlayerPedId())
                    local target_id = GetPlayerServerId(target)
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then  
                    ESX.ShowNotification("Recherche en cours...")
                    Wait(2000)
                    carteidentite(closestPlayer)
            else
                ESX.ShowNotification('Aucun joueurs à proximité')
            end
            end
        end)
    
            local searchPlayerPed = GetPlayerPed(target)
            
        RageUI.ButtonWithStyle("Menotter/démenotter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local target, distance = ESX.Game.GetClosestPlayer()
                playerheading = GetEntityHeading(PlayerPedId())
                playerlocation = GetEntityForwardVector(PlayerPedId())
                playerCoords = GetEntityCoords(PlayerPedId())
                local target_id = GetPlayerServerId(target)
                if closestPlayer ~= -1 and closestDistance <= 3.0 then   
                TriggerServerEvent('fellow:handcuff', GetPlayerServerId(closestPlayer))
            else
                ESX.ShowNotification('Aucun joueurs à proximité')
            end
            end
        end)
    
            local searchPlayerPed = GetPlayerPed(target)
            
            RageUI.ButtonWithStyle("Escorter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
                    playerheading = GetEntityHeading(PlayerPedId())
                    playerlocation = GetEntityForwardVector(PlayerPedId())
                    playerCoords = GetEntityCoords(PlayerPedId())
                    local target_id = GetPlayerServerId(target)
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then  
                TriggerServerEvent('fellow:drag', GetPlayerServerId(closestPlayer))
            else
                ESX.ShowNotification('Aucun joueurs à proximité')
            end
            end
        end)
        
            local searchPlayerPed = GetPlayerPed(target)
            
            RageUI.ButtonWithStyle("Mettre dans un véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
                    playerheading = GetEntityHeading(PlayerPedId())
                    playerlocation = GetEntityForwardVector(PlayerPedId())
                    playerCoords = GetEntityCoords(PlayerPedId())
                    local target_id = GetPlayerServerId(target)
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then  
                TriggerServerEvent('fellow:putInVehicle', GetPlayerServerId(closestPlayer))
            else
                ESX.ShowNotification('Aucun joueurs à proximité')
            end
                end
            end)
        
            local searchPlayerPed = GetPlayerPed(target)
            
            RageUI.ButtonWithStyle("Sortir du véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
                    playerheading = GetEntityHeading(PlayerPedId())
                    playerlocation = GetEntityForwardVector(PlayerPedId())
                    playerCoords = GetEntityCoords(PlayerPedId())
                    local target_id = GetPlayerServerId(target)
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then  
                TriggerServerEvent('fellow:OutVehicle', GetPlayerServerId(closestPlayer))
            else
                ESX.ShowNotification('Aucun joueurs à proximité')
            end
            end
        end)
        

        end, function()
        end)

        RageUI.IsVisible(fFouilleSub, true, true, true, function()
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
            RageUI.Separator("Vous Fouiller : " ..GetPlayerName(closestPlayer))

            RageUI.Separator("↓ ~r~Argent non déclaré ~s~↓")
            for k,v  in pairs(ArgentSale) do
                RageUI.ButtonWithStyle("Argent non déclaré :", nil, {RightLabel = "~g~"..v.label.."$"}, true, function(_, _, s)
                    if s then
                        local combien = KeyboardInput("Combien ?", '' , '', 8)
                        if tonumber(combien) > v.amount then
                            RageUI.Popup({message = "~r~Quantité invalide"})
                        else
                            TriggerServerEvent('fellow:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                        end
                        RageUI.GoBack()
                    end
                end)
            end
    
            RageUI.Separator("↓ ~r~Objets / Armes ~s~↓")
            for k,v  in pairs(Items) do
                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~g~x"..v.right}, true, function(_, _, s)
                    if s then
                        local combien = KeyboardInput("Combien ?", '' , '', 8)
                        if tonumber(combien) > v.amount then
                            RageUI.Popup({message = "~r~Quantité invalide"})
                        else
                            TriggerServerEvent('fellow:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                        end
                        RageUI.GoBack()
                    end
                end)
            end
    
            end, function() 
            end)

            if not RageUI.Visible(fFouille) and not RageUI.Visible(fFouilleSub) then
                fFouille = RMenu:DeleteType("Menu Fouille", true)
            end
        end
    end

Keys.Register('F7', 'fouille', 'Ouvrir le menu fouille', function()
if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'unemployed2' then
TriggerEvent('fellow:MenuFouille')
end
end)


function carteidentite(player)
    local StockFouille = RageUI.CreateMenu("Carte d'identité", "Informations")
    ESX.TriggerServerCallback('fFouille:getOtherPlayerData', function(data)
    RageUI.Visible(StockFouille, not RageUI.Visible(StockFouille))
        while StockFouille do
            Wait(0)
                RageUI.IsVisible(StockFouille, true, true, true, function()
                            RageUI.ButtonWithStyle("Prenom & Nom : ", nil, {RightLabel = data.name}, true, function(Hovered, Active, Selected)
                                if Selected then
                                end
                            end)
                            RageUI.ButtonWithStyle("Sexe : ", nil, {RightLabel = data.sex}, true, function(Hovered, Active, Selected)
                                if Selected then
                                end
                            end)
                            RageUI.ButtonWithStyle("Taille : ", nil, {RightLabel = data.height}, true, function(Hovered, Active, Selected)
                                if Selected then
                                end
                            end)
                            RageUI.ButtonWithStyle("Né le : ", nil, {RightLabel = data.dob}, true, function(Hovered, Active, Selected)
                                if Selected then
                                end
                            end)
                            RageUI.ButtonWithStyle("Metier : ", nil, {RightLabel = data.job.." - "..data.grade}, true, function(Hovered, Active, Selected)
                                if Selected then
                                end
                            end)
                            RageUI.ButtonWithStyle("Orga : ", nil, {RightLabel = data.job2.." - "..data.grade2}, true, function(Hovered, Active, Selected)
                                if Selected then
                                end
                            end)
                            RageUI.Separator("↓ Permis ↓")
                            for i=1, #data.licenses, 1 do
                            RageUI.ButtonWithStyle(data.licenses[i].label, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                                if Selected then
                                end
                            end)
                        end
                end, function()
                end)
            if not RageUI.Visible(StockFouille) then
            StockFouille = RMenu:DeleteType("Carte d'identite", true)
        end
    end
end, GetPlayerServerId(player))
end


--------- Imput

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)


    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

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

-------------------------- Intéraction 

RegisterNetEvent('fellow:handcuff')
AddEventHandler('fellow:handcuff', function()

  IsHandcuffed    = not IsHandcuffed;
  local playerPed = PlayerPedId()

  CreateThread(function()

    if IsHandcuffed then

        RequestAnimDict('mp_arresting')
        while not HasAnimDictLoaded('mp_arresting') do
            Wait(100)
        end

      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      DisableControlAction(2, 37, true)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)
      DisableControlAction(0, 24, true) -- Attack
      DisableControlAction(0, 257, true) -- Attack 2
      DisableControlAction(0, 25, true) -- Aim
      DisableControlAction(0, 263, true) -- Melee Attack 1
      DisableControlAction(0, 37, true) -- Select Weapon
      DisableControlAction(0, 47, true)  -- Disable weapon
      

    else

      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)

    end

  end)
end)

RegisterNetEvent('fellow:drag')
AddEventHandler('fellow:drag', function(cop)
  TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = PlayerPedId()
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(PlayerPedId(), true, false)
      end
    end
  end
end)

RegisterNetEvent('fellow:putInVehicle')
AddEventHandler('fellow:putInVehicle', function()

  local playerPed = PlayerPedId()
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)

    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end

      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end

    end

  end

end)

RegisterNetEvent('fellow:OutVehicle')
AddEventHandler('fellow:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(PlayerPedId(),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2

  SetEntityCoords(PlayerPedId(), xnew, ynew, plyPos.z)
end)

-- Handcuff
CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 30,  true) -- MoveLeftRight
      DisableControlAction(0, 31,  true) -- MoveUpDown
    end
  end
end)

RegisterNetEvent('fellow:MenuFouille')
AddEventHandler('fellow:MenuFouille', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local target, distance = ESX.Game.GetClosestPlayer()
    playerheading = GetEntityHeading(PlayerPedId())
    playerlocation = GetEntityForwardVector(PlayerPedId())
    playerCoords = GetEntityCoords(PlayerPedId())
    local target_id = GetPlayerServerId(target)
    local searchPlayerPed = GetPlayerPed(target)
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
    MenuFouille()
else
    ESX.ShowNotification('Aucun joueurs à proximité')
end
end)