ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(10)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

function MenuTouche()
    local MToucheMenu = RageUI.CreateMenu("~u~Menu touche", "Voici les touches du serveur")
    MToucheMenu:SetRectangleBanner(175, 175, 175)
    RageUI.Visible(MToucheMenu, not RageUI.Visible(MToucheMenu))
    while MToucheMenu do
        Wait(0)
            RageUI.IsVisible(MToucheMenu, true, true, true, function()	

                RageUI.Separator("Salut ~y~"..GetPlayerName(PlayerId()))

                RageUI.Checkbox("Touche du serveur",nil, toucheserveur,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
                        toucheserveur = Checked;
    
                        if Checked then
                            toucheserveur = true
                        else
                            toucheserveur = false
                        end
                    end
                end)
                
                if toucheserveur then
                RageUI.ButtonWithStyle("~m~Lever les bras",nil, {RightLabel = "~m~²"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                    end
                end)

                RageUI.ButtonWithStyle("~m~Pointer du doigts",nil, {RightLabel = "~m~B"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                    end
                end)
  
                RageUI.ButtonWithStyle("~m~Acroupir",nil, {RightLabel = "~m~CTRL"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                    end
                end)

                RageUI.ButtonWithStyle("~m~Intéraction",nil, {RightLabel = "~m~E"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                    end
                end)

                RageUI.ButtonWithStyle("~m~Chat",nil, {RightLabel = "~m~T"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                    end
                end)

                RageUI.ButtonWithStyle("~m~Menu personnel",nil, {RightLabel = "~m~F5"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                    end
                end)

                RageUI.ButtonWithStyle("~m~Menu travail",nil, {RightLabel = "~m~F6"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                    end
                end)

                RageUI.ButtonWithStyle("~m~Menu fouille",nil, {RightLabel = "~m~F7"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                    end
                end)

                RageUI.ButtonWithStyle("~m~Telephone",nil, {RightLabel = "~m~F1"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                    end
                end)
            end

            RageUI.Separator("")

            RageUI.Checkbox("Chat commande",nil, chatcommand,{},function(Hovered,Ative,Selected,Checked)
                if Selected then
                    chatcommand = Checked;

                    if Checked then
                        chatcommand = true
                    else
                        chatcommand = false
                    end
                end
            end)
            
            if chatcommand then

            RageUI.ButtonWithStyle("~m~Me",nil, {RightLabel = "~m~/me"}, true, function(Hovered, Active, Selected)
                if Selected then       
                        local me = MenuToucheKeyboardInput("Entrer votre /me", "", 30)
                        if me then
                            ExecuteCommand("me "..me)
                            RageUI.CloseAll()	
                        end	
                end
            end)

            RageUI.ButtonWithStyle("~m~Twitter",nil, {RightLabel = "~m~/twt"}, true, function(Hovered, Active, Selected)
                if Selected then       
						local twt = MenuToucheKeyboardInput("Entrer votre tweet", "", 30)
						if twt then
							ExecuteCommand("twt "..twt)
							RageUI.CloseAll()	
						end	
                end
            end)

            RageUI.ButtonWithStyle("~m~Anonyme",nil, {RightLabel = "~m~/ano"}, true, function(Hovered, Active, Selected)
                if Selected then       
                    local ooc = MenuToucheKeyboardInput("Entrer votre texte anonyme", "", 30)
                    if ooc then
                        ExecuteCommand("ano "..ooc)
                        RageUI.CloseAll()	
                    end	
            end
        end)

            RageUI.ButtonWithStyle("~m~Report",nil, {RightLabel = "~m~/report"}, true, function(Hovered, Active, Selected)
                if Selected then       
                    local report = MenuToucheKeyboardInput("Entrer votre report", "", 50)
                    if report then
                        ExecuteCommand("report "..report)
                        RageUI.CloseAll()	
                    end	
            end
        end)

            RageUI.ButtonWithStyle("~m~Porter",nil, {RightLabel = "~m~/porter"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    ExecuteCommand("porter") 
                    RageUI.CloseAll()     
                end
            end)

            RageUI.ButtonWithStyle("~m~Nettoyer le chat",nil, {RightLabel = "~m~/clear"}, true, function(Hovered, Active, Selected)
                if Selected then 
                    ExecuteCommand("clear") 
                    RageUI.CloseAll()     
                end
            end)
        end

        RageUI.Separator("~y~Bonne game à vous!")
				end, function()
				end)	

              if not RageUI.Visible(MToucheMenu) then
              MToucheMenu = RMenu:DeleteType("MToucheMenu", true)
        end
    end
end

Keys.Register('F2', 'MenuTouche', 'Ouvrir le menu touche', function()
        MenuTouche()
    end)

function MenuToucheKeyboardInput(TextEntry, ExampleText, MaxStringLenght)
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