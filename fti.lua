-- Made by HanzyyOffc | ShiftLock Script 100% WORK

-- GUI
local ScreenGui = Instance.new("ScreenGui")
local ShiftLockButton = Instance.new("ImageButton")
local Cursor = Instance.new("ImageLabel")
local Player = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- Parent GUI
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "HanzyyShiftLock"

-- Tombol ShiftLock (bulat dan kecil)
ShiftLockButton.Name = "ShiftLockButton"
ShiftLockButton.Parent = ScreenGui
ShiftLockButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- hitam
ShiftLockButton.Size = UDim2.new(0, 65, 0, 65) -- kecil
ShiftLockButton.Position = UDim2.new(0.92, 0, 0.45, 0) -- kanan tengah
ShiftLockButton.AnchorPoint = Vector2.new(0.5, 0.5)
ShiftLockButton.BorderSizePixel = 0
ShiftLockButton.AutoButtonColor = true
ShiftLockButton.Image = "rbxassetid://3926305904" -- default icon
ShiftLockButton.ImageRectOffset = Vector2.new(764, 764)
ShiftLockButton.ImageRectSize = Vector2.new(36, 36)
ShiftLockButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
ShiftLockButton.ClipsDescendants = true
ShiftLockButton.ZIndex = 2
ShiftLockButton.BackgroundTransparency = 0.3
ShiftLockButton.Visible = true
ShiftLockButton.Style = Enum.ButtonStyle.Custom
ShiftLockButton:SetAttribute("Corner", true)

-- Membulatkan tombol
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ShiftLockButton

-- Cursor (tanda + di tengah karakter)
Cursor.Name = "ShiftLockCursor"
Cursor.Parent = ScreenGui
Cursor.BackgroundTransparency = 1
Cursor.Image = "rbxassetid://3926307971"
Cursor.ImageRectOffset = Vector2.new(124, 924)
Cursor.ImageRectSize = Vector2.new(36, 36)
Cursor.Size = UDim2.new(0, 40, 0, 40)
Cursor.Visible = false

-- Fungsi ShiftLock
local shiftLocked = false
local cameraOffset = Vector3.new(2, 0, 0)

local function toggleShiftLock()
	shiftLocked = not shiftLocked
	Cursor.Visible = shiftLocked

	if shiftLocked then
		game.StarterGui:SetCore("SendNotification", {
			Title = "ShiftLock";
			Text = "Enabled";
			Duration = 2;
		})
	else
		game.StarterGui:SetCore("SendNotification", {
			Title = "ShiftLock";
			Text = "Disabled";
			Duration = 2;
		})
	end
end

ShiftLockButton.MouseButton1Click:Connect(toggleShiftLock)

-- Update posisi cursor agar selalu di depan tubuh karakter
RunService.RenderStepped:Connect(function()
	if shiftLocked and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = Player.Character:WaitForChild("HumanoidRootPart")
		local pos, visible = Camera:WorldToViewportPoint(hrp.Position + hrp.CFrame.LookVector * 3)
		if visible then
			Cursor.Position = UDim2.new(0, pos.X - 20, 0, pos.Y - 20)
		end
	end
end)

-- Popup sukses
game.StarterGui:SetCore("SendNotification", {
	Title = "Hanzyy Script";
	Text = "Loaded Script Successfully";
	Duration = 3;
})
