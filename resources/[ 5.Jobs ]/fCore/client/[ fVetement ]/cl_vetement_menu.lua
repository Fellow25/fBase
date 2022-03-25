ESX_READY = true 

if ESX_READY == true then 

  ESX = nil 

  CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Wait(0)
    end

    ESX.PlayerData = ESX.GetPlayerData()
  end)

end

local tshirt_1c, torso_1c, torso_2c, pants_1c, tshirt_2c, pants_2c, shoes_1c, shoes_2c, plyClothe = {}, {}, {}, {}, {}, {}, {}, {}, {}
local decals_1c, decals_2c, arms_1c, arms_2c, bags_1c, bags_2c, chain_1c, chain_2c, PlayerClothe  = {}, {}, {}, {}, {}, {}, {}, {}, {}

local firstSpawn, debug = true, false
local index = {
  tshirt_1 = 1, 
  tshirt_2 = 1,
  torso_1  = 1,
  torso_2  = 1,
  decals_1 = 1,
  decals_2 = 1,
  arms = 1,
  chain_1 = 1,
  chain_2 = 1,
  arms_2 = 0,
  bags_1 = 1,
  bags_2 = 1,
  pants_1  = 1,
  pants_2  = 1,
  shoes_1  = 1,
  shoes_2  = 1,

  utils = 1
}

local function GetPlayers()
  local players = {}

  for _,player in ipairs(GetActivePlayers()) do
    local ped = GetPlayerPed(player)

    if DoesEntityExist(ped) then
      table.insert(players, player)
    end
  end

  return players
end

local function GetClosestPlayer()
  local players = GetPlayers()
  local closestDistance = -1
  local closestPlayer = -1
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  
  for index,value in ipairs(players) do
    local target = GetPlayerPed(value)
    if(target ~= ply) then
      local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
      local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if(closestDistance == -1 or closestDistance > distance) then
          closestPlayer = value
          closestDistance = distance
        end
      end
    end
  return closestPlayer, closestDistance
end

function OpenKeyboard()
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 100)
  while (UpdateOnscreenKeyboard() == 0) do
   DisableAllControlActions(0);
   Wait(1)
  end
  if (GetOnscreenKeyboardResult()) then
    result = GetOnscreenKeyboardResult()
    if result == nil or result == '' then
      RageUI.Popup({message = "~r~Valeur incorrect !."})
    else 
      return result  
    end     
  end 
end

RegisterNetEvent('fVetements:loadPlayerClothe')
AddEventHandler('fVetements:loadPlayerClothe', function(data)
  PlayerClothe = data
end)

RegisterNetEvent('fVetements:Notification')
AddEventHandler('fVetements:Notification', function(text)
 RageUI.Popup({message = ""..text..""})
end)

RegisterNetEvent('fVetements:refreshClothe')
AddEventHandler('fVetements:refreshClothe', function(data)
  PlayerClothe = data
end)

AddEventHandler('onClientResourceStart', function (resourceName)
  if(GetCurrentResourceName() ~= resourceName) then
    return
  end
  TriggerServerEvent('fVetements:loadClothe')
end)

local utils = {
 'Mettre',
 'Jeter',
 'Donner',
}

function GetComponent()

	local tshirt_1Comp = GetNumberOfPedDrawableVariations(PlayerPedId(), 8)
	local torso_1Comp  = GetNumberOfPedDrawableVariations(PlayerPedId(), 11)
	local decals_1Comp = GetNumberOfPedDrawableVariations(PlayerPedId(), 10)
	local chain_1Comp  = GetNumberOfPedDrawableVariations(PlayerPedId(), 7)
	local arms_1Comp   = GetNumberOfPedDrawableVariations(PlayerPedId(), 3)
	local bags_1Comp   = GetNumberOfPedDrawableVariations(PlayerPedId(), 5)
	local pants_1Comp  = GetNumberOfPedDrawableVariations(PlayerPedId(), 4) 
	local shoes_1Comp  = GetNumberOfPedDrawableVariations(PlayerPedId(), 6) 
 
  for i=0, tshirt_1Comp, 1 do
	table.insert(tshirt_1c, 'Article n° : '..i)
	end  

	for i=0, torso_1Comp, 1 do
	table.insert(torso_1c, 'Article n° : '..i)
  end
  
	for i=0, decals_1Comp, 1 do
	table.insert(decals_1c, 'Article n° : '..i)
  end

  for i=0, chain_1Comp, 1 do
	table.insert(chain_1c, 'Article n° : '..i)
  end
  
	for i=0, arms_1Comp, 1 do
	table.insert(arms_1c, 'Article n° : '..i)
	end

	for i=0, bags_1Comp, 1 do
	table.insert(bags_1c, 'Article n° : '..i)
	end

  for i=0, pants_1Comp, 1 do
	table.insert(pants_1c, 'Article n° : '..i)
  end 
  
	for i=0, shoes_1Comp, 1 do
	table.insert(shoes_1c, 'Article n° : '..i)
	end
end


GetComponent()

function fVetements()
  local f_vetements = RageUI.CreateMenu("~u~Vêtements", "Acheter des vêtements")
  local tshirt = RageUI.CreateSubMenu(f_vetements, "~u~Vêtements", "T-shirt")
  local haut = RageUI.CreateSubMenu(f_vetements, "~u~Vêtements", "Haut")
  local calque = RageUI.CreateSubMenu(f_vetements, "~u~Vêtements", "Calque")
  local bras = RageUI.CreateSubMenu(f_vetements, "~u~Vêtements", "Bras")
  local chaine = RageUI.CreateSubMenu(f_vetements, "~u~Vêtements", "Chaine")
  local sac = RageUI.CreateSubMenu(f_vetements, "~u~Vêtements", "Sac")
  local pantalon = RageUI.CreateSubMenu(f_vetements, "~u~Vêtements", "Pantalon")
  local chaussure = RageUI.CreateSubMenu(f_vetements, "~u~Vêtements", "Chaussure")
  f_vetements:SetRectangleBanner(255, 165, 0)
  tshirt:SetRectangleBanner(255, 165, 0)
  haut:SetRectangleBanner(255, 165, 0)
  calque:SetRectangleBanner(255, 165, 0)
  bras:SetRectangleBanner(255, 165, 0)
  chaine:SetRectangleBanner(255, 165, 0)
  sac:SetRectangleBanner(255, 165, 0)
  pantalon:SetRectangleBanner(255, 165, 0)
  chaussure:SetRectangleBanner(255, 165, 0)

f_vetements.Closed = function()
 ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, _)
          TriggerEvent('skinchanger:loadSkin', skin)
  end)
end

 RageUI.Visible(f_vetements, not RageUI.Visible(f_vetements))

  while f_vetements do
      Wait(0)
      RageUI.IsVisible(f_vetements, true, true, true, function()

          RageUI.ButtonWithStyle("T-shirt" , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
          end, tshirt) 

          RageUI.ButtonWithStyle("Haut" , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
          end, haut) 

          RageUI.ButtonWithStyle("Calque" , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
           end, calque) 

          RageUI.ButtonWithStyle("Bras" , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
          end, bras) 

          RageUI.ButtonWithStyle("Chaine" , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
          end, chaine) 

          RageUI.ButtonWithStyle("Sac" , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
          end, sac) 

          RageUI.ButtonWithStyle("Pantalon" , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
          end, pantalon) 

         RageUI.ButtonWithStyle("Chaussure" , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
          end, chaussure) 

          RageUI.ButtonWithStyle("Passer à la caisse!" , nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, function(Hovered, Active, Selected)
            if (Selected) then
              local name = OpenKeyboard()
              if name == nil or name == '' then 
                RageUI.Popup({ message = "Vous devez ~r~ENTRER~w~ un nom pour votre tenue!" })
              else  
                table.insert(plyClothe, {
                  tshirt_1 = ptshirt_1 ,
                  tshirt_2 = ptshirt_2 ,
                  torso_1  = ptorso_1,
                  torso_2  = ptorso_2 ,
                  decals_1 = pdecals_1 ,
                  chain_1 = pchain_1 ,
                  chain_2 = pchain_2 ,
                  arms = parms_1 ,
                  arms_2 = parms_2,
                  bags_1 = pbags_1 ,
                  bags_2 = pbags_2 ,
                  pants_1  = ppants_1,
                  pants_2  = ppants_2,
                  shoes_1  = pshoes_1,
                  shoes_2  = pshoes_2
                })

                 if ESX_READY == true then  
                      ESX.TriggerServerCallback('fVetements:getPlayerSkin', function(cb)
                      comp = cb
                      if ptshirt_1 ~= nil then 
                        comp.tshirt_1 = ptshirt_1
                      end  
                      if ptshirt_2 ~= nil then  
                        comp.tshirt_2 = ptshirt_2
                      end
                      if ptorso_1 ~= nil then 
                        comp.torso_1  = ptorso_1
                      end
                      if ptorso_2 ~= nil then 
                        comp.torso_2  = ptorso_2
                      end
                      if pdecals_1 ~= nil then 
                        comp.decals_1 = pdecals_1
                      end
                      if pchain_1 ~= nil then 
                        comp.chain_1  = pchain_1
                      end

                      if parms_1 ~= nil then
                        comp.arms     = parms_1
                      end
                      if parms_2 ~= nil then
                        comp.arms_2  = parms_2
                      end
                      if pbags_1 ~= nil then 
                        comp.bags_1   = pbags_1
                      end
                      if pbags_2 ~= nil then 
                        comp.bags_2   = pbags_2
                      end
                      if ppants_1 ~= nil then 
                        comp.pants_1  = ppants_1
                      end
                      if ppants_2 ~= nil then 
                        comp.pants_2  = ppants_2
                      end
                      if pshoes_1 ~= nil then 
                        comp.shoes_1  = pshoes_1 
                      end
                      if pshoes_2 ~= nil then 
                        comp.shoes_2  = pshoes_2
                      end

                      TriggerEvent('skinchanger:loadSkin', comp)
                    end)
                end
                ESX.TriggerServerCallback('fVetements:buyClothes', function(argent)
                  if argent then
                    TriggerServerEvent('fVetements:saveClothe', name, plyClothe) 
                  else
                    ESX.ShowNotification("Vous n'avez assez ~r~d'argent")
                  end
                end)
              end  
            end
          end) 

        end, function()
        end)


        RageUI.IsVisible(tshirt, true, true, true, function()
        RageUI.List("T-shirt : ", tshirt_1c, index.tshirt_1, nil, {}, true, function(Hovered, Active, Selected, Index)

          index.tshirt_1 = Index
      
          if (Active) then

            SetPedComponentVariation(PlayerPedId(), 8,  Index-1, ptshirt_2 or 0, 2)
 
            local tshirt_2Comp = 1
            tshirt_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 8, Index-1)
            tshirt_2c = {}

            if debug then 
            end  

            for i=0, tshirt_2Comp, 1 do
              table.insert(tshirt_2c, 'Variation n° : '..i)
            end
             ptshirt_1 = Index-1
          end
        end)

        if #tshirt_2c ~= 0 and ptshirt_1 ~= 15 then 
          RageUI.List('Couleur : ', tshirt_2c, index.tshirt_2, nil, {}, true, function(Hovered, Active, Selected, Index)
            index.tshirt_2 = Index

            if (Active) then
              SetPedComponentVariation(PlayerPedId(), 8, ptshirt_1, Index-1, 2) 
              ptshirt_2 = Index-1
            end
          end)
        end 
         RageUI.ButtonWithStyle('Valider vos articles', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
            if (Selected) then 
             RageUI.GoBack()
            end
         end)
        end, function()
        end)

         RageUI.IsVisible(haut, true, true, true, function()
         RageUI.List('Haut : ', torso_1c, index.torso_1, nil, {}, true, function(Hovered, Active, Selected, Index)
          
          index.torso_1 = Index

          if (Active) then
            
            SetPedComponentVariation(PlayerPedId(), 11, Index-1, ptorso_2 or 0, 2)

            local torso_2Comp = 1 
            torso_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 11, Index-1)
            torso_2c = {}

            if debug then 
            end 

            for i=0, torso_2Comp, 1 do
              table.insert(torso_2c, 'Variation n° : '..i)
            end

            ptorso_1 = Index-1
          end
        end)

        if #torso_2c ~= 0 then 
          RageUI.List('Couleur :', torso_2c, index.torso_2, nil, {}, true, function(Hovered, Active, Selected, Index)
            index.torso_2 = Index 

            if (Active) then 
 
              SetPedComponentVariation(PlayerPedId(), 11, ptorso_1, Index-1, 2)
              ptorso_2 = Index-1
            end 
          end)
        end

        RageUI.ButtonWithStyle('Valider vos articles', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
            if (Selected) then 
                RageUI.GoBack()
            end
         end)

        end, function()
        end)

        RageUI.IsVisible(calque, true, true, true, function()
        RageUI.List('Calque', decals_1c, index.decals_1, nil, {}, true, function(Hovered, Active, Selected, Index)
          index.decals_1 = Index 

          if (Active) then 
            SetPedComponentVariation(PlayerPedId(), 10, Index-1, 0, 2)

            local decals_2Comp = 1 
            decals_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 10, Index-1)
            decals_2c = {}

            if debug then 
            end  

            for i=0, decals_2Comp, 1 do
              table.insert(decals_2c, 'Variation n° : '..i)
            end
              pdecals_1 = Index-1
          end
        end) 

        RageUI.ButtonWithStyle('Valider vos articles', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
            if (Selected) then 
               RageUI.GoBack()
            end
         end)

        end, function()
        end)

          RageUI.IsVisible(bras, true, true, true, function()       
          RageUI.List('Bras', arms_1c, index.arms, nil, {}, true, function(Hovered, Active, Selected, Index)
          index.arms = Index 

          if (Active) then 
            SetPedComponentVariation(PlayerPedId(), 3, Index-1, parms_2 or 0, 2)

            local arms_2Comp = 1 
            arms_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 3, Index-1)
            arms_2c = {}

            if debug then 
            end  

            for i=0, arms_2Comp, 1 do
              table.insert(arms_2c, 'Variation n° : '..i)
            end

            parms_1 = Index-1

          end
        end) 

        if #arms_2c ~= 0 then
          RageUI.List('Variation bras : ', arms_2c, index.arms_2, nil, {}, true, function(Hovered, Active, Selected, Index)
            index.arms_2 = Index

            if (Active) then 

              SetPedComponentVariation(PlayerPedId(), 3, parms_1, Index-1, 2)
               arms_2 = Index-1
            end
          end)
        end  

        RageUI.ButtonWithStyle('Valider vos articles', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
            if (Selected) then 
                RageUI.GoBack()
            end
         end)

        end, function()
        end)

        RageUI.IsVisible(chaine, true, true, true, function()
        RageUI.List('Chaine', chain_1c, index.chain_1, nil, {}, true, function(Hovered, Active, Selected, Index)
          index.chain_1 = Index 

            if (Active) then 
                SetPedComponentVariation(PlayerPedId(), 7, Index-1, pchain_2 or 0, 2)
                local chain_2Comp = 1 
                chain_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 7, Index-1)
                chain_2c = {}

              if debug then 
              end  

              for i=0, chain_2Comp, 1 do
                table.insert(chain_2c, 'Variation n° : '..i)
              end
               pchain_1 = Index-1
            end
        end) 


        RageUI.ButtonWithStyle('Valider vos articles', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
            if (Selected) then 
               RageUI.GoBack() 
            end
         end)

        end, function()
        end)


          RageUI.IsVisible(sac, true, true, true, function()
          RageUI.List('Sac', bags_1c, index.bags_1, nil, {}, true, function(Hovered, Active, Selected, Index)
          index.bags_1 = Index 

          if (Active) then 
            SetPedComponentVariation(PlayerPedId(), 5, Index-1, 0, 2)

            local bags_2Comp = 1 
            bags_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 5, Index-1)
            bags_2c = {}

            if debug then 
            end  

            for i=0, bags_2Comp, 1 do
              table.insert(bags_2c, 'Variation n° : '..i)
            end

            pbags_1 = Index-1
          end

        end) 

        if #bags_2c ~= 0 then
          RageUI.List('Couleur : ', bags_2c, index.bags_2, nil, {}, true, function(Hovered, Active, Selected, Index)
            index.bags_2 = Index
      
            if (Active) then 
      
              SetPedComponentVariation(PlayerPedId(), 5, pbags_1, Index-1, 2)
               pbags_2 = Index-1
            end
          end)
        end  

        RageUI.ButtonWithStyle('Valider vos articles', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
            if (Selected) then 
                RageUI.GoBack()
            end
         end)

        end, function()
        end)

         RageUI.IsVisible(pantalon, true, true, true, function()
         RageUI.List('Pantalon : ', pants_1c, index.pants_1, nil, {}, true, function(Hovered, Active, Selected, Index)
          index.pants_1 = Index

          if (Active) then 
      
            SetPedComponentVariation(PlayerPedId(), 4, Index-1, ppants_2 or 0, 2)

            local pants_2Comp = 1
            pants_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 4, Index-1)
            pants_2c = {}

            if debug then 
            end 

            for i=0, pants_2Comp, 1 do
              table.insert(pants_2c, 'Variation n° : '..i)
            end
             ppants_1 = Index-1
          end 
        end)

        if #pants_2c ~= 0 then
          RageUI.List('Couleur : ', pants_2c, index.pants_2, nil, {}, true, function(Hovered, Active, Selected, Index)
            index.pants_2 = Index

            if (Active) then 

              SetPedComponentVariation(PlayerPedId(), 4, ppants_1, Index-1, 2)
               ppants_2 = Index-1
            end
          end)
        end  

        RageUI.ButtonWithStyle('Valider vos articles', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
            if (Selected) then 
              RageUI.GoBack()
            end
         end)

        end, function()
        end)

         RageUI.IsVisible(chaussure, true, true, true, function()
         RageUI.List('Chaussure : ', shoes_1c, index.shoes_1, nil, {}, true, function(Hovered, Active, Selected, Index)
          index.shoes_1 = Index 

          if (Active) then 
            SetPedComponentVariation(PlayerPedId(), 6, Index-1, pshoes_2 or 0, 2)

            local shoes_2Comp = 1
            shoes_2Comp = GetNumberOfPedTextureVariations(PlayerPedId(), 6, Index-1) 
            shoes_2c = {}

            if debug then 
            end 

            for i=0, shoes_2Comp, 1 do
              table.insert(shoes_2c, 'Variation n° : '..i)
            end

             pshoes_1 = Index-1
          end

        end)

        if #shoes_2c ~= 0 then 
          RageUI.List('Couleur : ',shoes_2c, index.shoes_2, nil, {}, true, function(Hovered, Active, Selected, Index)
            index.shoes_2 = Index

            if (Active) then 
  
              SetPedComponentVariation(PlayerPedId(), 6, pshoes_1, Index-1, 2)
               pshoes_2 = Index-1 
            end
          end)
        end  



        RageUI.ButtonWithStyle('Valider vos articles', nil, {RightBadge = RageUI.BadgeStyle.Clothes}, true, function(Hovered, Active, Selected)
            if (Selected) then 
                RageUI.GoBack()
            end
         end)

        end, function()
        end)

        if not RageUI.Visible(f_vetements) and not RageUI.Visible(tshirt) and not RageUI.Visible(haut) and not RageUI.Visible(calque) and not RageUI.Visible(bras) and not RageUI.Visible(chaine) and not RageUI.Visible(sac) and not RageUI.Visible(pantalon) and not RageUI.Visible(chaussure) then
          f_vetements = RMenu:DeleteType("f_vetements", true)
        end
    end
end

function LoadClothe(clothe)
    for _,v in pairs(clothe) do

	    if ESX_READY == true then  
	        ESX.TriggerServerCallback('fVetements:getPlayerSkin', function(cb)
			    comp = cb
			    comp.tshirt_1 = v.tshirt_1 or 15
			    comp.tshirt_2 = v.tshirt_2 
			    comp.torso_1  = v.torso_1
			    comp.torso_2  = v.torso_2
			    comp.chain_1  = v.chain_1
			    comp.arms     = v.arms or v.arms_1 or 5
			    comp.bags_1   = v.bags_1
			    comp.pants_1  = v.pants_1
			    comp.pants_2  = v.pants_2
			    comp.shoes_1  = v.shoes_1 
		      comp.shoes_2  = v.shoes_2

		        TriggerEvent('skinchanger:loadSkin', comp)
		        TriggerServerEvent('esx_skin:save', comp)
		    end)  
		end
    end

    CreateThread(function()
	    RequestAnimDict('clothingtie')
	    while not HasAnimDictLoaded('clothingtie') do
	      Wait(1)
	    end
	    TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_a', 1.0, -1.0, 2667, 0, 1, true, true, true)
    end)
end