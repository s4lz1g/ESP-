-- Modern Skeleton ESP with Draggable Menu (no Hitboxes)
-- Use exclusively in your own projects for educational purposes.

-------------------------------
-- SETTINGS & GLOBAL VARIABLES
-------------------------------
local Settings = {
    BoneESPColor = Color3.fromRGB(0, 255, 0),   -- Standard: Grün
    ESPEnabled = true                          -- ESP standardmäßig aktiviert
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Skeletons = {}  -- Hier speichern wir die Skeleton-Drawing-Objekte pro Spieler

-------------------------------
-- MODERN MENU GUI CODE
-------------------------------
local CoreGui = game:GetService("CoreGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernESP_Menu"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main draggable frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 220)  -- Ursprüngliche Größe beibehalten
MainFrame.Position = UDim2.new(0, 100, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true  -- Wichtig für Dragging
MainFrame.Parent = ScreenGui

-- Abgerundete Ecken für den MainFrame
local MainFrameCorner = Instance.new("UICorner")
MainFrameCorner.CornerRadius = UDim.new(0, 10)
MainFrameCorner.Parent = MainFrame

-- UIGradient für einen leichten Hintergrundverlauf
local MainFrameGradient = Instance.new("UIGradient")
MainFrameGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
})
MainFrameGradient.Parent = MainFrame

-- Titelleiste
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleBarCorner = Instance.new("UICorner")
TitleBarCorner.CornerRadius = UDim.new(0, 10)
TitleBarCorner.Parent = TitleBar

-- Haupttitel: "s4lz1g v1"
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -90, 0.6, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "s4lz1g v1"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamSemibold
TitleLabel.TextSize = 22
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- Beschreibung im Titel: "dc: s4lz1g"
local DescLabel = Instance.new("TextLabel")
DescLabel.Name = "DescLabel"
DescLabel.Size = UDim2.new(1, -90, 0.4, 0)
DescLabel.Position = UDim2.new(0, 10, 0.6, -4)
DescLabel.BackgroundTransparency = 1
DescLabel.Text = "dc: s4lz1g"
DescLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DescLabel.Font = Enum.Font.Gotham
DescLabel.TextSize = 14
DescLabel.TextXAlignment = Enum.TextXAlignment.Left
DescLabel.Parent = TitleBar

-- Buttons in der Titelleiste
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TitleBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -80, 0, 10)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TitleBar

-- Content Frame für die Menüinhalte
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -50)
ContentFrame.Position = UDim2.new(0, 0, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Bone ESP Color Section
local BoneESPLabel = Instance.new("TextLabel")
BoneESPLabel.Name = "BoneESPLabel"
BoneESPLabel.Size = UDim2.new(1, -20, 0, 25)
BoneESPLabel.Position = UDim2.new(0, 10, 0, 10)
BoneESPLabel.BackgroundTransparency = 1
BoneESPLabel.Text = "Bone ESP Color:"
BoneESPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BoneESPLabel.Font = Enum.Font.Gotham
BoneESPLabel.TextSize = 18
BoneESPLabel.Parent = ContentFrame

local BoneColorButton = Instance.new("TextButton")
BoneColorButton.Name = "BoneColorButton"
BoneColorButton.Size = UDim2.new(0, 100, 0, 30)
BoneColorButton.Position = UDim2.new(0, 10, 0, 40)
BoneColorButton.BackgroundColor3 = Settings.BoneESPColor
BoneColorButton.Text = ""
BoneColorButton.AutoButtonColor = false
BoneColorButton.Parent = ContentFrame

local BoneColorSwatch = Instance.new("Frame")
BoneColorSwatch.Name = "BoneColorSwatch"
BoneColorSwatch.Size = UDim2.new(0, 140, 0, 70)
BoneColorSwatch.Position = UDim2.new(0, 120, 0, 40)
BoneColorSwatch.BackgroundTransparency = 1
BoneColorSwatch.Visible = false
BoneColorSwatch.Parent = ContentFrame

-- Preset Farben (modern & ansprechend)
local presetColors = {
    {Name = "Red", Color = Color3.fromRGB(255, 0, 0)},
    {Name = "Green", Color = Color3.fromRGB(0, 255, 0)},
    {Name = "Blue", Color = Color3.fromRGB(0, 0, 255)},
    {Name = "Yellow", Color = Color3.fromRGB(255, 255, 0)},
    {Name = "Purple", Color = Color3.fromRGB(128, 0, 128)},
    {Name = "Cyan", Color = Color3.fromRGB(0, 255, 255)},
    {Name = "White", Color = Color3.fromRGB(255, 255, 255)},
    {Name = "Orange", Color = Color3.fromRGB(255, 165, 0)},
}

for i, colorData in ipairs(presetColors) do
    local btn = Instance.new("TextButton")
    btn.Name = colorData.Name
    btn.Size = UDim2.new(0, 30, 0, 30)
    btn.Position = UDim2.new(0, ((i-1)%4)*35, 0, math.floor((i-1)/4)*35)
    btn.BackgroundColor3 = colorData.Color
    btn.Text = ""
    btn.AutoButtonColor = false

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5)
    btnCorner.Parent = btn

    btn.Parent = BoneColorSwatch

    btn.MouseButton1Click:Connect(function()
        Settings.BoneESPColor = colorData.Color
        BoneColorButton.BackgroundColor3 = colorData.Color
    end)
end

-- Toggle Farbauswahl-Panel
BoneColorButton.MouseButton1Click:Connect(function()
    BoneColorSwatch.Visible = not BoneColorSwatch.Visible
end)

-- Toggle ESP Section (Zusätzliche Option zum Ein-/Ausschalten des ESP)
local ESPToggleLabel = Instance.new("TextLabel")
ESPToggleLabel.Name = "ESPToggleLabel"
ESPToggleLabel.Size = UDim2.new(1, -20, 0, 25)
ESPToggleLabel.Position = UDim2.new(0, 10, 0, 110)
ESPToggleLabel.BackgroundTransparency = 1
ESPToggleLabel.Text = "Toggle ESP:"
ESPToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPToggleLabel.Font = Enum.Font.Gotham
ESPToggleLabel.TextSize = 18
ESPToggleLabel.Parent = ContentFrame

local ToggleESPButton = Instance.new("TextButton")
ToggleESPButton.Name = "ToggleESPButton"
ToggleESPButton.Size = UDim2.new(0, 140, 0, 30)
ToggleESPButton.Position = UDim2.new(0, 10, 0, 140)
ToggleESPButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ToggleESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleESPButton.Font = Enum.Font.GothamBold
ToggleESPButton.TextSize = 14
ToggleESPButton.Text = "ESP: ON"
ToggleESPButton.Parent = ContentFrame

ToggleESPButton.MouseButton1Click:Connect(function()
    Settings.ESPEnabled = not Settings.ESPEnabled
    if Settings.ESPEnabled then
        ToggleESPButton.Text = "ESP: ON"
    else
        ToggleESPButton.Text = "ESP: OFF"
        for _, lines in pairs(Skeletons) do
            for _, line in ipairs(lines) do
                line.Visible = false
            end
        end
    end
end)

-- Minimize- und Close-Funktionalität
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    ContentFrame.Visible = not minimized
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 320, 0, 50), "Out", "Quad", 0.3, true)
    else
        MainFrame:TweenSize(UDim2.new(0, 320, 0, 220), "Out", "Quad", 0.3, true)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Dragging-Script für die Titelleiste
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-------------------------------
-- ESP & SKELETON DRAWING CODE
-------------------------------

local function newLine()
    local line = Drawing.new("Line")
    line.Visible = false
    line.Color = Settings.BoneESPColor
    line.Thickness = 4  -- Deutlich besser sichtbar
    return line
end

local function createSkeleton(player)
    if not player.Character then return end
    local character = player.Character
    local rigType = nil

    if character:FindFirstChild("Torso") then
        rigType = "R6"
    elseif character:FindFirstChild("UpperTorso") then
        rigType = "R15"
    else
        return  -- Unsupported Rig
    end

    -- Vorhandene Linien löschen, falls vorhanden
    if Skeletons[player] then
        for _, line in ipairs(Skeletons[player]) do
            line:Remove()
        end
        Skeletons[player] = {}
    end

    Skeletons[player] = {}

    -- Zahlreiche Debug-Zeilen kannst du hier einfügen, um zu prüfen, ob die Umrechnung in Bildschirmkoordinaten funktioniert.
    local function addLine(startWorldPos, endWorldPos)
        local screenStart, onScreenStart = Camera:WorldToViewportPoint(startWorldPos)
        local screenEnd, onScreenEnd = Camera:WorldToViewportPoint(endWorldPos)
        if onScreenStart and onScreenEnd then
            local line = newLine()
            line.From = Vector2.new(screenStart.X, screenStart.Y)
            line.To = Vector2.new(screenEnd.X, screenEnd.Y)
            line.Visible = true
            table.insert(Skeletons[player], line)
        end
    end

    if rigType == "R6" then
        local torso = character:FindFirstChild("Torso")
        local head = character:FindFirstChild("Head")
        local leftArm = character:FindFirstChild("Left Arm")
        local rightArm = character:FindFirstChild("Right Arm")
        local leftLeg = character:FindFirstChild("Left Leg")
        local rightLeg = character:FindFirstChild("Right Leg")

        if torso and head then
            addLine(torso.Position, head.Position)
        end
        if torso and leftArm then
            addLine(torso.Position, leftArm.Position)
        end
        if torso and rightArm then
            addLine(torso.Position, rightArm.Position)
        end
        if torso and leftLeg then
            addLine(torso.Position, leftLeg.Position)
        end
        if torso and rightLeg then
            addLine(torso.Position, rightLeg.Position)
        end
    else  -- R15
        local upperTorso = character:FindFirstChild("UpperTorso")
        local head = character:FindFirstChild("Head")
        local leftUpperArm = character:FindFirstChild("LeftUpperArm")
        local rightUpperArm = character:FindFirstChild("RightUpperArm")
        local leftLowerArm = character:FindFirstChild("LeftLowerArm")
        local rightLowerArm = character:FindFirstChild("RightLowerArm")
        local leftUpperLeg = character:FindFirstChild("LeftUpperLeg")
        local rightUpperLeg = character:FindFirstChild("RightUpperLeg")
        local leftLowerLeg = character:FindFirstChild("LeftLowerLeg")
        local rightLowerLeg = character:FindFirstChild("RightLowerLeg")

        if upperTorso and head then
            addLine(upperTorso.Position, head.Position)
        end
        if upperTorso and leftUpperArm then
            addLine(upperTorso.Position, leftUpperArm.Position)
        end
        if upperTorso and rightUpperArm then
            addLine(upperTorso.Position, rightUpperArm.Position)
        end
        if leftUpperArm and leftLowerArm then
            addLine(leftUpperArm.Position, leftLowerArm.Position)
        end
        if rightUpperArm and rightLowerArm then
            addLine(rightUpperArm.Position, rightLowerArm.Position)
        end
        if upperTorso and leftUpperLeg then
            addLine(upperTorso.Position, leftUpperLeg.Position)
        end
        if upperTorso and rightUpperLeg then
            addLine(upperTorso.Position, rightUpperLeg.Position)
        end
        if leftUpperLeg and leftLowerLeg then
            addLine(leftUpperLeg.Position, leftLowerLeg.Position)
        end
        if rightUpperLeg and rightLowerLeg then
            addLine(rightUpperLeg.Position, rightLowerLeg.Position)
        end
    end
end

RunService.RenderStepped:Connect(function()
    -- Für jeden Spieler: ESP-Update
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if player.Character then
                if Settings.ESPEnabled then
                    -- Zur Vereinfachung: Erstelle das Skeleton in jedem Frame neu (später ggf. optimieren)
                    createSkeleton(player)
                    for _, line in ipairs(Skeletons[player]) do
                        line.Color = Settings.BoneESPColor
                        line.Thickness = 4
                        line.Visible = true
                    end
                else
                    if Skeletons[player] then
                        for _, line in ipairs(Skeletons[player]) do
                            line.Visible = false
                        end
                    end
                end
            end
        end
    end
end)
