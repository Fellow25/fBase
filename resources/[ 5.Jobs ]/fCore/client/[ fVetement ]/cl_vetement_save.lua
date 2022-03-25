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
  print("REFRESH_CLOTHE", #data)
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

function MenufVetements()
    local f_vetementsmenu = RageUI.CreateMenu("~u~Vêtements", "Vos vêtements")
    f_vetementsmenu:SetRectangleBanner(255, 165, 0)
        RageUI.Visible(f_vetementsmenu, not RageUI.Visible(f_vetementsmenu))
    while f_vetementsmenu do
        Wait(1)
            RageUI.IsVisible(f_vetementsmenu, true, true, true, function()
              if PlayerClothe == nil or #PlayerClothe == 0 then 
                RageUI.ButtonWithStyle("Aucune tenue enregistrée", nil, {}, true, function(Hovered, Active, Selected)
                  if (Selected) then
                    MenufVetements() 
                  end  
                end)
              else 
                for k,v in pairs(PlayerClothe) do
                  RageUI.List(v.name, utils, index.utils, nil, {}, true, function(Hovered, Active, Selected, Index)
                    index.utils = Index
                    if (Selected) then
                      if Index == 1 then                  
                         LoadClothe(v.clothe)
                         MenufVetements() 
                      elseif Index == 2 then 
                         TriggerServerEvent('fVetements:dropClothe', v.name)
                         MenufVetements() 
                      elseif Index == 3 then
                        local ClosestPlayer, ClosestDistance = GetClosestPlayer()
                        if ClosestPlayer ~= -1 and ClosestDistance <= 3.0 then 
                          TriggerServerEvent('fVetements:giveClothe', v.name, GetPlayerServerId(ClosestPlayer)) 
                          MenufVetements() 
                        else
                          RageUI.Popup({message = "~r~Personne à proximité"})
                        end 
                      end  
                    end 
                  end)
                end  
              end 
            end, function()
            end)
    
                if not RageUI.Visible(f_vetementsmenu) then
                  f_vetementsmenu = RMenu:DeleteType("f_vetementsmenu", true)
        end
    end
  end
  
  Keys.Register('F9', 'Vêtements', 'Ouvrir le menu vêtements', function()
        local open = false
        for _,v in pairs(position) do
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, v[1], v[2], v[3])
          if dist3 <= 15.0 then
            MenufVetements()
            open = true
          end
          end 
          if not open then
            ESX.ShowNotification("Vous n'êtes pas dans un magasin de vêtements!")
          end
  end)