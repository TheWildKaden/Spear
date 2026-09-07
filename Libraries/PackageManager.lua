local PackageManager = {}

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local NotificationGui

local function create(className, properties, parent)
	local object = Instance.new(className)

	for property, value in pairs(properties or {}) do
		object[property] = value
	end

	object.Parent = parent
	return object
end

local function round(object, radius)
	create("UICorner", {
		CornerRadius = UDim.new(0, radius)
	}, object)
end

local function getNotificationGui()
	if NotificationGui and NotificationGui.Parent then
		return NotificationGui
	end

	NotificationGui = create("ScreenGui", {
		Name = "PackageManagerNotifications",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	}, CoreGui)

	return NotificationGui
end

function PackageManager.Notify(title, message, duration)
	local gui = getNotificationGui()

	local notification = create("Frame", {
		Size = UDim2.fromOffset(330, 72),
		Position = UDim2.new(1, 20, 1, -90),
		AnchorPoint = Vector2.new(0, 1),
		BackgroundColor3 = Color3.fromRGB(24, 24, 28),
		BorderSizePixel = 0
	}, gui)

	round(notification, 8)

	local titleLabel = create("TextLabel", {
		Size = UDim2.new(1, -24, 0, 22),
		Position = UDim2.fromOffset(12, 8),
		BackgroundTransparency = 1,
		Text = tostring(title),
		TextColor3 = Color3.fromRGB(240, 240, 245),
		TextSize = 13,
		Font = Enum.Font.GothamSemibold,
		TextXAlignment = Enum.TextXAlignment.Left
	}, notification)

	local messageLabel = create("TextLabel", {
		Size = UDim2.new(1, -24, 0, 32),
		Position = UDim2.fromOffset(12, 31),
		BackgroundTransparency = 1,
		Text = tostring(message),
		TextColor3 = Color3.fromRGB(160, 160, 168),
		TextSize = 10,
		Font = Enum.Font.Gotham,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top
	}, notification)

	local tweenIn = TweenService:Create(
		notification,
		TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{
			Position = UDim2.new(1, -350, 1, -90)
		}
	)

	tweenIn:Play()

	task.delay(duration or 4, function()
		if not notification.Parent then
			return
		end

		local tweenOut = TweenService:Create(
			notification,
			TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
			{
				Position = UDim2.new(1, 20, 1, -90)
			}
		)

		tweenOut:Play()
		tweenOut.Completed:Wait()

		notification:Destroy()
	end)

	return notification
end

local function loadSource(source, name)
	if type(source) ~= "string" or source == "" then
		return false, "Invalid source"
	end

	if type(loadstring) ~= "function" then
		return false, "loadstring is unavailable"
	end

	local success, chunk = pcall(
		loadstring,
		source,
		name
	)

	if not success then
		return false, tostring(chunk)
	end

	if type(chunk) ~= "function" then
		return false, "Source did not compile into a function"
	end

	local ok, result = pcall(chunk)

	if not ok then
		return false, tostring(result)
	end

	return true, result
end

function PackageManager.Load(packages)
	assert(
		type(packages) == "table",
		"PackageManager.Load expects a table"
	)

	local loaded = {}

	for name, url in pairs(packages) do
		if type(url) ~= "string" then
			PackageManager.Notify(
				"Package Failed",
				("%s has an invalid URL"):format(tostring(name)),
				5
			)

			error(
				("%s has an invalid URL"):format(tostring(name)),
				2
			)
		end

		local success, source = pcall(function()
			return game:HttpGet(url)
		end)

		if not success then
			local message = tostring(source)

			PackageManager.Notify(
				"Package Failed",
				("%s failed to download:\n%s"):format(
					tostring(name),
					message
				),
				5
			)

			error(
				("%s failed to download:\n%s"):format(
					tostring(name),
					message
				),
				2
			)
		end

		local ok, result = loadSource(
			source,
			"PackageManager/" .. tostring(name)
		)

		if not ok then
			PackageManager.Notify(
				"Package Failed",
				("%s failed to load:\n%s"):format(
					tostring(name),
					tostring(result)
				),
				5
			)

			error(
				("%s failed to load:\n%s"):format(
					tostring(name),
					tostring(result)
				),
				2
			)
		end

		loaded[name] = result
	end

	return loaded
end

function PackageManager.LoadOne(name, url)
	assert(
		type(name) == "string",
		"Package name must be a string"
	)

	assert(
		type(url) == "string",
		"Package URL must be a string"
	)

	local success, source = pcall(function()
		return game:HttpGet(url)
	end)

	if not success then
		PackageManager.Notify(
			"Package Failed",
			("%s failed to download:\n%s"):format(
				name,
				tostring(source)
			),
			5
		)

		error(
			("%s failed to download:\n%s"):format(
				name,
				tostring(source)
			),
			2
		)
	end

	local ok, result = loadSource(
		source,
		"PackageManager/" .. name
	)

	if not ok then
		PackageManager.Notify(
			"Package Failed",
			("%s failed to load:\n%s"):format(
				name,
				tostring(result)
			),
			5
		)

		error(
			("%s failed to load:\n%s"):format(
				name,
				tostring(result)
			),
			2
		)
	end

	return result
end

return PackageManager
