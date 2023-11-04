local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "stands awakening", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
OrionLib:MakeNotification({
	Name = "",
	Content = "this is a both versions",
	Image = "rbxassetid://4483345998",
	Time = 10
})
local Tab = Window:MakeTab({
	Name = "Choice",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
Tab:AddButton({
    Name = "mobile",
    Callback = function()
        local LoaderReal = 'https://raw.githubusercontent.com/Aqsyn/workspace/main/'
        loadstring(game:HttpGet(LoaderReal .. 'mobileplus.luau'))()
    end
    })
    Tab:AddButton({
        Name = "PC(nope)",
        Callback = function()

        end
    })
