-- ShiftLock Clean Edition (Right Middle Button)
-- Remade by Hanzyy (Base by tibe0124)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local MaxLength = 900000

-- GUI
local ShiftLockScreenGui = Instance.new("ScreenGui")
local ShiftLockButton = Instance.new("ImageButton")
local ShiftlockCursor = Instance.new("ImageLabel")

ShiftLockScreenGui.Name = "ShiftLock"
ShiftLockScreenGui.Parent = CoreGui
ShiftLockScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ShiftLockScreenGui.ResetOnSpawn = false

-- 🔘 Tombol di kanan-tengah layar
ShiftLockButton.Parent = ShiftLockScreenGui
ShiftLockButton.BackgroundTransparency = 1
ShiftLockButton.AnchorPoint = Vector2.new(1, 0.5)
ShiftLockButton.Position = UDim2.new(0.98, 0, 0.5, 0) -- kanan-tengah
ShiftLockButton.Size = UDim2.new(0.05, 0, 0.08, 0)
ShiftLockButton.SizeConstraint = Enum.SizeConstraint.RelativeXX
ShiftLockButton.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"

-- 🔳 Kursor ShiftLock
ShiftlockCursor.Name = "ShiftlockCursor"
ShiftlockCursor.Parent = ShiftLockScreenGui
ShiftlockCursor.Image = "rbxasset://textures/MouseLockedCursor.png"
ShiftlockCursor.Size = UDim2.new(0.03, 0, 0.03, 0)
ShiftlockCursor.Position = UDim2.new(0.5, 0, 0.5, 0)
ShiftlockCursor.AnchorPoint = Vector2.new(0.5, 0.5)
ShiftlockCursor.BackgroundTransparency = 1
ShiftlockCursor.Visible = false

-- Variabel
local Active = nil
local EnabledOffset = CFrame.new(1.7, 0, 0)
local DisabledOffset = CFrame.new(-1.7, 0, 0)

-- Fungsi toggle
local function toggleShiftlock()
	if not Active then
		Active = RunService.RenderStepped:Connect(function()
			local char = Player.Character
			if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
			local humanoid = char.Humanoid
			humanoid.AutoRotate = false
			ShiftLockButton.Image = "rbxasset://textures/ui/mouseLock_on@2x.png"
			ShiftlockCursor.Visible = true

			local hrp = char.HumanoidRootPart
			hrp.CFrame = CFrame.new(
				hrp.Position,
				Vector3.new(
					workspace.CurrentCamera.CFrame.LookVector.X * MaxLength,
					hrp.Position.Y,
					workspace.CurrentCamera.CFrame.LookVector.Z * MaxLength
				)
			)
			workspace.CurrentCamera.CFrame *= EnabledOffset
			workspace.CurrentCamera.Focus =
				CFrame.fromMatrix(
					workspace.CurrentCamera.Focus.Position,
					workspace.CurrentCamera.CFrame.RightVector,
					workspace.CurrentCamera.CFrame.UpVector
				) * EnabledOffset
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
		workspace.CurrentCamera.CFrame *= DisabledOffset
	end
end

-- Klik tombol
ShiftLockButton.MouseButton1Click:Connect(toggleShiftlock)
