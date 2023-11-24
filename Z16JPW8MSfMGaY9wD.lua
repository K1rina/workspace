CoreGui = game:GetService("CoreGui")
if not game:IsLoaded() then
	local notLoaded = Instance.new("Message")
	notLoaded.Parent = CoreGui
	notLoaded.Text = 'Please waiting for the game to load.'
	game.Loaded:Wait()
	notLoaded:Destroy()
end
print("Finished")
repeat wait() until game.Players;
repeat wait() until game.Players.LocalPlayer;
repeat wait() until game.ReplicatedStorage;
repeat wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui");
print("Creating Message")
CoreGui = game:GetService("CoreGui")
if game:IsLoaded() then
    local IsLoaded = Instance.new("Message")
    IsLoaded.Parent = CoreGui
	IsLoaded.Text = 'Please wait for a while.'
end
warn("Creating part")
if not game:GetService("Workspace"):FindFirstChild("part") then
    local JustPartByScript = Instance.new("Part")
    JustPartByScript.Name = "JustAPartByScript"
    JustPartByScript.Parent = game.Workspace
    JustPartByScript.Anchored = true
    JustPartByScript.Transparency = 0
end
local neyzila = game.PlaceId
local g = game
local w = g.Workspace
if neyzila == 10819569010 then -- del
    _FallG4VuLWMgzsL = true
        elseif neyzila == 662417684 then
            llbb = true
            elseif neyzila == 5780309044 then
                TCaU = true
                else
                    w.JustAPartByScript.Name = "RJz5MGg6UWxNULB91zvUZWx"
                    warn("Changing name")
                    if game:GetService("Workspace"):FindFirstChild("RJz5MGg6UWxNULB91zvUZWx") then
                        local gaymak = 'https://raw.githubusercontent.com/Aqsyn/workspace/main/'
                        loadstring(game:HttpGet(gaymak .. 'ucxQT38wDMJ.luau'))()
                        wait(.2)
                        game.StarterGui:SetCore("SendNotification", {
                            Icon = "rbxassetid://9419562118";
                            Title = "Notification", 
                            Text = "Games not supported",
                        })
                    end
                end
                local neyzila = game.PlaceId
                local g = game
                local w = g.Workspace
                if neyzila == 5780309044 then
                    warn("Changing name of part")
                    w.JustAPartByScript.Name = "s645bXtTG7VyEqyDZtbX_True"
                end
                if TCaU then
                    if game.workspace:FindFirstChild("s645bXtTG7VyEqyDZtbX_True") then
                        local Loadstrings = 'https://raw.githubusercontent.com/Aqsyn/workspace/main/'
                        if _G.Mobile == true then
                            loadstring(game:HttpGet(Loadstrings .. 'mobileplus.luau'))()
                        end
                        if _G.PC == true then
                            local Loadstrings = 'https://raw.githubusercontent.com/Aqsyn/workspace/main/'
                            loadstring(game:HttpGet(LoaderReal .. '32Dz7vQP.luau'))()
                        end
                    end
                end
                spawn(function()
                    print("Update At 17/11/2023")
                    game.StarterGui:SetCore("SendNotification", {
                        Icon = "rbxassetid://9419562118";
                        Title = "Notification", 
                        Text = "Rework By Neyzila <3",
                    })
                end)
                spawn(function()
                    warn("Deleting ...")
                    CoreGui = game:GetService("CoreGui")
                    if CoreGui:FindFirstChild("Message") then
                        CoreGui.Message:Destroy()
                        game.StarterGui:SetCore("SendNotification", {
                            Icon = "rbxassetid://9419562118";
                            Title = "Notification", 
                            Text = "Done <3",
                        })
                    end
                end)
                pcall(function()
                    if neyzila == 5780309044 then
                        for i,v in pairs(workspace:GetDescendants()) do
                            if v.Name == "s645bXtTG7VyEqyDZtbX_True" then
                                v:Destroy()
                            end
                        end
                    end
                end)