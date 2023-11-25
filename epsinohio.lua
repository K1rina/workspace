if not game:GetService("Workspace"):FindFirstChild("part") then
    local kuy = Instance.new("Part")
    kuy.Name = "ForESP"
    kuy.Parent = game.workspace.Fruity
    kuy.Anchored = true
    kuy.Transparency = 0
end

_G.EspFruity = true
for i,v in pairs(workspace.Fruity:GetChildren()) do
    if EspFruity then
        while _G.EspFruity do wait()
            pcall(function()
                if string.find (v.Name,"ForESP") then
                    if not v:FindFirstChild "gui" then
                        local gui = Instance.new("BillboardGui",v)
                        gui.Name = "gui"
                        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                        gui.Active = true
                        gui.AlwaysOnTop = true
                        gui.LightInfluence = 1.000
                        gui.Size = UDim2.new(0, 90, 0, 50)
                        local esp = Instance.new("TextLabel",gui)
                        esp.Name = "esp"
                        esp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        esp.BackgroundTransparency = 1.000
                        esp.BorderColor3 = Color3.fromRGB(0, 0, 0)
                        esp.Position = UDim2.new(0.0820999965, 0, 0.200000003, 0)
                        esp.Size = UDim2.new(0, 50, 0, 50)
                        esp.Font = Enum.Font.SpecialElite
                        esp.Text = v.Name
                        esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        esp.TextScaled = true
                        esp.TextSize = 5.000
                        esp.TextStrokeTransparency = 0.000
                        esp.TextWrapped = true
                        if v.Name == "Operate Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Barrier Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Stringy Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Rubber Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Magma Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Lightning Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Bomb Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Phoenix Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Military Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Monk Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Light Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Sand Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Glue Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Dark Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Smoky Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Ice Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Invisible Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Quake Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Fire Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                        if v.Name == "Invisible Fruity" then
                            esp.TextColor3 = Color3.fromRGB(250, 159, 245)
                        end
                    end
                else
                    if v:FindFirstChild "gui" then
                        V:FindFirstChild "gui":Destroy()
                    end
                end
            end)
        end
    end
end