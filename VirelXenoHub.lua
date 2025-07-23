loadstring(game:HttpGet("https://raw.githubusercontent.com/Xeno267/Xeno/main/VLib.lua"))()

local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Xeno267/Xeno/main/VLib.lua"))()
local VHub = VLib:Window("Virel Xeno Hub", "Steal a Brainrot GUI", Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)

-- Tabs
local MainTab = VHub:Tab("Main")
local VisualTab = VHub:Tab("Visual")
local MiscTab = VHub:Tab("Misc")

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local humanoid = nil
local flyOn = false
local bodyGyro, bodyVelocity

-- SETTINGS
local SPEED = 45
local DEFAULT_JUMP = 50
local BOOSTED_JUMP = 110

-- FUNCTIONS
local function getHumanoid()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:FindFirstChildOfClass("Humanoid")
end

-- Speed
MainTab:Toggle("Speed", false, function(state)
    humanoid = getHumanoid()
    if state then
        humanoid.WalkSpeed = SPEED
    else
        humanoid.WalkSpeed = 16
    end
end)

-- Jump
MainTab:Toggle("Jump", false, function(state)
    humanoid = getHumanoid()
    if state then
        humanoid.JumpPower = BOOSTED_JUMP
    else
        humanoid.JumpPower = DEFAULT_JUMP
    end
end)

-- ESP (Players)
VisualTab:Toggle("Player ESP", false, function(state)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer and player.Character then
            local highlight = player.Character:FindFirstChild("Highlight")
            if state then
                if not highlight then
                    local hl = Instance.new("Highlight")
                    hl.Name = "Highlight"
                    hl.FillColor = Color3.fromRGB(0, 255, 0)
                    hl.OutlineColor = Color3.new(1, 1, 1)
                    hl.Parent = player.Character
                end
            else
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end)

-- Brainrot ESP
VisualTab:Toggle("Brainrot ESP", false, function(state)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("brainrot") then
            if state then
                if not obj:FindFirstChild("Highlight") then
                    local hl = Instance.new("Highlight")
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                    hl.OutlineColor = Color3.new(1, 1, 1)
                    hl.Parent = obj
                end
            else
                local hl = obj:FindFirstChild("Highlight")
                if hl then hl:Destroy() end
            end
        end
    end
end)

-- Brainrot Secret 2 ESP
VisualTab:Toggle("Brainrot Secret 2 ESP", false, function(state)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("secret2") then
            if state then
                if not obj:FindFirstChild("Highlight") then
                    local hl = Instance.new("Highlight")
                    hl.FillColor = Color3.fromRGB(255, 255, 0)
                    hl.OutlineColor = Color3.new(1, 1, 1)
                    hl.Parent = obj
                end
            else
                local hl = obj:FindFirstChild("Highlight")
                if hl then hl:Destroy() end
            end
        end
    end
end)

-- Fly
MiscTab:Toggle("Fly", false, function(state)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    flyOn = state
    if state then
        bodyGyro = Instance.new("BodyGyro")
        bodyVelocity = Instance.new("BodyVelocity")

        bodyGyro.P = 9e4
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.CFrame = hrp.CFrame
        bodyGyro.Parent = hrp

        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Parent = hrp

        RunService.RenderStepped:Connect(function()
            if flyOn then
                bodyGyro.CFrame = workspace.CurrentCamera.CFrame
                local moveVec = Vector3.zero
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveVec += workspace.CurrentCamera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveVec -= workspace.CurrentCamera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveVec -= workspace.CurrentCamera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveVec += workspace.CurrentCamera.CFrame.RightVector
                end
                bodyVelocity.Velocity = moveVec * SPEED
            end
        end)
    else
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
    end
end)

-- TP UP Button
MiscTab:Button("TP UP", function()
    local char = player.Character or player.CharacterAdded:Wait()
    char:MoveTo(char:GetPivot().Position + Vector3.new(0, 100, 0))
end)
