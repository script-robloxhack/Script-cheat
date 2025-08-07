-- LocalScript (StarterPlayerScripts hoặc StarterGui)

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Biến lưu speed hiện tại
local currentSpeed = 16

-- Hàm áp dụng WalkSpeed
local function applyWalkSpeed()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.WalkSpeed = currentSpeed
end

-- Hàm áp dụng tốc độ animation
local function applyAnimationSpeed()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local animator = humanoid:FindFirstChildOfClass("Animator")
	if animator then
		for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
			track:AdjustSpeed(currentSpeed / 16)
		end
	end
end

-- Gọi cả 2 khi nhân vật mới
local function applyAll()
	applyWalkSpeed()
	applyAnimationSpeed()
end

-- Lần đầu
applyAll()

-- Khi nhân vật respawn
player.CharacterAdded:Connect(function()
	task.wait(0.1)
	applyAll()
end)

-- GUI setup
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Nút mở/tắt GUI
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 120, 0, 35)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 14
toggleBtn.Text = "⚙ Speed Menu"
toggleBtn.Parent = gui

-- Khung chính
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 190)
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
title.Text = "⚡ Speed & Animation"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame

-- Ô nhập speed
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.85, 0, 0, 35)
speedBox.Position = UDim2.new(0.075, 0, 0, 40)
speedBox.PlaceholderText = "Speed (0 - 1000)"
speedBox.Text = ""
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 16
speedBox.TextColor3 = Color3.new(0, 0, 0)
speedBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
speedBox.ClearTextOnFocus = false
speedBox.Parent = frame

-- Nút áp dụng WalkSpeed
local walkBtn = Instance.new("TextButton")
walkBtn.Size = UDim2.new(0.85, 0, 0, 30)
walkBtn.Position = UDim2.new(0.075, 0, 0, 85)
walkBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
walkBtn.TextColor3 = Color3.new(1, 1, 1)
walkBtn.Font = Enum.Font.GothamBold
walkBtn.TextSize = 14
walkBtn.Text = "Áp dụng WalkSpeed"
walkBtn.Parent = frame

-- Nút áp dụng AnimationSpeed
local animBtn = Instance.new("TextButton")
animBtn.Size = UDim2.new(0.85, 0, 0, 30)
animBtn.Position = UDim2.new(0.075, 0, 0, 120)
animBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
animBtn.TextColor3 = Color3.new(1, 1, 1)
animBtn.Font = Enum.Font.GothamBold
animBtn.TextSize = 14
animBtn.Text = "Áp dụng AnimationSpeed"
animBtn.Parent = frame

-- Nút Reset
local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0.85, 0, 0, 25)
resetBtn.Position = UDim2.new(0.075, 0, 1, -30)
resetBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
resetBtn.TextColor3 = Color3.new(1, 1, 1)
resetBtn.Font = Enum.Font.GothamBold
resetBtn.TextSize = 14
resetBtn.Text = "🔁 Reset"
resetBtn.Parent = frame

-- Toggle mở/tắt GUI
toggleBtn.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-- Áp dụng WalkSpeed
walkBtn.MouseButton1Click:Connect(function()
	local val = tonumber(speedBox.Text)
	if val and val >= 0 and val <= 1000 then
		currentSpeed = val
		applyWalkSpeed()
		walkBtn.Text = "✅ WalkSpeed OK"
	else
		walkBtn.Text = "❌ Nhập sai (0-1000)"
	end
	task.wait(1.5)
	walkBtn.Text = "Áp dụng WalkSpeed"
end)

-- Áp dụng AnimationSpeed
animBtn.MouseButton1Click:Connect(function()
	local val = tonumber(speedBox.Text)
	if val and val >= 0 and val <= 1000 then
		currentSpeed = val
		applyAnimationSpeed()
		animBtn.Text = "✅ Animation OK"
	else
		animBtn.Text = "❌ Nhập sai (0-1000)"
	end
	task.wait(1.5)
	animBtn.Text = "Áp dụng AnimationSpeed"
end)

-- Nút Reset về mặc định
resetBtn.MouseButton1Click:Connect(function()
	currentSpeed = 16
	speedBox.Text = ""
	applyAll()
	resetBtn.Text = "🔁 Đã Reset!"
	task.wait(1.5)
	resetBtn.Text = "🔁 Reset"
end)
