local function randomString(length)
	local result = ""
	for i = 1, length do
		result = result .. string.char(math.random(97, 122))
	end
	return result
end

local lib = {}
local TweenService = game:GetService("TweenService")

local ScreenGui_1 = Instance.new("ScreenGui")
local Main_1 = Instance.new("Frame")
local Template_1 = Instance.new("Frame")
local Title_1 = Instance.new("TextLabel")
local UIStroke_1 = Instance.new("UIStroke")
local Text_1 = Instance.new("TextLabel")
local UIStroke_2 = Instance.new("UIStroke")
local UIPadding_1 = Instance.new("UIPadding")
local UIListLayout_1 = Instance.new("UIListLayout")
local UIPadding_2 = Instance.new("UIPadding")

local allInstances = {
	ScreenGui_1,
	Main_1,
	Template_1,
	Title_1,
	UIStroke_1,
	Text_1,
	UIStroke_2,
	UIPadding_1,
	UIListLayout_1,
	UIPadding_2
}

for _, inst in ipairs(allInstances) do
	inst.Name = randomString(15)
end

ScreenGui_1.Parent = gethui()

Main_1.BackgroundTransparency = 1
Main_1.Name = "Main"
Main_1.Parent = ScreenGui_1
Main_1.Position = UDim2.new(0.8715739846229553, 0, 0, 0)
Main_1.Size = UDim2.new(-0.03132341429591179, 204, 1, 0)
Main_1.Selectable = false

Template_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Template_1.BackgroundTransparency = 1
Template_1.Name = "Template"
Template_1.Parent = Main_1
Template_1.Position = UDim2.new(0, 0, 0.8414442539215088, 0)
Template_1.Size = UDim2.new(0, 200, 0, 101)
Template_1.SizeConstraint = Enum.SizeConstraint.RelativeXX
Template_1.Selectable = false

Title_1.BackgroundTransparency = 1
Title_1.Name = "Title"
Title_1.Parent = Template_1
Title_1.Size = UDim2.new(0, 200, 0, 22)
Title_1.Selectable = false
Title_1.Text = "Title"
Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_1.TextScaled = true
Title_1.TextSize = 14
Title_1.TextWrapped = true

UIStroke_1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_1.Color = Color3.fromRGB(255, 255, 255)
UIStroke_1.Parent = Title_1

Text_1.BackgroundTransparency = 1
Text_1.Name = "Text"
Text_1.Parent = Template_1
Text_1.Position = UDim2.new(0, 0, 0.23000000417232513, 0)
Text_1.Size = UDim2.new(0, 200, 0, 78)
Text_1.Selectable = false
Text_1.Text = "Text"
Text_1.TextColor3 = Color3.fromRGB(255, 255, 255)
Text_1.TextSize = 14
Text_1.TextWrapped = true
Text_1.TextXAlignment = Enum.TextXAlignment.Left
Text_1.TextYAlignment = Enum.TextYAlignment.Top

UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
UIStroke_2.Parent = Text_1

UIPadding_1.Parent = Text_1
UIPadding_1.PaddingLeft = UDim.new(0, 3)
UIPadding_1.PaddingTop = UDim.new(0, 2)

UIListLayout_1.Padding = UDim.new(0, 10)
UIListLayout_1.Parent = Main_1
UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Bottom

UIPadding_2.Parent = Main_1
UIPadding_2.PaddingBottom = UDim.new(0, 7)

Template_1.Visible = false

local activeNotifications = {}
local MAX_NOTIFICATIONS = 6

function lib.makenotis(title: string, text: string, duration: number)
	if #activeNotifications >= MAX_NOTIFICATIONS then
		local oldestNotif = table.remove(activeNotifications, 1)
		if oldestNotif and oldestNotif.Parent then
			oldestNotif:Destroy()
		end
	end

	local Clone = Template_1:Clone()
	Clone.Name = "Notification_" .. title
	Clone.Text.Text = text
	Clone.Title.Text = title
	Clone.Parent = Main_1
	Clone.Visible = true

	table.insert(activeNotifications, Clone)

	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local tweenIn = TweenService:Create(Clone, tweenInfo, {BackgroundTransparency = 0.5})
	local tweenInTitle = TweenService:Create(Clone.Title, tweenInfo, {TextTransparency = 0})
	local tweenInTitleStroke = TweenService:Create(Clone.Title.UIStroke, tweenInfo, {Transparency = 0})
	local tweenInText = TweenService:Create(Clone.Text, tweenInfo, {TextTransparency = 0})
	local tweenInTextStroke = TweenService:Create(Clone.Text.UIStroke, tweenInfo, {Transparency = 0})

	tweenIn:Play()
	tweenInTitle:Play()
	tweenInTitleStroke:Play()
	tweenInText:Play()
	tweenInTextStroke:Play()

	local function removeNotif()
		local index = table.find(activeNotifications, Clone)
		if index then
			table.remove(activeNotifications, index)
		end

		local tweenOut = TweenService:Create(Clone, tweenInfo, {BackgroundTransparency = 1})
		local tweenOutTitle = TweenService:Create(Clone.Title, tweenInfo, {TextTransparency = 1})
		local tweenOutTitleStroke = TweenService:Create(Clone.Title.UIStroke, tweenInfo, {Transparency = 1})
		local tweenOutText = TweenService:Create(Clone.Text, tweenInfo, {TextTransparency = 1})
		local tweenOutTextStroke = TweenService:Create(Clone.Text.UIStroke, tweenInfo, {Transparency = 1})

		tweenOut:Play()
		tweenOutTitle:Play()
		tweenOutTitleStroke:Play()
		tweenOutText:Play()
		tweenOutTextStroke:Play()

		task.delay(0.3, function()
			Clone:Destroy()
		end)
	end

	task.delay(duration, removeNotif)
end

return lib
