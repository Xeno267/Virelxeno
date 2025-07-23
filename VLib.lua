local VLib = {}

function VLib:Window(text)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 450, 0, 310)
    Main.Position = UDim2.new(0.5, -225, 0.5, -155)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.BorderSizePixel = 0
    Main.Name = "VirelXenoHub"

    local UICorner = Instance.new("UICorner", Main)
    UICorner.CornerRadius = UDim.new(0, 12)

    local Title = Instance.new("TextLabel", Main)
    Title.Size = UDim2.new(1, 0, 0, 35)
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(0, 255, 127)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 22

    local Tabs = {}
    function Tabs:Tab(tabText)
        local TabButton = Instance.new("TextButton", Main)
        TabButton.Size = UDim2.new(0, 100, 0, 25)
        TabButton.Position = UDim2.new(0, #Main:GetChildren() * 105 - 500, 0, 40)
        TabButton.Text = tabText
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextSize = 14
        TabButton.BorderSizePixel = 0

        local UICorner = Instance.new("UICorner", TabButton)
        UICorner.CornerRadius = UDim.new(0, 6)

        local TabFrame = Instance.new("Frame", Main)
        TabFrame.Size = UDim2.new(1, -20, 1, -80)
        TabFrame.Position = UDim2.new(0, 10, 0, 70)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Visible = false

        local function ClearTabs()
            for _, v in pairs(Main:GetChildren()) do
                if v:IsA("Frame") and v ~= Main and v ~= Title then
                    v.Visible = false
                end
            end
        end

        TabButton.MouseButton1Click:Connect(function()
            ClearTabs()
            TabFrame.Visible = true
        end)

        local Elements = {}

        function Elements:Button(text, callback)
            local Btn = Instance.new("TextButton", TabFrame)
            Btn.Size = UDim2.new(0, 200, 0, 30)
            Btn.Position = UDim2.new(0, 10, 0, #TabFrame:GetChildren() * 35)
            Btn.Text = text
            Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.Font = Enum.Font.Gotham
            Btn.TextSize = 14
            Btn.BorderSizePixel = 0

            local UICorner = Instance.new("UICorner", Btn)
            UICorner.CornerRadius = UDim.new(0, 6)

            Btn.MouseButton1Click:Connect(callback)
        end

        function Elements:Toggle(text, default, callback)
            local ToggleBtn = Instance.new("TextButton", TabFrame)
            ToggleBtn.Size = UDim2.new(0, 200, 0, 30)
            ToggleBtn.Position = UDim2.new(0, 10, 0, #TabFrame:GetChildren() * 35)
            ToggleBtn.Text = text
            ToggleBtn.BackgroundColor3 = default and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
            ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleBtn.Font = Enum.Font.Gotham
            ToggleBtn.TextSize = 14
            ToggleBtn.BorderSizePixel = 0

            local UICorner = Instance.new("UICorner", ToggleBtn)
            UICorner.CornerRadius = UDim.new(0, 6)

            local toggled = default

            ToggleBtn.MouseButton1Click:Connect(function()
                toggled = not toggled
                ToggleBtn.BackgroundColor3 = toggled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(80, 80, 80)
                callback(toggled)
            end)
        end

        TabFrame.Visible = #Main:GetChildren() <= 6 -- Show first tab by default
        return Elements
    end

    return Tabs
end

return VLib
