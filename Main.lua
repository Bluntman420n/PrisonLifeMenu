local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

function prison_life()
    local hub = library.CreateLib("NinjaMenu | Prison Life","BloodTheme")
    local main = hub:NewTab("Main")
    local mainsec = main:NewSection("Main")
    local trolling = hub:NewTab("Trolling")
    local trollingsec = trolling:NewSection("Trolling")
    local toggles = hub:NewTab("Toggles")
    local togglesec = toggles:NewSection("Toggles")
    local player = hub:NewTab("Player")
    local playersec = player:NewSection("Player")
    local flying = false
    local teleports = hub:NewTab("Teleports")
    local teleportsec = teleports:NewSection("Teleports")
    
    getgenv().godmode = false
    getgenv().noclip = false
    getgenv().alerts = false
    getgenv().changedwalkspeed = false
    getgenv().walkspeed = 0
    getgenv().changedjumppower = false
    getgenv().jumppower = 0
    getgenv().changedhipheight = false
    getgenv().hipheight = 0
    getgenv().onepunch = false
    
    function findplayer(stringg)
    	for _, v in pairs(game.Players:GetPlayers()) do
    		if stringg:lower() == (v.Name:lower()):sub(1, #stringg) then
    			return v
    		elseif stringg:lower() == (v.DisplayName:lower()):sub(1, #stringg) then
    			return v
    		end
    	end
    end
    
    togglesec:NewToggle("Joined/Left alerts","Gives you an alert when a player joins or left",function(state)
        getgenv().alerts = state
    end)
    
    playersec:NewTextBox("WalkSpeed","Sets your WalkSpeed",function(txt)
        getgenv().changedwalkspeed = true
        if tonumber(txt) then
            getgenv().walkspeed = tonumber(txt)
        end
    end)
    
    playersec:NewTextBox("JumpPower","Sets your JumpPower",function(txt)
        getgenv().changedjumppower = true
        if tonumber(txt) then
            getgenv().jumppower = tonumber(txt)
        end
    end)
    
    playersec:NewTextBox("HipHeight","Sets your HipHeight",function(txt)
        getgenv().changedhipheight = true
        if tonumber(txt) then
            getgenv().hipheight = tonumber(txt)
        end
    end)
    
    
    mainsec:NewButton("No Doors","Removes All Doors",function()
        game.Workspace.Doors:Destroy()
        game.Workspace.Prison_Cellblock.doors:Destroy()
        local Warehouses = game.Workspace.Warehouses
        for i,v in pairs(Warehouses:GetDescendants()) do
            if v.Name == "doors" then
               v:Destroy()
            end
        end
    end)
    
    playersec:NewButton("Flight (E)","Allows you to fly",function()
        repeat wait()
        until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Torso") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid")
        local mouse = game.Players.LocalPlayer:GetMouse()
        repeat wait() until mouse
        local plr = game.Players.LocalPlayer
        local torso = plr.Character.Torso
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 50
        local speed = 0
        
        function Fly()
            local bg = Instance.new("BodyGyro", torso)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = torso.CFrame
            local bv = Instance.new("BodyVelocity", torso)
            bv.velocity = Vector3.new(0,0.1,0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            repeat wait()
            plr.Character.Humanoid.PlatformStand = true
            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
            speed = speed+.5+(speed/maxspeed)
            if speed > maxspeed then
            speed = maxspeed
            end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
            speed = speed-1
            if speed < 0 then
            speed = 0
            end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
            bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
            bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
            else
            bv.velocity = Vector3.new(0,0.1,0)
            end
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
            until not flying
            ctrl = {f = 0, b = 0, l = 0, r = 0}
            lastctrl = {f = 0, b = 0, l = 0, r = 0}
            speed = 0
            bg:Destroy()
            bv:Destroy()
            plr.Character.Humanoid.PlatformStand = false
            end
            mouse.KeyDown:connect(function(key)
            if key:lower() == "e" then
            if flying then flying = false
            else
            flying = true
            Fly()
            end
            elseif key:lower() == "w" then
            ctrl.f = 1
            elseif key:lower() == "s" then
            ctrl.b = -1
            elseif key:lower() == "a" then
            ctrl.l = -1
            elseif key:lower() == "d" then
            ctrl.r = 1
        end
    end)
        mouse.KeyUp:connect(function(key)
        if key:lower() == "w" then
        ctrl.f = 0
        elseif key:lower() == "s" then
        ctrl.b = 0
        elseif key:lower() == "a" then
        ctrl.l = 0
        elseif key:lower() == "d" then
        ctrl.r = 0
        end
        end)
        Fly()
    end)
    
    trollingsec:NewTextBox("Arrest Player", "Arrest the player", function(txt)
        if txt == "all" then
            for i,v in pairs(game.Teams.Criminals:GetPlayers()) do
                if v ~= game.Players.LocalPlayer then
                    i = 0
                    repeat wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                        game.Workspace.Remote.arrest:InvokeServer(v.Character.HumanoidRootPart)
                        i = i + 1
                    until i == 10
                end
            end
        else
        	local plr = findplayer(txt)
            if plr then
                local i = 0
                repeat wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
                    game.Workspace.Remote.arrest:InvokeServer(plr.Character.HumanoidRootPart)
                    i = i + 1
                until i == 10
            end
        end
    end)
    
    trollingsec:NewTextBox("To Player", "Teleports to the player", function(txt)
    	local plr = findplayer(txt)
        if plr then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
    	end
    end)
    
    mainsec:NewButton("Give All Items","Gives all items to the LocalPlayer",function()
        for i,v in pairs(game.Workspace.Prison_ITEMS.single:GetChildren()) do
            if v:FindFirstChild("ITEMPICKUP") then
                game.Workspace.Remote.ItemHandler:InvokeServer(v.ITEMPICKUP)
            end
        end
        
        for i,v in pairs(game.Workspace.Prison_ITEMS.giver:GetChildren()) do
            if v:FindFirstChild("ITEMPICKUP") then
                game.Workspace.Remote.ItemHandler:InvokeServer(v.ITEMPICKUP)
            end
        end
    end)
    
    playersec:NewToggle("Noclip","Allows you to walk through wall",function(state)
        getgenv().noclip = state
    end)
    
    togglesec:NewToggle("GodMode","Automatically respawns you",function(state)
         getgenv().godmode = state
    end)
    
    mainsec:NewDropdown("Change Team","Changes your team",{"Criminal","Neutral","Gaurd","Inmate"},function(v)
        if v == "Criminal" then
            local weld02 = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-919.958, 95.327, 2138.189)
    		wait(1)
    		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(weld02)
        elseif v == "Inmate" then
            game.Workspace.Remote.TeamEvent:FireServer("Bright orange")
        elseif v == "Gaurd" then
            game.Workspace.Remote.TeamEvent:FireServer("Bright blue")
        elseif v == "Neutral" then
            game.Workspace.Remote.TeamEvent:FireServer("Medium stone grey")
        end
    end)
    
    playersec:NewButton("Naked","No clothes for you",function()
        for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
    		if v:IsA("Clothing") or v:IsA("ShirtGraphic") then
    			v:Destroy()
    		end
    	end
    end)
    
    trollingsec:NewTextBox("Bring Player","Brings a player to you",function(txt)
        game.Workspace.Remote.ItemHandler:InvokeServer(game.Workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
            local Target = findplayer(txt).Name
            if Target then
                NOW = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                game.Players.LocalPlayer.Character.Humanoid.Name = 1
                local l = game.Players.LocalPlayer.Character["1"]:Clone()
                l.Parent = game.Players.LocalPlayer.Character
                l.Name = "Humanoid"
                wait()
                game.Players.LocalPlayer.Character["1"]:Destroy()
                game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
                game.Players.LocalPlayer.Character.Animate.Disabled = true
                wait()
                game.Players.LocalPlayer.Character.Animate.Disabled = false
                game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["Remington 870"])
                local function tp(player,player2)
                local char1,char2=player.Character,player2.Character
                if char1 and char2 then
                char1.HumanoidRootPart.CFrame = char2.HumanoidRootPart.CFrame
                end
                end
                local function getout(player,player2)
                local char1,char2=player.Character,player2.Character
                if char1 and char2 then
                char1:MoveTo(char2.Head.Position)
                end
                end
                tp(game.Players[Target], game.Players.LocalPlayer)
                wait()
                tp(game.Players[Target], game.Players.LocalPlayer)
                wait()
                getout(game.Players.LocalPlayer, game.Players[Target])
                wait(5)
                game.Workspace.Remote.loadchar:InvokeServer(game.Players.LocalPlayer.Name)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = NOW
            end
    end)
    
    trollingsec:NewTextBox("Force Criminal","Makes the player a criminal (Takes one or two tries)",function(txt)
        game.Workspace.Remote.ItemHandler:InvokeServer(game.Workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP)
        local Target = findplayer(txt).Name
        if Target then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-919.958, 95.327, 2138.189)
            game.Players.LocalPlayer.Character.Humanoid.Name = 1
            local l = game.Players.LocalPlayer.Character["1"]:Clone()
            l.Parent = game.Players.LocalPlayer.Character
            l.Name = "Humanoid"
            wait()
            game.Players.LocalPlayer.Character["1"]:Destroy()
            game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
            game.Players.LocalPlayer.Character.Animate.Disabled = true
            wait()
            game.Players.LocalPlayer.Character.Animate.Disabled = false
            game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["Remington 870"])
            local function tp(player,player2)
            local char1,char2=player.Character,player2.Character
            if char1 and char2 then
            char1.HumanoidRootPart.CFrame = char2.HumanoidRootPart.CFrame
            end
            end
            local function getout(player,player2)
            local char1,char2=player.Character,player2.Character
            if char1 and char2 then
            char1:MoveTo(char2.Head.Position)
            end
            end
            tp(game.Players[Target], game.Players.LocalPlayer)
            wait()
            tp(game.Players[Target], game.Players.LocalPlayer)
            wait()
            getout(game.Players.LocalPlayer, game.Players[Target])
            wait(1)
            game.Workspace.Remote.loadchar:InvokeServer(game.Players.LocalPlayer.Name)
        end
    end)
    
    game:GetService("RunService").RenderStepped:Connect(function()
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 and getgenv().godmode then
            local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            game.Workspace.Remote.loadchar:InvokeServer(game.Players.LocalPlayer.Name)  
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
        end
        if getgenv().noclip then
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState(11)
            end
        end
        if getgenv().changedwalkspeed then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().walkspeed
        end
        if getgenv().changedjumppower then
            game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().jumppower
        end
        if getgenv().changedhipheight then
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = getgenv().hipheight
        end
    end)
    
            mainRemotes = game.ReplicatedStorage
    meleeRemote = mainRemotes['meleeEvent']
    mouse = game.Players.LocalPlayer:GetMouse()
    punching = false
    cooldown = false
    
    function punch()
    cooldown = true
    local part = Instance.new("Part", game.Players.LocalPlayer.Character)
    part.Transparency = 1
    part.Size = Vector3.new(5, 2, 3)
    part.CanCollide = false
    local w1 = Instance.new("Weld", part)
    w1.Part0 = game.Players.LocalPlayer.Character.Torso
    w1.Part1 = part
    w1.C1 = CFrame.new(0,0,2)
    part.Touched:connect(function(hit)
    if game.Players:FindFirstChild(hit.Parent.Name) then
    local plr = game.Players:FindFirstChild(hit.Parent.Name)
    if plr.Name ~= game.Players.LocalPlayer.Name then
    part:Destroy()
    
    for i = 1,100 do
    meleeRemote:FireServer(plr)
    end
    end
    end
    end)
    
    wait(1)
    cooldown = false
    part:Destroy()
    end
    
    
    mouse.KeyDown:connect(function(key)
    if cooldown == false then
    if key:lower() == "f" then
    
    if getgenv().onepunch then
    punch()
    end
    end
    end
    end)
    
    mainsec:NewButton("Reset","Resets your character", function()
        game.Workspace.Remote.loadchar:InvokeServer(game.Players.LocalPlayer.Name)
    end)
    
    mainsec:NewButton("Server Hop","Joins a new server",function()
        local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for i,v in pairs(Servers.data) do
    		if v.playing ~= v.maxPlayers then
    			game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
    		end
    	end
    end)
    
    teleportsec:NewButton("Criminal Base","Teleports to the Criminal Base",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-859.15161132813, 94.476051330566, 2058.5427246094)
    end)
    
    teleportsec:NewButton("Downtown","Teleports you to down town",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-300.44033813477, 54.175037384033, 1781.2364501953)
    end)
    
    teleportsec:NewButton("Entrance Gate","Teleports you to the entrance gate",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(491.27182006836, 98.039939880371, 2216.3107910156)
    end)
    
    teleportsec:NewButton("Entrance","Teleports you to the entrance",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(653.81713867188, 99.990005493164, 2272.083984375)
    end)
    
    teleportsec:NewButton("Yard","Teleports you to the yard",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(781.6845703125, 97.999946594238, 2462.8779296875)
    end)
    
    teleportsec:NewButton("Hallway","Teleports you to the hallway",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(860.78448486328, 99.990005493164, 2362.9597167969)
    end)
    
    teleportsec:NewButton("Cell Block","Teleports you to the cell block",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(918.43115234375, 99.989990234375, 2440.3828125)
    end)
    
    teleportsec:NewButton("Cafeteria","Teleports you to the cafeteria",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(932.06213378906, 99.989959716797, 2290.4250488281)
    end)
    
    teleportsec:NewButton("Armory","Teleports you to the armory",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(835.28918457031, 99.990005493164, 2285.4909667969)
    end)
    
    teleportsec:NewButton("Gaurds Only","Teleports you to the gaurds only room",function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(830.04302978516, 99.990005493164, 2327.0859375)
    end)
    
    mainsec:NewButton("Rejoin","Rejoins the server", function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end)
    
    togglesec:NewToggle("Inf Stamina","Infinite Stamina",function(state)
        getgenv().infstamina = state
        if state == false then
            local plr = game:GetService("Players").LocalPlayer
            for i,v in next, getgc() do 
                if type(v) == "function" and getfenv(v).script and getfenv(v).script == plr.Character.ClientInputHandler then 
                    for i2,v2 in next, debug.getupvalues(v) do 
                        if type(v2) == "number" then 
                            debug.setupvalue(v, i2, 12)
                        end
                    end
                end
            end
        else
            local plr = game:GetService("Players").LocalPlayer
            for i,v in next, getgc() do 
                if type(v) == "function" and getfenv(v).script and getfenv(v).script == plr.Character.ClientInputHandler then 
                    for i2,v2 in next, debug.getupvalues(v) do 
                        if type(v2) == "number" then 
                            debug.setupvalue(v, i2, math.huge)
                        end
                    end
                end
            end
        end
    end)
    
    togglesec:NewToggle("Super Punch","Kills anyone with one punch",function(state)
        getgenv().onepunch = state
    end)
    
    game.Players.PlayerAdded:Connect(function(plr)
        if getgenv().alerts then
            game.StarterGui:SetCore("SendNotification", {
            	Title = "Player Joined",
            	Text = plr.Name.." has joined the game!",
            	Duration = 5
            })
        end
    end)
    
    game.Players.PlayerRemoved:Connect(function(plr)
        if getgenv().alerts then
            game.StarterGui:SetCore("SendNotification", {
            	Title = "Player Left",
            	Text = plr.Name.." has left the game.",
            	Duration = 5
            })
        end
    end)
end

function mall_tycoon()
    local hub = library.CreateLib("NinjaMenu | Mall Tycoon")
    local main = hub:NewTab("Main")
    local mainsec = main:NewSection("Main")
    
    getgenv().autocollect = false
    getgenv().autobuy = false 
    
    mainsec:NewToggle("Auto Collect","Collects money automatically",function(state)
        getgenv().autocollect = state
    end)
    
    mainsec:NewToggle("Auto Buy","Auto buys buttons", function(state)
        getgenv().autobuy = state
    end)
    
    game:GetService("RunService").RenderStepped:Connect(function()
        if getgenv().autocollect then
            game.ReplicatedStorage.RemoteEvent:FireServer("RequestCollectCash")
        end
        if getgenv().autobuy then
            for i,v in pairs(game.Workspace["Tycoon"..game.Players.LocalPlayer.Name]:GetDescendants()) do
                if v:FindFirstChild("Button") and v:FindFirstChild("ButtonData") then
                    if v.ButtonCost < game.Players.LocalPlayer.Stats.Cash then
                        game.ReplicatedStorage.RemoteEvent:FireServer("ButtonTriggeredLocally",v,v.ButtonData)
                    end
                end
            end
        end
    end)
end

if game.PlaceId == 155615604 then
    prison_life()
elseif game.PlaceId == 5736409216 then
    mall_tycoon()
end
