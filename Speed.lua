-- LocalScript (StarterPlayerScripts hoặc StarterGui)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Biến lưu speed hiện tại
local currentSpeed = 16

-- Hàm áp dụng speed cho nhân vật hiện tại
local function applySpeed()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.WalkSpeed = currentSpeed
end

-- Áp dụng ban đầu
applySpeed()

-- Mỗi khi nhân vật được tạo lại, áp dụng lại speed
player.CharacterAdded:Connect(function()
	task.wait(0.1)
	applySpeed()
end)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedTextGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Nút mở/tắt menu
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 110, 0, 35)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.Text = "🛠 Speed Menu"
toggleBtn.Parent = gui

-- Khung menu
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 230, 0, 140)
frame.Position = UDim2.new(0, 10, 0, 55)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "⚡ Speed từ 0 - 1000"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame

-- TextBox nhập speed
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.85, 0, 0, 35)
speedBox.Position = UDim2.new(0.075, 0, 0, 40)
speedBox.PlaceholderText = "Nhập speed (0 - 1000)"
speedBox.Text = ""
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 16
speedBox.TextColor3 = Color3.new(0, 0, 0)
speedBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
speedBox.ClearTextOnFocus = false
speedBox.Parent = frame

-- Nút áp dụng
local applyBtn = Instance.new("TextButton")
applyBtn.Size = UDim2.new(0.85, 0, 0, 30)
applyBtn.Position = UDim2.new(0.075, 0, 0, 90)
applyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
applyBtn.TextColor3 = Color3.new(1, 1, 1)
applyBtn.Font = Enum.Font.GothamBold
applyBtn.TextSize = 16
applyBtn.Text = "Áp dụng"
applyBtn.Parent = frame

-- Toggle ẩn/hiện menu
toggleBtn.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- Áp dụng speed khi bấm nút
applyBtn.MouseButton1Click:Connect(function()
	local input = tonumber(speedBox.Text)
	if input and input >= 0 and input <= 1000 then
		currentSpeed = input
		applySpeed()
		applyBtn.Text = "✅ OK: " .. input
	else
		applyBtn.Text = "❌ Sai! (0 - 1000)"
	end

	task.wait(1.5)
	applyBtn.Text = "Áp dụng"
end)
