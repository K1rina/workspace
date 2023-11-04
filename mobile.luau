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
        Name = "Bring Arrow",
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