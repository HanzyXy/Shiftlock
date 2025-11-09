-- ShiftLock Enhanced Edition (Round Button + Cursor Follow Body)
-- Remade by Hanzyy (Base by tibe0124)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local MaxLength = 900000

-- GUI
local ShiftLockScreenGui = Instance.new("ScreenGui")
local ShiftLockButton = Instance.new("ImageButton")
local ShiftlockCursor = Instance.new("ImageLabel")

ShiftLockScreenGui.Name = "ShiftLock"
ShiftLockScreenGui.Parent = CoreGui
ShiftLockScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ShiftLockScreenGui.ResetOnSpawn = false

-- 🔘 Tombol Bulat di kanan-tengah
ShiftLockButton.Parent = ShiftLockScreenGui
ShiftLockButton.BackgroundTransparency = 0
ShiftLockButton.AnchorPoint = Vector2.new(1, 0.5)
ShiftLockButton.Position = UDim2.new(0.98, 0, 0.5, 0)
ShiftLockButton.Size = UDim2.new(0.06, 0, 0.06, 0)
ShiftLockButton.SizeConstraint = Enum.SizeConstraint.RelativeXX
ShiftLockButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ShiftLockButton.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
ShiftLockButton.ScaleType = Enum.ScaleType.Fit

-- Buat tombol jadi bulat sempurna
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ShiftLockButton

-- 🔳 Cursor ShiftLock
ShiftlockCursor.Name = "ShiftlockCursor"
ShiftlockCursor.Parent = ShiftLockScreenGui
ShiftlockCursor.Image = "rbxasset://textures/MouseLockedCursor.png"
ShiftlockCursor.Size = UDim2.new(0.03, 0, 0.03, 0)
ShiftlockCursor.AnchorPoint = Vector2.new(0.5, 0.5)
ShiftlockCursor.BackgroundTransparency = 1
ShiftlockCursor.Visible = false

-- Variabel
local Active = nil
local EnabledOffset = CFrame.new(1.7, 0, 0)
local DisabledOffset = CFrame.new(-1.7, 0, 0)

-- Fungsi toggle ShiftLock
local function toggleShiftlock()
	if not Active then
		Active = RunService.RenderStepped:Connect(function()
			local char = Player.Character
			if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end

			local hrp = char.HumanoidRootPart
			local humanoid = char.Humanoid
			humanoid.AutoRotate = false

			-- Kamera dan orientasi tubuh
			hrp.CFrame = CFrame.new(
				hrp.Position,
				Vector3.new(
					Camera.CFrame.LookVector.X * MaxLength,
					hrp.Position.Y,
					Camera.CFrame.LookVector.Z * MaxLength
				)
			)

			-- Update posisi cursor agar berada di depan tubuh karakter (sekitar 3 stud di depan)
			local frontPos = hrp.Position + hrp.CFrame.LookVector * 3
			local screenPoint, onScreen = Camera:WorldToViewportPoint(frontPos)
			if onScreen then
				ShiftlockCursor.Position = UDim2.new(0, screenPoint.X, 0, screenPoint.Y)
			end

			ShiftLockButton.Image = "rbxasset://textures/ui/mouseLock_on@2x.png"
			ShiftlockCursor.Visible = true
		end)
	else
		pcall(function()
			Active:Disconnect()
			Active = nil
		end)

		local char = Player.Character
		if char and char:FindFirstChild("Humanoid") then
			char.Humanoid.AutoRotate = true
		end

		ShiftLockButton.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
		ShiftlockCursor.Visible = false
	end
end

-- Klik tombol untuk aktif/nonaktif
ShiftLockButton.MouseButton1Click:Connect(toggleShiftlock)
