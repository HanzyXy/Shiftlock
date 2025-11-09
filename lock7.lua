-- ShiftLock Script (Stable Version)
-- Dibuat agar bekerja 100% tanpa GUI modern
-- Cursor tetap diam di tengah tubuh saat aktif

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local PlayerGui = player:WaitForChild("PlayerGui")
local ShiftLockGui = Instance.new("ScreenGui")
ShiftLockGui.Name = "ShiftLockGui"
ShiftLockGui.Parent = PlayerGui

-- Tombol ShiftLock
local ShiftLockButton = Instance.new("ImageButton")
ShiftLockButton.Name = "ShiftLockButton"
ShiftLockButton.Parent = ShiftLockGui
ShiftLockButton.AnchorPoint = Vector2.new(0.5, 0.5)
ShiftLockButton.Size = UDim2.new(0, 70, 0, 70)
ShiftLockButton.Position = UDim2.new(0.95, 0, 0.5, 0) -- kanan tengah
ShiftLockButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ShiftLockButton.Image = "rbxassetid://3926307971"
ShiftLockButton.ImageRectOffset = Vector2.new(4, 204)
ShiftLockButton.ImageRectSize = Vector2.new(36, 36)
ShiftLockButton.BackgroundTransparency = 0.2
ShiftLockButton.AutoButtonColor = true
ShiftLockButton.ClipsDescendants = true
ShiftLockButton.ZIndex = 2
ShiftLockButton.BorderSizePixel = 0
ShiftLockButton.ImageColor3 = Color3.fromRGB(0, 0, 0)
ShiftLockButton.Visible = true

-- Biar tombol bulat sempurna
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ShiftLockButton

-- Popup Loaded
local LoadedPopup = Instance.new("TextLabel")
LoadedPopup.Parent = ShiftLockGui
LoadedPopup.Size = UDim2.new(0, 250, 0, 50)
LoadedPopup.Position = UDim2.new(0.5, -125, 0.8, 0)
LoadedPopup.BackgroundTransparency = 0.3
LoadedPopup.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
LoadedPopup.Text = "✅ Loaded Script Successfully!"
LoadedPopup.TextColor3 = Color3.new(1, 1, 1)
LoadedPopup.Font = Enum.Font.SourceSansBold
LoadedPopup.TextScaled = true
LoadedPopup.Visible = true

task.delay(3, function()
	LoadedPopup:Destroy()
end)

-- Cursor Tengah Tubuh
local Cursor = Instance.new("ImageLabel")
Cursor.Name = "ShiftLockCursor"
Cursor.Parent = ShiftLockGui
Cursor.AnchorPoint = Vector2.new(0.5, 0.5)
Cursor.Size = UDim2.new(0, 25, 0, 25)
Cursor.Position = UDim2.new(0.5, 0, 0.5, 0)
Cursor.BackgroundTransparency = 1
Cursor.Image = "rbxassetid://7072718362" -- cursor bulat
Cursor.Visible = false

-- Logic ShiftLock
local shiftLockEnabled = false

local function toggleShiftLock()
	shiftLockEnabled = not shiftLockEnabled
	if shiftLockEnabled then
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		Cursor.Visible = true
		ShiftLockButton.ImageColor3 = Color3.fromRGB(0, 255, 127)
	else
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		Cursor.Visible = false
		ShiftLockButton.ImageColor3 = Color3.fromRGB(0, 0, 0)
	end
end

ShiftLockButton.MouseButton1Click:Connect(toggleShiftLock)

-- Jaga kamera tetap terkunci pada karakter tanpa menggerakkan cursor
RunService.RenderStepped:Connect(function()
	if shiftLockEnabled and character and character:FindFirstChild("HumanoidRootPart") then
		-- Kamera mengikuti karakter tapi kursor tidak bergerak
		local cam = workspace.CurrentCamera
		cam.CameraSubject = humanoid
	end
end)

print("✅ ShiftLock Script Loaded Successfully!")
