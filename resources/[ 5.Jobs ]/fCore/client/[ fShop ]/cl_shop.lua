ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end)

Item = {
    Nourritures = {
    {Label = "Pain", Name = "bread", Price = 5},
    {Label = "Brownie", Name = "brownie", Price = 5},
    },

    Boissons = {
    {Label = "Eau", Name = "water", Price = 2},
    },

    Divers = {
    {Label = "Téléphone", Name = "phone", Price = 500},
    }
}

function OpenShop()
  local Shop = RageUI.CreateMenu("Supérette", "Voici nos produits")
  local ShopNourritures = RageUI.CreateSubMenu(Shop, "Supérette", "Nourritures")
  local ShopBoissons = RageUI.CreateSubMenu(Shop, "Supérette", "Boissons")
  local ShopDivers = RageUI.CreateSubMenu(Shop, "Supérette", "Divers")


  RageUI.Visible(Shop, not RageUI.Visible(Shop))

  
  while Shop do
      Wait(0)
      RageUI.IsVisible(Shop, true, true, true, function()
 
            RageUI.ButtonWithStyle("Nourritures", nil,  {}, true, function(Hovered, Active, Selected)
            end, ShopNourritures)

            RageUI.ButtonWithStyle("Boissons", nil,  {}, true, function(Hovered, Active, Selected)
            end, ShopBoissons)

            RageUI.ButtonWithStyle("Divers", nil,  {}, true, function(Hovered, Active, Selected)
            end, ShopDivers)

    end)

    RageUI.IsVisible(ShopNourritures, true, true, true, function()
        for k,v in pairs(Item.Nourritures) do
            RageUI.ButtonWithStyle(v.Label, nil, {RightLabel = "~g~"..(v.Price).."$"}, true, function(Hovered, Active, Selected)
              if (Selected) then
                  TriggerServerEvent('fellow:shop', v.Name, v.Price)
                end
            end)
        end
    end)

    RageUI.IsVisible(ShopBoissons, true, true, true, function()
        for k,v in pairs(Item.Boissons) do
            RageUI.ButtonWithStyle(v.Label, nil, {RightLabel = "~g~"..(v.Price).."$"}, true, function(Hovered, Active, Selected)
              if (Selected) then
                  TriggerServerEvent('fellow:shop', v.Name, v.Price)
                end
            end)
        end
    end)

    RageUI.IsVisible(ShopDivers, true, true, true, function()
        for k,v in pairs(Item.Divers) do
            RageUI.ButtonWithStyle(v.Label, nil, {RightLabel = "~g~"..(v.Price).."$"}, true, function(Hovered, Active, Selected)
              if (Selected) then
                  TriggerServerEvent('fellow:shop', v.Name, v.Price)
                end
            end)
        end
    end)

      if not RageUI.Visible(Shop) and not RageUI.Visible(ShopNourritures) and not RageUI.Visible(ShopBoissons) and not RageUI.Visible(ShopDivers) then
          Shop = RMenu:DeleteType("Shop", true)
        end
    end
end


local position = {
        {x = 373.875,   y = 325.896,  z = 103.566},
		{x = 2557.458,  y = 382.282,  z = 108.622},
		{x = -3038.939, y = 585.954,  z = 7.908},
		{x = -3241.927, y = 1001.462, z = 12.830},
		{x = 547.431,   y = 2671.710, z = 42.156},
		{x = 1961.464,  y = 3740.672, z = 32.343},
		{x = 2678.916,  y = 3280.671, z = 55.241},
        {x = 1729.216,  y = 6414.131, z = 35.037},
        {x = 1135.808,  y = -982.281,  z = 46.415},
		{x = -1222.915, y = -906.983,  z = 12.326},
		{x = -1487.553, y = -379.107,  z = 40.163},
		{x = -2968.243, y = 390.910,   z = 15.043},
		{x = 1166.024,  y = 2708.930,  z = 38.157},
        {x = 1392.562,  y = 3604.684,  z = 34.980},
        {x = -48.519,   y = -1757.514, z = 29.421},
		{x = 1163.373,  y = -323.801,  z = 69.205},
		{x = -707.501,  y = -914.260,  z = 19.215},
		{x = -1820.523, y = 792.518,   z = 138.118},
		{x = 1698.388,  y = 4924.404,  z = 42.063},
        {x = 25.82,  y = -1345.22,  z = 29.5},
        {x = -864.2,  y = -2409.29,  z = 14.03},
        {x = 967.74,  y = -1867.96,  z = 31.3}
    }    

CreateThread(function()
    for k, v in pairs(position) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, 52)
        SetBlipScale (blip, 0.6)
        SetBlipColour(blip, 18)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Supérette')
        EndTextCommandSetBlipName(blip)
    end
end)    
    
 CreateThread(function()
    while true do
        local sleep = 500
            for k in pairs(position) do
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
                    if dist <= 1.0 then
                    sleep = 0
                    RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour acheter des produits alimentaires", time_display = 1 })
                    if IsControlJustPressed(1,51) then
                        OpenShop()
                    end
                end
            end
        Wait(sleep)
    end
end)
