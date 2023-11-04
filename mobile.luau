local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Title of the library", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
OrionLib:MakeNotification({
	Name = "Yuuki",
	Content = "this is a mobile versions",
	Image = "rbxassetid://4483345998",
	Time = 5
})
local Tab = Window:MakeTab({
	Name = "Bringitem",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
Tab:AddToggle({
	Name = "Bring Arrow",
	Default = false,
	Callback = function(v)
        getrf = v
        while getrf do wait()
            pcall(function()
            local plrhead = game.Players.LocalPlayer.Character.Head
                for i,v in pairs(workspace.Arrow:GetDescendants()) do
                        if v.Name == "TouchInterest" and v.Parent then
                            firetouchinterest(plrhead, v.Parent, 0)
                            wait(0.01)
                            firetouchinterest(plrhead, v.Parent, 1)
                        end
                    end
                end)
            end
        end
    })
    Tab:AddToggle({
        Name = "Bring Rokakaka",
        Default = false,
        Callback = function(v)
            Rokakaka = v
            while Rokakaka do wait()
                pcall(function()
                local plrhead = game.Players.LocalPlayer.Character.Head
                    for i,v in pairs(workspace["Rokakaka Fruit"]:GetDescendants()) do
                            if v.Name == "TouchInterest" and v.Parent then
                                firetouchinterest(plrhead, v.Parent, 0)
                                wait(0.01)
                                firetouchinterest(plrhead, v.Parent, 1)
                            end
                        end
                    end)
                end
            end
        })
        Tab:AddToggle({
            Name = "Bring SamuraiDiary",
            Default = false,
            Callback = function(v)
                Samurai = v
                while Samurai do wait()
                    pcall(function()
                        local plrhead = game.Players.LocalPlayer.Character.Head
                        for i,v in pairs(workspace["Samurai Diary"]:GetDescendants()) do
                            if v.Name == "TouchInterest" and v.Parent then
                                firetouchinterest(plrhead, v.Parent, 0)
                                wait(0.01)
                                firetouchinterest(plrhead, v.Parent, 1)
                            end
                        end
                    end)
                end
            end
        })
        Tab:AddToggle({
            Name = "Bring ArrowRequiem",
            Default = false,
            Callback = function(v)
                ArrowRequiem = v
                while ArrowRequiem do wait()
                    pcall(function()
                        local plrhead = game.Players.LocalPlayer.Character.Head
                        for i,v in pairs(workspace["Requiem Arrow"]:GetDescendants()) do
                            if v.Name == "TouchInterest" and v.Parent then
                                firetouchinterest(plrhead, v.Parent, 0)
                                wait(0.01)
                                firetouchinterest(plrhead, v.Parent, 1)
                            end
                        end
                    end)
                end
            end
        })
        Tab:AddToggle({
            Name = "Bring HellArrow",
            Default = false,
            Callback = function(v)
                Hell = v
                while Hell do wait()
                    local plrhead = game.Players.LocalPlayer.Character.Head
                    pcall(function()
                        for i,v in pairs(workspace["Hell Arrow"]:GetDescendants()) do
                            if v.Name == "TouchInterest" and v.Parent then
                                firetouchinterest(plrhead, v.Parent, 0)
                                wait(0.01)
                                firetouchinterest(plrhead, v.Parent, 1)
                            end
                        end
                    end)
                end
            end
        })
        Tab:AddToggle({
            Name = "Bring TrueArrowReq",
            Default = false,
            Callback = function(v)
                TrueAReq = v
                while TrueAReq do wait()
                    pcall(function()
                        local plrhead = game.Players.LocalPlayer.Character.Head
                        for i,v in pairs(workspace["True Requiem Arrow"]:GetDescendants()) do
                            if v.Name == "TouchInterest" and v.Parent then
                                firetouchinterest(plrhead, v.Parent, 0)
                                wait(0.01)
                                firetouchinterest(plrhead, v.Parent, 1)
                            end
                        end
                    end)
                end
            end
        })
        Tab:AddToggle({
            Name = "Bring DioDiary",
            Default = false,
            Callback = function(v)
                Dio = v
                while Dio do wait()
                    pcall(function()
                        local plrhead = game.Players.LocalPlayer.Character.Head
                        for i,v in pairs(workspace["DIO's Diary"]:GetDescendants()) do
                            if v.Name == "TouchInterest" and v.Parent then
                                firetouchinterest(plrhead, v.Parent, 0)
                                wait(0.01)
                                firetouchinterest(plrhead, v.Parent, 1)
                            end
                        end
                    end)
                end
            end
        })
        Tab:AddToggle({
            Name = "Bring Bone",
            Default = false,
            Callback = function(v)
                Bone = v
                while Bone do wait()
                    pcall(function()
                        local plrhead = game.Players.LocalPlayer.Character.Head
                        for i,v in pairs(workspace["Bone"]:GetDescendants()) do
                            if v.Name == "TouchInterest" and v.Parent then
                                firetouchinterest(plrhead, v.Parent, 0)
                                wait(0.01)
                                firetouchinterest(plrhead, v.Parent, 1)
                            end
                        end
                    end)
                end
            end
        })
        Tab:AddToggle({
            Name = "Bring VolcanicRock",
            Default = false,
            Callback = function(v)
                VolcanicRock = v
                while VolcanicRock do wait()
                    local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                    pcall(function()
                            for i,v in pairs(workspace:GetChildren()) do
                                if v.Name == "Volcanic Rock" then
                                    v.Handle.CanCollide = false
                                    v.Handle.Size = Vector3.new(100000,100000,100000)
                                    plr.CFrame = v.Handle.CFrame
                                end
                            end
                        end)
                    end
                end
            })
            Tab:AddToggle({
                Name = "Bring EnderPearl",
                Default = false,
                Callback = function(v)
                    Ender = v
                    while Ender do wait()
                        local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                        pcall(function()
                            for i,v in pairs(workspace:GetChildren()) do
                                if v.Name == "Ender Pearl" then
                                    v.Handle.CanCollide = false
                                    v.Handle.CFrame = plr.CFrame
                                end
                            end
                        end)
                    end
                end
            })
            Tab:AddToggle({
                Name = "Bring ToxicChemicals",
                Default = false,
                Callback = function(v)
                    Toxic = v
                    while Toxic do wait()
                        pcall(function()
                            local plrhead = game.Players.LocalPlayer.Character.Head
                            for i,v in pairs(workspace["Toxic Chemicals"]:GetDescendants()) do
                                if v.Name == "TouchInterest" and v.Parent then
                                    firetouchinterest(plrhead, v.Parent, 0)
                                    wait(0.01)
                                    firetouchinterest(plrhead, v.Parent, 1)
                                end
                            end
                        end)
                    end
                end
            })
        Tab:AddToggle({
            Name = "Bring Frog",
            Default = false,
            Callback = function(v)
                Frog = v
                while Frog do wait()
                    pcall(function()
                        local plrhead = game.Players.LocalPlayer.Character.Head
                        for i,v in pairs(workspace["Frog"]:GetDescendants()) do
                            if v.Name == "TouchInterest" and v.Parent then
                                    firetouchinterest(plrhead, v.Parent, 0)
                                    wait(0.01)
                                    firetouchinterest(plrhead, v.Parent, 1)
                                end
                            end
                        end)
                    end
                end
            })
        Tab:AddToggle({
            Name = "Bring OrnsteinSpear",
            Default = false,
            Callback = function(v)
                Ornstein = v
                while Ornstein do wait()
                    pcall(function()
                        local plrhead = game.Players.LocalPlayer.Character.Head
                        for i,v in pairs(workspace["Ornstein's Spear"]:GetDescendants()) do
                            if v.Name == "TouchInterest" and v.Parent then
                                    firetouchinterest(plrhead, v.Parent, 0)
                                    wait(0.01)
                                    firetouchinterest(plrhead, v.Parent, 1)
                                end
                            end
                        end)
                    end
                end
            })
        Tab:AddToggle({
            Name = "Bring AjaMask",
            Default = false,
            Callback = function(v)
                AjaMask = v
                while AjaMask do wait()
                    pcall(function()
                        local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                            for i,v in pairs(workspace:GetChildren()) do
                                if v.Name == "Aja Mask" then
                                    v.Handle.CanCollide = false
                                    v.Handle.CFrame = plr.CFrame
                                end
                            end
                        end)
                    end
                end
            })
            Tab:AddToggle({
                Name = "Bring UncannyKey",
                Default = false,
                Callback = function(v)
                    UncannyKey = v
                    while UncannyKey do wait()
                        local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                        pcall(function()
                            for i,v in pairs(workspace:GetChildren()) do
                                if v.Name == "Uncanny Key" then
                                    v.Handle.CanCollide = false
                                    v.Handle.CFrame = plr.CFrame
                                end
                            end
                        end)
                    end
                end
            })
            Tab:AddToggle({
                Name = "Bring IceShard",
                Default = false,
                Callback = function(v)
                    IceShard = v
                    while IceShard do wait()
                        pcall(function()
                            local plrhead = game.Players.LocalPlayer.Character.Head
                            for i,v in pairs(workspace["Ice Shard"]:GetDescendants()) do
                                if v.Name == "TouchInterest" and v.Parent then
                                    firetouchinterest(plrhead, v.Parent, 0)
                                    wait(0.01)
                                    firetouchinterest(plrhead, v.Parent, 1)
                                end
                            end
                        end)
                    end
                end
            })
        Tab:AddToggle({
            Name = "Bring Scythe",
            Default = false,
            Callback = function(v)
                Scythe = v
                while Scythe do wait()
                    pcall(function()
                            local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                            for i,v in pairs(workspace:GetChildren()) do
                                if v.Name == "Scythe" then
                                    v.Handle.CanCollide = false
                                    v.Handle.CFrame = plr.CFrame
                                end
                            end
                        end)
                    end
                end
            })
            local Tab = Window:MakeTab({
                Name = "Tab 2",
                Icon = "rbxassetid://4483345998",
                PremiumOnly = false
            })
            local Section = Tab:AddSection({
                Name = "Mics"
            })
            Tab:AddToggle({
                Name = "AutoBringBanknote",
                Default = false,
                Callback = function(v)
                    Banknote = v
                    while Banknote do wait()
                        pcall(function()
                            local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                            for i,v in pairs(workspace:GetChildren()) do
                                if v.Name == "Banknote" then
                                    v.Handle.CanCollide = false
                                    v.Handle.CFrame = plr.CFrame
                                    print(String())
                                end
                            end
                        end)
                    end
                end    
            })
            Tab:AddToggle({
                Name = "AutoUseBanknote",
                Default = false,
                Callback = function(v)
                    acb = v
                    local plr2 = game.Players.LocalPlayer
                    while acb do wait()
                        pcall(function()
                            for i,v in pairs(plr2:FindFirstChildOfClass("Backpack"):GetChildren()) do
                                if v.Name == "Banknote" then
                                    v.Parent = plr2.Character
                                    game:GetService'VirtualUser':CaptureController()
                                    game:GetService'VirtualUser':Button1Down(Vector2.new(nil, nil))
                                else
                                    wait(0.01)
                                    plr2.Character:FindFirstChildOfClass('Humanoid'):UnequipTools()
                                end
                            end
                        end)
                    end
                end    
            })
            Tab:AddToggle({
                Name = "AutoUseBanknote",
                Default = false,
                Callback = function(v)
                    Noclip = v
                    while Noclip do wait()
                        pcall(function()
                            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                                if v:IsA("BasePart") then
                                    v.CanCollide = false
                                    if not Noclip then
                                        spawn(function()
                                            game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(8)
                                            print("ChangeState")
                                            game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(12)
                                            print("ChangeState2")
                                        end)
                                    end
                                end
                            end
                        end)
                    end
                end    
            })
            Tab:AddToggle({
                Name = "Antitimestop",
                Default = false,
                Callback = function(v)
                    bypasstimestop = v
                    while bypasstimestop do wait()
                        pcall(function()
                            local args = {
                                [1] = game:GetService("Players").LocalPlayer.Character.Head,
                                [2] = false
                            }
                            game:GetService("ReplicatedStorage"):WaitForChild("Anchor"):FireServer(unpack(args))
                            local args = {
                                [1] = game:GetService("Players").LocalPlayer.Character.Torso,
                                [2] = false
                            }
                            game:GetService("ReplicatedStorage"):WaitForChild("Anchor"):FireServer(unpack(args))
                            local args = {
                                [1] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Right Arm"),
                                [2] = false
                            }
                            game:GetService("ReplicatedStorage"):WaitForChild("Anchor"):FireServer(unpack(args))
                            local args = {
                                [1] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Left Arm"),
                                [2] = false
                            }
                            game:GetService("ReplicatedStorage"):WaitForChild("Anchor"):FireServer(unpack(args))
                            local args = {
                                [1] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Right Leg"),
                                [2] = false
                            }
                            game:GetService("ReplicatedStorage"):WaitForChild("Anchor"):FireServer(unpack(args))    
                            local args = {
                                [1] = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Left Leg"),
                                [2] = false
                            }
                            game:GetService("ReplicatedStorage"):WaitForChild("Anchor"):FireServer(unpack(args))                                                                                                
                        end)
                    end
                end    
            })
            Tab:AddToggle({
                Name = "DeleleEffect",
                Default = false,
                Callback = function(Value)
                    DeleleEffect = v
                    while DeleleEffect do wait()
                        pcall(function()
                            for i,v in pairs(workspace.Effects:GetChildren()) do
                                if v.Name == "StandlessLungeR" or "DKCDash" or "Part" then
                                v:Destroy()
                                warn("done",String())
                            end
                        end
                    end)
                end  
            })
            local Tab = Window:MakeTab({
                Name = "Tab 3",
                Icon = "rbxassetid://4483345998",
                PremiumOnly = false
            })
            local Section = Tab:AddSection({
                Name = "Mix"
            })
            Tab:AddButton({
                Name = "kidnapping Rachael",
                Callback = function()
                    for i,v in pairs(workspace:GetChildren()) do
                        if v.Name == "rachael but she saw scary thing and now crying" then
                            fireclickdetector(workspace["rachael but she saw scary thing and now crying"].ClickDetector)
                        end
                    end
                end
                })
                Tab:AddButton({
                    Name = "RemoveItems",
                    Callback = function()
                        local plr2 = game.Players.LocalPlayer
                        for i,v in pairs(plr2:FindFirstChildOfClass("Backpack"):GetDescendants()) do
                            if v:IsA('Tool') or v:IsA('HopperBin') then
                                v:Destroy()
                            end
                        end
                        for i,v in pairs(plr2.Character:GetDescendants()) do
                            if v:IsA('Tool') or v:IsA('HopperBin') then
                                v:Destroy()
                            end
                        end
                    end
                    })
                    Tab:AddButton({
                        Name = "RejoinServer",
                        Callback = function()
                            local ts = game:GetService("TeleportService")
                            local p = game:GetService("Players").LocalPlayer
                            ts:TeleportToPlaceInstance(game.PlaceId, game.JobId, p)
                        end
                        })
                        Tab:AddButton({
                            Name = "Hopserver",
                            Callback = function()
                                loadstring(game:HttpGet('https://raw.githubusercontent.com/Aqsyn/workspace/main/hop.lua'))()
                            end
                        })
                        Tab:AddButton({
                            Name = "BoostFps",
                            Callback = function()
                                local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
                                local g = game
                                local w = g.Workspace
                                local l = g.Lighting
                                local t = w.Terrain
                                t.WaterWaveSize = 0
                                t.WaterWaveSpeed = 0
                                t.WaterReflectance = 0
                                t.WaterTransparency = 0
                                l.GlobalShadows = false
                                l.FogEnd = 9e9
                                l.Brightness = 0
                                settings().Rendering.QualityLevel = "Level01"
                                for i, v in pairs(g:GetDescendants()) do
                                    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
                                        v.Material = "Plastic"
                                        v.Reflectance = 0
                                    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                                        v.Transparency = 1
                                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                                        v.Lifetime = NumberRange.new(0)
                                    elseif v:IsA("Explosion") then
                                        v.BlastPressure = 1
                                        v.BlastRadius = 1
                                    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                                        v.Enabled = false
                                    elseif v:IsA("MeshPart") then
                                        v.Material = "Plastic"
                                        v.Reflectance = 0
                                        v.TextureID = 10385902758728957
                                    end
                                end
                                for i, e in pairs(l:GetChildren()) do
                                    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                                        e.Enabled = false
                                        for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                                            if v.ClassName == "Accessory" then
                                                v:Destroy()
                                            end
                                        end
                                        for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                                            if v.ClassName == "BodyColors" then
                                                v:Destroy()
                                            end
                                        end
                                        for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                                            if v.ClassName == "Pants" then
                                                v:Destroy()
                                            end
                                        end
                                        for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                                            if v.ClassName == "Shirt" then
                                                v:Destroy()
                                            end
                                        end
                                        for i,v in pairs(game:GetService("Players").LocalPlayer.Character.Head:GetChildren()) do
                                            if v.ClassName == "Decal" then
                                                v:Destroy()
                                            end
                                        end
                                    end
                                end
                            })
                            Tab:AddButton({
                                Name = "UnlockFPS",
                                Callback = function()
                                    setfpscap(9999)
                                  end    
                            })
                            Tab:AddButton({
                                Name = "lockFPS (60)",
                                Callback = function()
                                    setfpscap(60)
                                  end    
                            })
                            local Tab = Window:MakeTab({
                                Name = "Tab 4",
                                Icon = "rbxassetid://4483345998",
                                PremiumOnly = false
                            })
                            local Section = Tab:AddSection({
                                Name = "shop"
                            })
                            Tab:AddButton({
                                Name = "Timmy",
                                Callback = function()
                                    for i,v in pairs(workspace.Map:GetChildren()) do
                                        if v.Name == "Timmy" then
                                            fireclickdetector(workspace.Map.Timmy.ClickDetector)
                                        end
                                    end
                                  end    
                            })
                            Tab:AddButton({
                                Name = "Tim",
                                Callback = function()
                                    for i,v in pairs(workspace.Map:GetChildren()) do
                                        if v.Name == "Tim" then
                                            fireclickdetector(workspace.Map.Tim.ClickDetector)
                                        end
                                    end
                                  end    
                            })
                            Tab:AddButton({
                                Name = "Tom",
                                Callback = function()
                                    for i,v in pairs(workspace.Map:GetChildren()) do
                                        if v.Name == "Tom" then
                                            fireclickdetector(workspace.Map.Tom.ClickDetector)
                                        end
                                    end
                                  end    
                            })
                            Tab:AddButton({
                                Name = "Rachael(Quests)",
                                Callback = function()
                                    for i,v in pairs(workspace.Map:GetChildren()) do
                                        if v.Name == "sallynpc" then
                                            fireclickdetector(workspace.Map.sallynpc.ClickDetector)
                                        end
                                    end  
                                end    
                            })
                            Tab:AddLabel("Teleport")
                            Tab:AddButton({
                                Name = "Bank",
                                Callback = function()
                                    local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                                    plr.CFrame = CFrame.new(1342.39087, 587.622925, -553.514526, 0.982207894, -1.64642309e-08, -0.18779695, 1.24587975e-08, 1, -2.25088996e-08, 0.18779695, 1.97686933e-08, 0.982207894)
                                  end    
                            })
                            Tab:AddButton({
                                Name = "Store stand",
                                Callback = function()
                                    local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                                    plr.CFrame = CFrame.new(1397.67358, 584.343018, -223.748627, -0.980082631, -1.5230162e-08, -0.198590249, -1.40531959e-08, 1, -7.3360571e-09, 0.198590249, -4.39911441e-09, -0.980082631)
                                
                                  end    
                            })
                            Tab:AddButton({
                                Name = "Farm Zone",
                                Callback = function()
                                    local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                                    plr.CFrame = CFrame.new(-281.446106, 461.79718, -1482.33521, 0.516405284, -3.00828829e-09, 0.856344342, -5.36135891e-09, 1, 6.74602729e-09, -0.856344342, -8.07485367e-09, 0.516405284)
                                
                                  end    
                            })
                            Tab:AddButton({
                                Name = "SaveZone",
                                Callback = function()
                                    local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                                    plr.CFrame = CFrame.new(-95.3099976, -15.2199993, -578.080017, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                               
                                  end    
                            })
                            Tab:AddButton({
                                Name = "Spawn",
                                Callback = function()
                                    local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
                                    plr.CFrame = CFrame.new(1480.93848, 623.50769, -447.116455, -0.537299991, -3.20327338e-08, 0.84339118, 6.29271568e-08, 1, 7.8069931e-08, -0.84339118, 9.50191819e-08, -0.537299991)
                                
                                  end    
                            })
                            print("spawnfunction03")
                            spawn(function()
                                warn("Start AntiAFK")
                                local vu = game:GetService("VirtualUser")
                                game:GetService("Players").LocalPlayer.Idled:connect(function()
                                    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                                    wait(1)
                                    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                                end)
                            end)
                            print("spawnfunction04")
                            spawn(function()
                                warn("done")
                                local plr2 = game.Players.LocalPlayer
                                local sc = (debug and debug.setconstant) or setconstant
                                local gc = (debug and debug.getconstants) or getconstants
                                local pop = plr2.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
                                for _, v in pairs(getgc()) do
                                    if type(v) == 'function' and getfenv(v).script == pop then
                                        for i, v1 in pairs(gc(v)) do
                                            if tonumber(v1) == .25 then
                                                sc(v, i, 0)
                                            elseif tonumber(v1) == 0 then
                                                sc(v, i, .25)
                                            end
                                        end
                                    end
                                end
                            end)
                            print("spawnfunction05")
                            spawn(function()
                                pcall(function()
                                    game:GetService("Workspace").Map.Arena.FinalHelicopter:GetChildren()[2].TouchInterest:Destroy()
                                    game:GetService("Workspace").Map.Arena.FinalHelicopter.Fire.TouchInterest:Destroy()
                                    game:GetService("Workspace").Map.Arena.mini:GetChildren()[2].TouchInterest:Destroy()
                                    game:GetService("Workspace").Map.Arena.mini.Fire.TouchInterest:Destroy()
                                    game:GetService("Workspace").Map.Arena.Model.Fire.TouchInterest:Destroy()
                                    game:GetService("Workspace").Map.Arena:GetChildren()[5].Fire.TouchInterest:Destroy()
                                    game:GetService("Workspace").Map.Arena:GetChildren()[6].Fire.TouchInterest:Destroy()
                                    game:GetService("Workspace").Map.Arena:GetChildren()[4].Fire.TouchInterest:Destroy()
                                    print("DeleleFiredamage")
                                end)
                            end)
                            --[[spawn(function()
                                g = hookfunction(wait, function(seconds)
                                    return g(0.01)
                                end)
                            end) ]]--
                            -- function
                            function String()
                                local length = math.random(5,12)
                                local array = {}
                                for i = 1, length do
                                    array[i] = string.char(math.random(32, 126))
                                end
                                return table.concat(array)
                            end
                            OrionLib:Init()