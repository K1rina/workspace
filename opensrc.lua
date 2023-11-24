repeat wait() until game.Players.LocalPlayer;
local ArrayField = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/ArrayField/main/Source.lua'))()
getgenv().SecureMode = true
local Window = ArrayField:CreateWindow({
   Name = "ArrayField Example Window",
   LoadingTitle = "ArrayField Interface Suite",
   LoadingSubtitle = "by Arrays",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "ArrayField"
   },
   Discord = {
      Enabled = true,
      Invite = "HBGFMVMqUp",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = false,
      GrabKeyFromSite = false,
      Actions = {
            [1] = {
                Text = 'Click here to copy the key link <--',
                OnPress = function()
                    print('Pressed')
                end,
                }
            },
      Key = {"Hello"} 
   }
})
local Tab = Window:CreateTab("Main tab", 4483362458)
local Toggle = Tab:CreateToggle({
    Name = "Tweentotop",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(v)
        Call01 = v
        Call01 while wait() do
            TP(CFrame.new(-26.2376919, 4006.09082, -23.0878887, -0.229178801, 8.07469789e-08, 0.973384321, -2.08935127e-08, 1, -8.7874156e-08, -0.973384321, -4.04763121e-08, -0.229178801))
        end
    end,
 })






function TP(P) -- for bloxfite
    Distance = (P.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 200 then
        Speed = 1500
            elseif Distance < 1000 then
                Speed = 360
                elseif Distance < 10000 then
                    Speed = 360
                    elseif Distance < 30000 then
                        Speed = 360
                        elseif Distance < 100000 then
                            Speed = 360
                        end
                        game:GetService("TweenService"):Create(
                            game.Players.LocalPlayer.Character.HumanoidRootPart,
                            TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
                            {CFrame = P}
                    ):Play()
                    end