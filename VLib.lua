-- VLib (simplified version)
local VLib = {}

function VLib:Window(name, color, keybind)
    local gui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    gui.Name = name:gsub(" ", "")
    -- Basic frame
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 400, 0, 300)
    frame.Position = UDim2.new(0.5, -200, 0.5, -150)
    frame.BackgroundColor3 = color or Color3.fromRGB(30, 30, 30)
    frame.Name = "MainFrame"
    frame.Active = true
    frame.Draggable = true

    -- Title
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = name
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 20

    -- Keybind toggler
    local open = true
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == keybind then
            open = not open
            frame.Visible = open
        end
    end)

    return {
        Tab = function(_, tabName)
            local tabLabel = Instance.new("TextLabel", frame)
            tabLabel.Text = tabName
            tabLabel.Position = UDim2.new(0, 10, 0, 50 + math.random(0,100)) -- Random position to simulate multiple tabs
            tabLabel.TextColor3 = Color3.new(1,1,1)
            tabLabel.BackgroundTransparency = 1
            tabLabel.Size = UDim2.new(0, 200, 0, 30)
            return {
                Toggle = function(_, txt, default, callback)
                    local btn = Instance.new("TextButton", frame)
                    btn.Text = txt
                    btn.Size = UDim2.new(0, 120, 0, 30)
                    btn.Position = UDim2.new(0, 10, 0, 150 + math.random(0, 100))
                    btn.BackgroundColor3 = default and Color3.fromRGB(0,255,0) or Color3.fromRGB(100,100,100)
                    local state = default
                    btn.MouseButton1Click:Connect(function()
                        state = not state
                        btn.BackgroundColor3 = state and Color3.fromRGB(0,255,0) or Color3.fromRGB(100,100,100)
                        callback(state)
                    end)
                end
            }
        end
    }
end

return VLib
