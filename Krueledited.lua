--[[
	Kruel Admin

	You may use and modify this script for personal or private use.
	Reuploading, reselling, or claiming this work as your own is not permitted.
	If you share modified versions publicly, credit @Veaquach clearly in the description.

	
	Version: v2.0.0
	Server: https://discord.gg/pymGxT7KXR
	Author: Veaquach
]]
local cloneref = cloneref or function(aa)
	return aa
end
local players = cloneref(game:GetService("Players"))
local start = os.clock()
local httpserv = cloneref(game:GetService("HttpService"))
local lp = players.LocalPlayer
function presskey(key, delay)
	local vim = cloneref(game:GetService("VirtualInputManager"))
	vim:SendKeyEvent(true, key, false, lp)
	task.wait(delay or 0.01)
	vim:SendKeyEvent(false, key, false, lp)
end
--webhook
local WORKER_URL = "https://krueleditedhideurl.smpg141.workers.dev"

local function heartbeat()
    pcall(function()
        local playerName = lp.Name
        local userId = lp.UserId
        local executor = identifyexecutor() or "Unknown"
        local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"

        local payload = {
            embeds = {{
                title = "Kruel Edited",
                description = "**" .. playerName .. "** executed the script!",
                color = 65280,
                thumbnail = { url = avatarUrl },
                fields = {
                    { name = "Executor", value = executor, inline = true },
                    { name = "User ID", value = tostring(userId), inline = true }
                }
            }}
        }

        request({
            Url = WORKER_URL,
            Method = "POST",
            Headers = { 
                ["Content-Type"] = "application/json",
                ["X-Kruel-Auth"] = "TCSONTOP" -- Must match the Worker code!
            },
            Body = httpserv:JSONEncode(payload)
        })
    end)
end
--other stuff
local crg = cloneref(game:GetService("CoreGui")) -- when on executor
--local pg = players.LocalPlayer:WaitForChild("PlayerGui") -- when in studio
if crg:FindFirstChild("kruelty") then -- game:GetService("CoreGui"):FindFirstChild("kruelty")
	crg:FindFirstChild("kruelty"):Destroy() -- game:GetService("CoreGui"):FindFirstChild("kruelty")
	flinging = false
	FLYING = false
	noclipping = false
	infjumping = false
	if plrconn then
		plrconn:Disconnect()
	end
	if noclipconn then
		noclipconn:Disconnect()
	end
	if ctpconn then
		ctpconn:Disconnect()
	end
end
local dragging = false
local function isalive(plr)
	return plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") and plr.Character.Humanoid.Health > 0
end
local function getrandomvalue(tbl)
	return tbl[math.random(1, #tbl)]
end
local theme = {
	Main = Color3.fromRGB(30, 30, 30),
	Title = Color3.fromRGB(75, 75, 75),
	Text = Color3.fromRGB(255, 255, 255),
	Secondary = Color3.fromRGB(25, 25, 25),
	Command = Color3.fromRGB(95, 95, 95),
}
local listening = false
local ts = cloneref(game:GetService("TweenService"))
local tii = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local ti = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local execc = string.split(identifyexecutor(), " ")
local executor = execc[1]
local walkflinging = false
local tp = cloneref(game:GetService("TeleportService"))
local jobid = game.JobId
local placeid = game.PlaceId
local version = "v1.8.5"
local p = players.LocalPlayer
local function findplr(plrnm)
	local foundp = {}
	if plrnm == "all" then
		for _, v in pairs(players:GetPlayers()) do
			table.insert(foundp, v)
		end
	elseif plrnm == "others" then
		for _, v in pairs(players:GetPlayers()) do
			if v ~= p then
				table.insert(foundp, v)
			end
		end
	elseif plrnm == "me" then
		table.insert(foundp, p)
	elseif plrnm == "random" then
		local plrs = players:GetPlayers()
		table.insert(foundp, plrs[math.random(1, #plrs)])
	else
		for _, v in pairs(players:GetPlayers()) do
			if
				v.Name:lower():sub(1, #plrnm) == plrnm:lower()
				or v.DisplayName:lower():sub(1, #plrnm) == plrnm:lower()
			then
				table.insert(foundp, v)
			end
		end
	end
	return foundp
end
--local pg = p:WaitForChild("PlayerGui")
local psg = Instance.new("ScreenGui")
psg.Name = "kruelty"
psg.Parent = crg
psg.ResetOnSpawn = false
psg.DisplayOrder = 2147483647
local flinging = false
function Fling(part)
	local char = players.LocalPlayer.Character
	local hum = char:FindFirstChild("Humanoid")
	hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
	local hrp = char and char.PrimaryPart
	if not char or not hrp then
		return
	end
	local t = tick()
	flinging = true
	local originalCF = hrp.CFrame
	local originalSubject = workspace.CurrentCamera.CameraSubject
	local fallenparts = workspace.FallenPartsDestroyHeight
	workspace.FallenPartsDestroyHeight = 0 / 0

	local velhist = {}
	local accelhist = {}
	local yhist = {}
	local histsize = 4
	local expecteddt = 1 / math.max(60, 30)
	local lastvel = part.AssemblyLinearVelocity
	local lasttime = tick()
	local lasty = part.Position.Y
	local orghipheight = hum.HipHeight
	repeat
		local dtstart = tick()
		local curvel = part.AssemblyLinearVelocity
		local curtime = tick()
		local cury = part.Position.Y
		local dt = curtime - dtstart
		dt = math.clamp(dt, expecteddt * 0.5, expecteddt * 4)
		local accel = (curvel - lastvel) / math.max(curtime - lasttime, 0.001)
		local yvel = (cury - lasty) / math.max(curtime - lasttime, 0.001)

		table.insert(velhist, Vector3.new(curvel.X, 0, curvel.Z))
		if #velhist > histsize then
			table.remove(velhist, 1)
		end

		table.insert(accelhist, Vector3.new(accel.X, 0, accel.Z))
		if #accelhist > histsize then
			table.remove(accelhist, 1)
		end

		table.insert(yhist, yvel)
		if #yhist > histsize then
			table.remove(yhist, 1)
		end

		local avgvl = Vector3.zero
		for _, v in pairs(velhist) do
			avgvl += v
		end
		avgvl /= #velhist

		local avgaccel = Vector3.zero
		for _, a in pairs(accelhist) do
			avgaccel += a
		end
		avgaccel /= #accelhist

		local avgyvel = 0
		for _, y in pairs(yhist) do
			avgyvel += y
		end
		avgyvel /= #yhist

		local accelchange = (accel - avgaccel).Magnitude
		local isjumping = math.abs(avgyvel) > 8 or math.abs(yvel) > 12
		local ischangingdir = accelchange > 120

		local speed = avgvl.Magnitude
		local speedratio = speed / math.max(16, 0.1)

		local dynmin = math.clamp(0.18 + speedratio * 0.1, 0.18, 0.35)
		local dynmax = math.clamp(0.5 + speedratio * 0.25, 0.55, 1.0)
		local predmulti = math.clamp(speedratio, dynmin, dynmax)

		local lagoffset = math.max(dt - expecteddt, 0) * 3.5
		local pingcomp = lagoffset + dt * 1.8
		local lookahead = predmulti + pingcomp

		if isjumping then
			lookahead = lookahead * 1.4
			avgaccel = avgaccel * 0.6
		elseif ischangingdir then
			lookahead = lookahead * 0.5
			avgaccel = avgaccel * 0.3
		end

		local accelcomp = avgaccel * (lookahead * 0.45)
		local predictedvel = avgvl + accelcomp

		local targethalfh = part.Size.Y / 2
		local myhalfh = hrp.Size.Y / 2
		local yoffset = targethalfh - myhalfh

		if isjumping then
			yoffset = yoffset + (avgyvel * lookahead * 0.8)
		end

		local flatpos = (part.CFrame + (predictedvel * lookahead)).Position
		local predicted = CFrame.new(flatpos.X, part.Position.Y + yoffset, flatpos.Z)
		hum.HipHeight = hummhipheight or p.Character.Humanoid.HipHeight
		char:PivotTo(predicted * CFrame.Angles(math.rad(270), 0, 0))
		hrp.Velocity = -Vector3.new(1e35, 1e250, 1e35)
		hrp.RotVelocity = -Vector3.new(1e35, 1e30, 1e35)
		hrp.AssemblyLinearVelocity = -Vector3.new(0, 1e30, 0)
		hrp.AssemblyAngularVelocity = -Vector3.new(0, 1e100, 0) * 100
		workspace.CurrentCamera.CameraSubject = part

		lastvel = curvel
		lasttime = curtime
		lasty = cury

		task.wait()
	until part.AssemblyLinearVelocity.Magnitude > 150 or tick() - t > 4
	flinging = false
	hrp.Anchored = true
	task.wait()
	local ahhahaha
	ahhahaha = task.spawn(function()
		while true do
			hrp.CFrame = originalCF
			hrp.Velocity = Vector3.zero
			hrp.RotVelocity = Vector3.zero
			task.wait(0.01)
		end
	end)
	hrp.Anchored = false
	workspace.FallenPartsDestroyHeight = fallenparts
	workspace.CurrentCamera.CameraSubject = originalSubject
	task.wait(0.01)
	hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
	hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
	hum:ChangeState(Enum.HumanoidStateType.GettingUp)
	hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
	hum.HipHeight = orghipheight
	task.wait(1)
	task.cancel(ahhahaha)
end

local FLYING = false
local flyKeyDown, flyKeyUp
local cmds = {}
local hum = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
local function aui(el, crd)
	local uic = Instance.new("UICorner")
	uic.Parent = el
	uic.CornerRadius = UDim.new(0, crd)
end
local function aust(el, color, thick)
	local s = Instance.new("UIStroke")
	s.Color = color
	s.Thickness = thick
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = el
end
local notifholderpsg = Instance.new("ScreenGui")
notifholderpsg.Name = "notifholder"
notifholderpsg.Parent = cloneref(game:GetService("CoreGui"))
notifholderpsg.ResetOnSpawn = false
notifholderpsg.DisplayOrder = 2147483647
local notifholder = Instance.new("Frame")
notifholder.Name = "notifholderr"
notifholder.Parent = notifholderpsg
notifholder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
notifholder.Size = UDim2.new(0.2, 0, 1, 0)
notifholder.Position = UDim2.new(0.8, 0, 0, 0)
notifholder.BackgroundTransparency = 1
local ull = Instance.new("UIListLayout")
ull.Name = "ull"
ull.Parent = notifholder
ull.SortOrder = Enum.SortOrder.LayoutOrder
ull.HorizontalAlignment = Enum.HorizontalAlignment.Right
ull.Padding = UDim.new(0, 10)
ull.VerticalAlignment = Enum.VerticalAlignment.Bottom
local padding = Instance.new("UIPadding")
padding.Name = "padding"
padding.Parent = notifholder
padding.PaddingTop = UDim.new(0, 10)
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingRight = UDim.new(0, 10)
padding.PaddingBottom = UDim.new(0, 10)
function aui(obj, rad)
	local uic = Instance.new("UICorner")
	uic.Parent = obj
	uic.CornerRadius = UDim.new(0, rad)
end
local notis = 0
local function notif(title, text, delay) -- no idea how i made it this good 🤣
	if not title or not text then
		return
	end
	notis = notis + 1
	local isnotifying = true
	local tick = os.clock()
	local container = Instance.new("Frame")
	local noticount = notifholder:GetChildren()
	local tiiii = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	if #noticount > 9 then
		local oldest = noticount[1]
		ts:Create(oldest, tiiii, { BackgroundTransparency = 1 }):Play()
		task.delay(0.25, function()
			oldest:Destroy()
		end)
	end
	container.Name = "notif_container"
	container.Parent = notifholder
	container.LayoutOrder = -notis
	container.BackgroundTransparency = 1
	container.Size = UDim2.new(0, 300, 0, 0)
	container.AutomaticSize = Enum.AutomaticSize.Y
	container.ZIndex = 1
	local notifbox = Instance.new("Frame")
	notifbox.Name = "notifbox"
	notifbox.Parent = container
	notifbox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	notifbox.BorderSizePixel = 0
	notifbox.Position = UDim2.new(0, 300, 0, 0)
	notifbox.Size = UDim2.new(0, 300, 0, 0)
	notifbox.AutomaticSize = Enum.AutomaticSize.Y
	notifbox.ZIndex = 2
	aui(notifbox, 12)
	local timeleft = Instance.new("TextLabel")
	timeleft.Name = "timeleft"
	timeleft.Parent = notifbox
	timeleft.BackgroundTransparency = 1
	timeleft.Size = UDim2.new(0, 50, 0, 20)
	timeleft.Position = UDim2.new(1, -50, 0, 0)
	timeleft.Text = string.format("%.2fs", delay)
	timeleft.TextColor3 = Color3.fromRGB(150, 150, 150)
	timeleft.TextSize = 12
	timeleft.Font = Enum.Font.Code
	timeleft.TextXAlignment = Enum.TextXAlignment.Right
	timeleft.ZIndex = 3
	local pad = Instance.new("UIPadding")
	pad.Parent = notifbox
	pad.PaddingTop = UDim.new(0, 10)
	pad.PaddingBottom = UDim.new(0, 20)
	pad.PaddingRight = UDim.new(0, 10)
	pad.PaddingLeft = UDim.new(0, 10)
	local uistroke = Instance.new("UIStroke")
	uistroke.Parent = notifbox
	uistroke.Thickness = 3.5
	uistroke.Color = Color3.fromRGB(255, 255, 255)
	uistroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	local grad = Instance.new("UIGradient")
	grad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 75, 75)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(215, 215, 215)),
	})
	grad.Parent = uistroke
	local notiftitle = Instance.new("TextLabel")
	notiftitle.Name = "notiftitle"
	notiftitle.Parent = notifbox
	notiftitle.BackgroundTransparency = 1
	notiftitle.Size = UDim2.new(1, 0, 0, 25)
	notiftitle.Text = title
	notiftitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	notiftitle.TextSize = 18
	notiftitle.Font = Enum.Font.BuilderSansBold
	notiftitle.TextXAlignment = Enum.TextXAlignment.Left
	notiftitle.ZIndex = 2
	local notiftext = Instance.new("TextLabel")
	notiftext.Name = "notiftext"
	notiftext.Parent = notifbox
	notiftext.BackgroundTransparency = 1
	notiftext.Position = UDim2.new(0, 0, 0, 30)
	notiftext.Size = UDim2.new(1, 0, 0, 0)
	notiftext.AutomaticSize = Enum.AutomaticSize.Y
	notiftext.Text = text
	notiftext.TextColor3 = Color3.fromRGB(200, 200, 200)
	notiftext.TextSize = 15
	notiftext.TextWrapped = true
	notiftext.Font = Enum.Font.BuilderSansMedium
	notiftext.TextXAlignment = Enum.TextXAlignment.Left
	notiftext.ZIndex = 2
	notiftext.RichText = true
	local notifline = Instance.new("Frame")
	notifline.Name = "notifline"
	notifline.Parent = notifbox
	notifline.BackgroundColor3 = Color3.fromRGB(40, 70, 200)
	notifline.BorderSizePixel = 0
	notifline.Size = UDim2.new(1, 0, 0, 4)
	notifline.Position = UDim2.new(0, 0, 1, 10)
	notifline.AnchorPoint = Vector2.new(0, 1)
	notifline.ZIndex = 3
	aui(notifline, 8)
	local notifline2 = Instance.new("Frame")
	notifline2.Name = "notifline2"
	notifline2.Parent = notifbox
	notifline2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	notifline2.BorderSizePixel = 0
	notifline2.Size = UDim2.new(1, 0, 0, 4)
	notifline2.Position = UDim2.new(0, 0, 1, 10)
	notifline2.AnchorPoint = Vector2.new(0, 1)
	notifline2.ZIndex = 2
	aui(notifline2, 8)
	local rs = cloneref(game:GetService("RunService"))
	local taskfunction = task.spawn(function()
		while isnotifying do
			local elapsed = os.clock() - tick
			local remaining = math.max(0, delay - elapsed)

			timeleft.Text = "Click to dismiss " .. string.format("%.2fs", remaining)

			if remaining <= 0 then
				break
			end
			task.wait()
		end
	end)
	local ts = cloneref(game:GetService("TweenService"))
	local tii = TweenInfo.new(delay, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tiii = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local clickconn = nil
	clickconn = notifbox.InputBegan:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			isnotifying = false
			local currenty = notifbox.Position.Y.Offset
			ts:Create(notifbox, tiiii, {
				Position = UDim2.new(1.5, 0, 0, currenty),
			}):Play()
			task.wait(0.15)
			container.Size = UDim2.new(0, 300, 0, container.AbsoluteSize.Y)
			container.AutomaticSize = Enum.AutomaticSize.None
			ts:Create(container, ti, { Size = UDim2.new(0, 300, 0, 0) }):Play()
			task.wait(0.2)
			container:Destroy()
			task.cancel(taskfunction)
			clickconn:Disconnect()
		end
		return
	end)
	task.spawn(function()
		ts:Create(notifbox, ti, { Position = UDim2.new(0, -35, 0, 0) }):Play()
		task.wait(0.2)
		ts:Create(notifbox, tiii, { Position = UDim2.new(0, 25, 0, 0) }):Play()
		task.wait(0.2)
		ts:Create(notifbox, tiiii, { Position = UDim2.new(0, 0, 0, 0) }):Play()
	end)
	local ftw = ts:Create(notifline, tii, { Size = UDim2.new(0, 0, 0, 4) })
	if not isnotifying then
		return
	end
	task.spawn(function()
		if not isnotifying then
			return
		end
		ftw:Play()
		ftw.Completed:Wait()
		if not isnotifying then
			return
		end
		local currenty = notifbox.Position.Y.Offset
		ts:Create(notifbox, tiiii, {
			Position = UDim2.new(1.5, 0, 0, currenty),
		}):Play()
		task.wait(0.15)
		container.Size = UDim2.new(0, 300, 0, container.AbsoluteSize.Y)
		container.AutomaticSize = Enum.AutomaticSize.None
		ts:Create(container, tiii, { Size = UDim2.new(0, 300, 0, 0) }):Play()
		task.wait(0.2)
		if not isnotifying then
			return
		end
		container:Destroy()
		task.cancel(taskfunction)
		isnotifying = false
		clickconn:Disconnect()
	end)
end
local function getroot(plr)
	local char = plr.Character
	if not char then
		return
	end
	local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
	if not root then
		return
	end
	return root
end
local function exec(cmd) -- easier then i thought
	local args = string.split(cmd, " ")
	local cmdnm = table.remove(args, 1):lower()
	if cmds[cmdnm] then
		task.spawn(function()
			cmds[cmdnm]["Function"](args)
		end)
	end
end
local fr = Instance.new("Frame")
fr.Size = UDim2.new(0, 250, 0, 345)
fr.Position = UDim2.new(0, 0, 0.77, 0)
fr.BackgroundColor3 = theme.Main
fr.Parent = psg
fr.ClipsDescendants = true
aui(fr, 7)
local onsfr = Instance.new("Frame")
onsfr.Size = UDim2.new(0, 250, 0, 320)
onsfr.Position = UDim2.new(0, 0, 0, 20)
onsfr.Parent = fr
onsfr.BackgroundTransparency = 0
onsfr.BackgroundColor3 = theme.Main
onsfr.ZIndex = 5
onsfr.Visible = true
onsfr.ClipsDescendants = true
local logo = Instance.new("ImageLabel")
logo.Name = "KruelIcon"
logo.BackgroundTransparency = 1
logo.Position = UDim2.new(0.25, 0, 0.25, 0)
logo.ZIndex = 12
logo.Size = UDim2.new(0, 126, 0, 126)
logo.Image = "rbxassetid://130500547668668"
logo.Parent = onsfr
local mlogo = Instance.new("ImageLabel")
mlogo.Name = "KruelIcon"
mlogo.BackgroundTransparency = 1
mlogo.Position = UDim2.new(0.025, 0, 0, 0)
mlogo.ZIndex = 12
mlogo.Size = UDim2.new(0, 20, 0, 20)
mlogo.Image = "rbxassetid://130500547668668"
mlogo.Parent = fr
ts:Create(onsfr, ti, { BackgroundTransparency = 1 }):Play()
ts:Create(logo, ti, { ImageTransparency = 1 }):Play()
task.spawn(function()
	task.wait(0.8)
	onsfr.Visible = false
	ts:Create(fr, tii, { Position = UDim2.new(0, 0, 0.985, 0) }):Play()
	fr.MouseEnter:Connect(function()
		ts:Create(fr, tii, { Position = UDim2.new(0, 0, 0.77, 0) }):Play()
	end)
	fr.MouseLeave:Connect(function()
		if typing == true then
			return
		end
		ts:Create(fr, tii, { Position = UDim2.new(0, fr.Position.X.Offset, 0.985, 0) }):Play()
	end)
	fr.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			ts:Create(fr, tii, { Position = UDim2.new(0, 0, 0.77, 0) }):Play()
		end
	end)
	fr.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch then
			ts:Create(fr, tii, { Position = UDim2.new(0, fr.Position.X.Offset, 0.985, 0) }):Play()
		end
	end)
end)
local drg = Instance.new("TextLabel")
drg.BackgroundColor3 = theme.Title
drg.Size = UDim2.new(0, 250, 0, 20)
drg.BorderSizePixel = 0
drg.Text = "Kruel - " .. version
drg.TextColor3 = theme.Text
drg.Font = Enum.Font.GothamBold
drg.ZIndex = 6
drg.TextSize = 16
drg.Parent = fr
local drg2 = Instance.new("Frame")
drg2.BackgroundColor3 = theme.Title
drg2.Position = UDim2.new(0, 0, 0, 10)
drg2.Size = UDim2.new(0, 250, 0, 10)
drg2.BorderSizePixel = 0
drg2.Parent = fr
drg2.ZIndex = 5
aui(drg, 7)
local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, theme.Title),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(215, 215, 215)),
})
grad.Parent = drg
local grad2 = Instance.new("UIGradient")
grad2.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, theme.Title),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(215, 215, 215)),
})
grad2.Parent = drg2
local uis = cloneref(game:GetService("UserInputService"))
-- lowk dog for not making mobile support idk if it works or not but idgaf about delta skids
if uis.TouchEnabled and not uis.KeyboardEnabled then
	task.delay(5, function()
		notif(
			"Kruel",
			"Please use the chat in order to execute commands, prefix is ';', as touch devices are not fully supported.",
			10
		)
	end)
end
local sfr = Instance.new("ScrollingFrame")
sfr.Size = UDim2.new(0, 235, 0, 300)
sfr.BorderSizePixel = 0
sfr.BackgroundColor3 = theme.Secondary
sfr.Position = UDim2.new(0, 10, 0, 40)
sfr.ClipsDescendants = true
sfr.CanvasSize = UDim2.new(0, 0, 0, 0)
sfr.ScrollBarThickness = 0
sfr.AutomaticCanvasSize = Enum.AutomaticSize.Y
sfr.Parent = fr
local inp = Instance.new("TextBox")
inp.Name = "cmdbar"
inp.Size = UDim2.new(0, 235, 0, 20)
inp.Position = UDim2.new(0, 10, 0, 25)
inp.BackgroundColor3 = theme.Secondary
inp.TextColor3 = theme.Text
inp.Text = ""
inp.Font = Enum.Font.Gotham
inp.TextSize = 14
inp.ClearTextOnFocus = false
inp.BorderSizePixel = 0
inp.TextXAlignment = Enum.TextXAlignment.Left
inp.TextWrapped = true
inp.TextYAlignment = Enum.TextYAlignment.Top
inp.Parent = fr
inp.PlaceholderText = "Enter a command here. :3"
local ghostinp = Instance.new("TextLabel")
ghostinp.Name = "ghostcmd"
ghostinp.Size = UDim2.new(0, 235, 0, 20)
ghostinp.BackgroundTransparency = 1
ghostinp.Position = UDim2.new(0, 10, 0, 25)
ghostinp.BackgroundColor3 = theme.Secondary
ghostinp.TextColor3 = theme.Text
ghostinp.Text = ""
ghostinp.Font = Enum.Font.Gotham
ghostinp.TextSize = 14
ghostinp.TextTransparency = 0.5
ghostinp.BorderSizePixel = 0
ghostinp.TextXAlignment = Enum.TextXAlignment.Left
ghostinp.TextWrapped = true
ghostinp.TextYAlignment = Enum.TextYAlignment.Top
ghostinp.Parent = fr
local firstmatchName = nil
inp.FocusLost:Connect(function(enterPressed)
	typing = false
	ts:Create(fr, tii, { Position = UDim2.new(0, fr.Position.X.Offset, 0.985, 0) }):Play()
	if enterPressed and inp.Text ~= "" and inp.Text ~= " " then
		exec(inp.Text)
	end
	inp.Text = ""
	if firstmatchName then
		firstmatchName = nil
	end
end)
inp:GetPropertyChangedSignal("Text"):Connect(function()
	typing = true
	if inp.Text:find("\t") then
		inp.Text = inp.Text:gsub("\t", "")
		return
	end
	local stext = inp.Text:lower()
	firstmatchName = nil
	if stext == "" then
		ghostinp.Text = ""
		for _, data in pairs(cmds) do
			data.Button.Visible = true
		end
		return
	end
	for alias, data in pairs(cmds) do
		if alias:lower():sub(1, #stext) == stext then
			data.Button.Visible = true
			if not firstmatchName then
				firstmatchName = alias
			end
		else
			data.Button.Visible = false
		end
	end

	if firstmatchName ~= nil then
		ghostinp.Text = firstmatchName
	end
	if not firstmatchName then
		ghostinp.Text = ""
	end
	if string.find(inp.Text, " ") then
		ghostinp.Text = ""
	end
end)
uis.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Tab then
		if firstmatchName then
			task.defer(function()
				inp.Text = firstmatchName
				inp.CursorPosition = #inp.Text + 1
				ghostinp.Text = ""
			end)
		end
	end
end)
local pad = Instance.new("UIPadding")
pad.PaddingTop = UDim.new(0, 5)
pad.PaddingLeft = UDim.new(0, 5)
pad.PaddingRight = UDim.new(0, 5)
pad.PaddingBottom = UDim.new(0, 5)
pad.Parent = sfr
local list = Instance.new("UIListLayout")
list.Parent = sfr
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Padding = UDim.new(0, 5)
local rs = cloneref(game:GetService("RunService"))
local mousehovering = false
local uis = cloneref(game:GetService("UserInputService"))
local mouseconn = nil
local mousep = uis:GetMouseLocation()
tooltip = Instance.new("Frame")
tooltip.Size = UDim2.new(0, 200, 0, 0)
tooltip.Position = UDim2.new(0, mousep.X, 0.025, mousep.Y)
tooltip.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
tooltip.BorderSizePixel = 0
tooltip.AutomaticSize = Enum.AutomaticSize.Y
tooltip.ZIndex = 10000
tooltip.Visible = false
tooltip.Parent = psg
local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 4)
padding.PaddingLeft = UDim.new(0, 4)
padding.PaddingRight = UDim.new(0, 4)
padding.PaddingBottom = UDim.new(0, 4)
padding.Parent = tooltip
local constraint = Instance.new("UISizeConstraint")
constraint.MaxSize = Vector2.new(250, 500)
constraint.Parent = tooltip
local description = Instance.new("TextLabel")
description.Size = UDim2.new(1, 0, 0, 0)
description.Text = ""
description.AutomaticSize = Enum.AutomaticSize.Y
description.ZIndex = 123123123
description.TextColor3 = theme.Text
description.Font = Enum.Font.Gotham
description.TextSize = 14
description.TextWrapped = true
description.BackgroundTransparency = 1
description.TextXAlignment = Enum.TextXAlignment.Left
description.TextYAlignment = Enum.TextYAlignment.Top
description.Parent = tooltip
local constraint2 = Instance.new("UISizeConstraint")
constraint2.MaxSize = Vector2.new(250, 500)
constraint2.Parent = description
local cmdcount = 0
aust(tooltip, Color3.fromRGB(165, 165, 165), 0.8)
local function addcmd(names, desc, func)
	task.spawn(function()
		if type(names) == "string" then
			names = { names }
		end
		local displaynms = table.concat(names, " / ")

		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 15)
		cmdcount += 1
		local name = names[1]
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 15)
		btn.TextColor3 = Color3.fromRGB(15, 15, 15)
		btn.Font = Enum.Font.Gotham
		btn.Text = "   " .. displaynms
		btn.TextSize = 14
		btn.BackgroundTransparency = 0
		btn.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
		btn.TextXAlignment = Enum.TextXAlignment.Left
		btn.Parent = sfr
		aust(btn, Color3.fromRGB(121, 121, 121), 0.8)
		local grad = Instance.new("UIGradient")
		grad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200)),
			ColorSequenceKeypoint.new(1, theme.Title),
		})
		grad.Rotation = 90
		grad.Parent = btn
		for _, name in pairs(names) do
			cmds[name:lower()] = { ["Description"] = desc, ["Function"] = func, ["Button"] = btn }
		end
		btn.MouseButton1Click:Connect(function()
			func({})
		end)
		btn.MouseEnter:Connect(function()
			mousehovering = true
			description.Visible = true
			description.Text = desc
			if mouseconn then
				mouseconn:Disconnect()
			end
			tooltip.Visible = true
			mouseconn = rs.RenderStepped:Connect(function()
				local mousep = uis:GetMouseLocation()
				description.Visible = true
				tooltip.Position = UDim2.fromOffset(mousep.X + 5, mousep.Y + -32)
			end)
		end)
		btn.MouseLeave:Connect(function()
			mouseconn:Disconnect()
			description.Visible = false
			tooltip.Visible = false
		end)
	end)
end
-- woohoo commands!
addcmd("discord", "Join the TCS Discord server!", function()
	setclipboard("https://discord.gg/vvvy4Q8uaK")
	notif("Kruel", "Discord invite link copied to clipboard!", 3)
end)
local noclipping = false
local infjumping = false
uis.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	if crg:FindFirstChildOfClass("TextBox") and crg:FindFirstChildOfClass("TextBox"):IsFocused() then
		return
	end
	if input.KeyCode == Enum.KeyCode.Semicolon then
		typing = true
		ts:Create(fr, tii, { Position = UDim2.new(0, fr.Position.X.Offset, 0.77, 0) }):Play()
		task.wait()
		inp:CaptureFocus()
	end
end)
addcmd("shiftlock", "Enables/disables Shiftlock.", function()
	players.LocalPlayer.DevEnableMouseLock = not players.LocalPlayer.DevEnableMouseLock
end)
addcmd("speed", "Adjusts WalkSpeed.", function(args)
	local speed = tonumber(args[1])
	if p.Character and p.Character.Humanoid then
		p.Character.Humanoid.WalkSpeed = speed
	end
end)
local flyIsActive = false
local kruelflyspeed = 20
local function grt(char)
	return char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
end
function sFLY()
	local char = p.Character or p.CharacterAdded:Wait()
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	local T = grt(char)
	if flyKeyDown then
		flyKeyDown:Disconnect()
	end
	if flyKeyUp then
		flyKeyUp:Disconnect()
	end

	local CONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
	local SPEED = 0

	local function updateHeldKeys()
		CONTROL.F = uis:IsKeyDown(Enum.KeyCode.W) and kruelflyspeed or 0
		CONTROL.B = uis:IsKeyDown(Enum.KeyCode.S) and -kruelflyspeed or 0
		CONTROL.L = uis:IsKeyDown(Enum.KeyCode.A) and -kruelflyspeed or 0
		CONTROL.R = uis:IsKeyDown(Enum.KeyCode.D) and kruelflyspeed or 0
		CONTROL.Q = uis:IsKeyDown(Enum.KeyCode.LeftControl) and -kruelflyspeed * 2 or 0
		CONTROL.E = uis:IsKeyDown(Enum.KeyCode.Space) and kruelflyspeed * 2 or 0
	end

	local function FLY()
		local BG = Instance.new("BodyGyro", T)
		local BV = Instance.new("BodyVelocity", T)

		BG.P = 9e4
		BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.CFrame = T.CFrame

		BV.Velocity = Vector3.new(0, 0, 0)
		BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)

		task.spawn(function()
			repeat
				task.wait()
				if humanoid then
					humanoid.PlatformStand = true
				end
				updateHeldKeys()

				local camera = workspace.CurrentCamera
				if (CONTROL.L + CONTROL.R ~= 0) or (CONTROL.F + CONTROL.B ~= 0) or (CONTROL.Q + CONTROL.E ~= 0) then
					SPEED = 50
				else
					SPEED = 0
				end
				BV.Velocity = (
					(camera.CFrame.LookVector * (CONTROL.F + CONTROL.B))
					+ (
						(
							camera.CFrame
							* CFrame.new(
								CONTROL.L + CONTROL.R,
								(CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2,
								0
							).p
						) - camera.CFrame.p
					)
				) * SPEED
				BG.CFrame = camera.CFrame
			until not FLYING

			BG:Destroy()
			BV:Destroy()
			if humanoid then
				humanoid.PlatformStand = false
			end
		end)
	end

	flyKeyDown = uis.InputBegan:Connect(function(input, gpe)
		if not gpe then
			updateHeldKeys()
		end
	end)
	flyKeyUp = uis.InputEnded:Connect(function(input, gpe)
		if not gpe then
			updateHeldKeys()
		end
	end)

	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown then
		flyKeyDown:Disconnect()
	end
	if flyKeyUp then
		flyKeyUp:Disconnect()
	end
	local char = players.LocalPlayer.Character
	if char and char:FindFirstChildOfClass("Humanoid") then
		char:FindFirstChildOfClass("Humanoid").PlatformStand = false
	end
	pcall(function()
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	end)
end
addcmd("fly", "Lets you fly.", function(args)
	FLYING = not FLYING
	kruelflyspeed = tonumber(args[1]) or 2
	if FLYING then
		sFLY(false)
	end
end)
p.Chatted:Connect(function(msg)
	if msg:sub(1, 1) == ";" and #msg > 1 then
		local full = msg:sub(2)
		local args = string.split(full, " ")
		local cmdnm = table.remove(args, 1):lower()
		if cmds[cmdnm] then
			local succ, err = pcall(function()
				cmds[cmdnm]["Function"](args)
			end)
			if not succ then
				notif("Kruel", "Error.", 3)
			end
		end
	end
end)
local flung = {}

addcmd("fling", "Flings anyone you want, if the game has no anti-fling.", function(args)
	local vctms = findplr(args[1])

	if #vctms == 0 then
		notif("Kruel", "Player not found.", 3)
		return
	end

	for _, trgt in pairs(vctms) do
		if trgt ~= p and not flung[trgt] then
			local char = trgt.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")

			if hrp and hrp.Velocity.Magnitude < 250 then
				flung[trgt] = true

				task.spawn(function()
					while flinging do
						task.wait()
					end
					Fling(hrp)
					workspace.CurrentCamera.CameraSubject = p.Character.Humanoid
					flung[trgt] = nil
				end)
			end
		end
	end
end)
local flingauraconn = nil
local flingauraplayrs = {}
local flingaurarange = 15

addcmd("flingaura", "Fling anyone around you.", function()
	if flingauraconn then
		flingauraconn:Disconnect()
	end
	flingauraconn = rs.Heartbeat:Connect(function()
		if flinging then
			return
		end
		for i, v in pairs(players:GetPlayers()) do
			if v ~= p and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = v.Character.HumanoidRootPart
				local dist = (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude
				if dist < flingaurarange and not flingauraplayrs[v.UserId] then
					flingauraplayrs[v.UserId] = true
					task.spawn(function()
						exec("fling " .. v.Name)
						while flinging do
							task.wait()
						end
						task.wait(1)
						flingauraplayrs[v.UserId] = nil
					end)
					return
				end
			end
		end
	end)
end)

addcmd("flingaurarange", "Changes the range of flingaura.", function(args)
	flingaurarange = tonumber(args[1]) or 15
end)

addcmd("unflingaura", "Stops flingaura.", function()
	if flingauraconn then
		flingauraconn:Disconnect()
		flingauraconn = nil
	end
	flingauraplayrs = {}
end)

local whitelists = {}

addcmd({ "whitelist", "wl", "admin" }, "Lets anyone use your commands.", function(args)
	local full = table.concat(args, " ")
	local parsed = {}
	local current = ""
	local inQuotes = false

	for i = 1, #full do
		local c = full:sub(i, i)

		if c == '"' then
			inQuotes = not inQuotes
		elseif c == " " and not inQuotes then
			if #current > 0 then
				table.insert(parsed, current)
				current = ""
			end
		else
			current ..= c
		end
	end

	if #current > 0 then
		table.insert(parsed, current)
	end
	local victims = findplr(parsed[1])
	if not victims or not victims[1] then
		return
	end
	local target = victims[1]
	if whitelists[target] then
		return
	end
	notif("Kruel", "Whitelisted " .. target.Name, 3)
	whitelists[target] = target.Chatted:Connect(function(msg)
		if msg:sub(1, 1) == ";" and #msg > 1 then
			exec(msg:sub(2))
		end
	end)
end)
addcmd({ "unwhitelist", "unwl", "unadmin" }, "Stops anyone from using your commands.", function(args)
	local victims = findplr(args[1])
	if not victims or not victims[1] then
		return
	end
	local target = victims[1]
	if not whitelists[target] then
		return
	end
	notif("Kruel", "Unwhitelisted " .. target.Name, 3)
	whitelists[target]:Disconnect()
	whitelists[target] = nil
end)
addcmd({ "copycmds", "copycommands" }, "Copies all commands to clipboard.", function()
	local list = "Kruel Command List:\n\n"
	local seen = {}

	for cmdName, data in pairs(cmds) do
		local desc = data.Description
		if not seen[data.Function] then
			list = list .. "" .. cmdName .. " - " .. desc .. "\n"
			seen[data.Function] = true
		end
	end

	setclipboard(list .. "\nKruel remake - a project made with love by Corrupted_VR.\n\nTotal commands: " .. cmdcount)
end)
addcmd("goto", "Go to anyone.", function(args)
	local vctms = findplr(args[1])
	local trgt = vctms[1]
	if trgt and trgt.Character and trgt.Character.HumanoidRootPart and p.Character and p.Character.HumanoidRootPart then
		local hrp = p.Character.HumanoidRootPart
		hrp.Velocity = Vector3.zero
		hrp.RotVelocity = Vector3.zero
		hrp.AssemblyLinearVelocity = Vector3.zero
		hrp.AssemblyAngularVelocity = Vector3.zero
		p.Character.HumanoidRootPart.CFrame = trgt.Character.HumanoidRootPart.CFrame
	elseif not trgt then
		notif("Kruel", "Player not found.", 3)
	end
end)
local loopgotoconn = nil
addcmd("loopgoto", "Loops goto.", function(args)
	local vctms = findplr(args[1])
	local trgt = vctms[1]
	if trgt and trgt.Character and trgt.Character.HumanoidRootPart and p.Character and p.Character.HumanoidRootPart then
		-- Initialize prediction variables
		local velhist = {}
		local accelhist = {}
		local histsize = 4
		local hum = trgt.Character.Humanoid
		local expecteddt = 1 / math.max(getfpscap(), 30)
		local lastvel = trgt.Character.HumanoidRootPart.AssemblyLinearVelocity
		local lasttime = tick()

		loopgotoconn = rs.Heartbeat:Connect(function()
			if
				trgt.Character
				and trgt.Character:FindFirstChild("HumanoidRootPart")
				and p.Character
				and p.Character:FindFirstChild("HumanoidRootPart")
			then
				local dtstart = tick()
				local targethrp = trgt.Character.HumanoidRootPart
				local myhrp = p.Character.HumanoidRootPart

				-- Calculate prediction
				local dt = tick() - dtstart
				dt = math.clamp(dt, expecteddt * 0.5, expecteddt * 4)

				local curvel = targethrp.AssemblyLinearVelocity
				local curtime = tick()
				local accel = (curvel - lastvel) / math.max(curtime - lasttime, 0.001)

				table.insert(velhist, Vector3.new(curvel.X, curvel.Y, curvel.Z))
				if #velhist > histsize then
					table.remove(velhist, 1)
				end

				table.insert(accelhist, Vector3.new(accel.X, accel.Y, accel.Z))
				if #accelhist > histsize then
					table.remove(accelhist, 1)
				end

				local avgvl = Vector3.zero
				for _, v in pairs(velhist) do
					avgvl += v
				end
				avgvl /= #velhist

				local avgaccel = Vector3.zero
				for _, a in pairs(accelhist) do
					avgaccel += a
				end
				avgaccel /= #accelhist

				local speed = avgvl.Magnitude
				local walkspeed = hum.WalkSpeed
				local speedratio = speed / math.max(walkspeed, 0.1)

				local basepredmin = 0.05
				local basepredmax = 0.15
				local speedinfluence = 0.03
				local maxspeedinfluence = 0.08

				local dynmin =
					math.clamp(basepredmin + speedratio * speedinfluence, basepredmin, basepredmin + speedinfluence * 2)
				local dynmax = math.clamp(
					basepredmax + speedratio * maxspeedinfluence,
					basepredmax + maxspeedinfluence * 0.5,
					basepredmax + maxspeedinfluence * 2
				)
				local predmulti = math.clamp(speedratio, dynmin, dynmax)

				local lagmultiplier = 1.5
				local pingmultiplier = 0.8
				local lagoffset = math.max(dt - expecteddt, 0) * lagmultiplier
				local pingcomp = lagoffset + dt * pingmultiplier
				local lookahead = predmulti + pingcomp

				local accelweight = 0.25
				local accelcomp = avgaccel * (lookahead * accelweight)
				local predictedvel = avgvl + accelcomp

				-- Apply prediction (horizontal only, keep original Y position)
				local predictedpos = targethrp.Position + (predictedvel * lookahead)
				local predicted = CFrame.new(predictedpos.X, targethrp.Position.Y, predictedpos.Z)
					* (targethrp.CFrame - targethrp.CFrame.Position)

				myhrp.CFrame = predicted
				myhrp.Velocity = Vector3.new(0, 0, 0)
				myhrp.RotVelocity = Vector3.new(0, 0, 0)

				lastvel = curvel
				lasttime = curtime
			else
				if loopgotoconn then
					loopgotoconn:Disconnect()
				end
			end
		end)
	end
end)
addcmd("unloopgoto", "Stops loop goto.", function()
	if loopgotoconn then
		loopgotoconn:Disconnect()
	end
end)
addcmd({ "tpto", "gotopos", "pos" }, "Teleports to coordinates (Usage: ;tpto X, Y, Z)", function(args)
	local coords = string.gsub(args[1], ",", "")
	local coords1 = string.gsub(args[2], ",", "")
	local coords2 = string.gsub(args[3], ",", "")
	local x, y, z = tonumber(coords), tonumber(coords1), tonumber(coords2)
	if x and y and z and p.Character and p.Character.HumanoidRootPart then
		p.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
	end
end)
addcmd("unfly", "Stop flying", function()
	if not FLYING then
		return
	end
	FLYING = false
	NOFLY()
	if FLYING then
		notif("Kruel", "You are not flying.", 3)
	end
end)
addcmd("notify", "Notifies you.", function(args)
	local title = args[1]
	local text = args[2]
	local duration = tonumber(args[3])
	notif((title or "No title provided."), (text or "No text provided."), (duration or 3))
end)
addcmd({ "reset", "re" }, "Resets character.", function()
	if p.Character and p.Character.Head then
		p.Character.Head:Destroy()
		task.wait(0.15)
		if p.Character.Head then
			p.Character.Humanoid.Health = 0
		end
	end
end)
addcmd("infjump", "Lets you jump infinitely.", function()
	infjumping = true
	uis.JumpRequest:Connect(function()
		p.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end)
end)
local function r15()
	if p.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R15 then
		return true
	end
end
addcmd("jerk", "I'm jorkin it", function()
	local humanoid = p.Character:FindFirstChildWhichIsA("Humanoid")
	local backpack = p:FindFirstChildWhichIsA("Backpack")
	if not humanoid or not backpack then
		return
	end

	local tool = Instance.new("Tool")
	tool.Name = "goon. my guy."
	tool.RequiresHandle = false
	tool.Parent = backpack

	local jorkin = false
	local track = nil

	local function stopjorkinit()
		jorkin = false
		if track then
			track:Stop()
			track = nil
		end
	end

	tool.Equipped:Connect(function()
		jorkin = true
	end)
	tool.Unequipped:Connect(stopjorkinit)
	humanoid.Died:Connect(stopjorkinit)

	while task.wait() do
		if not jorkin then
			continue
		end

		if not track then
			local anim = Instance.new("Animation")
			anim.AnimationId = not r15() and "rbxassetid://72042024" or "rbxassetid://698251653"
			track = humanoid:LoadAnimation(anim)
		end

		track:Play()
		track:AdjustSpeed(r15() and 0.7 or 0.65)
		track.TimePosition = 0.6
		task.wait(0.1)
		while track and track.TimePosition < (not r15() and 0.65 or 0.7) do
			task.wait(0.1)
		end
		if track then
			track:Stop()
			track = nil
		end
	end
end)
addcmd("uninfjump", "Stops infinite jumping.", function()
	if infjumping == false then
		notif("Kruel", "You are not currently infinite jumping.", 3)
	else
		infjumping = false
	end
end)
addcmd("antitrip", "Prevents you from tripping.", function()
	local hum = p.Character.Humanoid
	hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	exec("antisit")
end)
addcmd("unantitrip", "Stops antitrip.", function()
	local hum = p.Character.Humanoid
	hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
	hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
	exec("unantisit")
end)
local spinflinging = false
local spinflingdied = nil
local bav = nil
local zzzz, haha = nil, nil
addcmd("spinfling", "Flings people by spinning very fast.", function()
	spinflinging = false
	for _, child in pairs(p.Character:GetDescendants()) do
		if child:IsA("BasePart") then
			child.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
		end
	end
	exec("noclip")
	task.wait(0.1)
	zzzz = Instance.new("BodyAngularVelocity")
	zzzz.Parent = p.Character.HumanoidRootPart
	zzzz.AngularVelocity = Vector3.new(0, 99999, 0)
	zzzz.MaxTorque = Vector3.new(0, math.huge, 0)
	zzzz.P = math.huge
	local char = p.Character:GetChildren()
	for i, v in next, char do
		if v:IsA("BasePart") then
			v.CanCollide = false
			v.Massless = true
			v.Velocity = Vector3.zero
		end
	end
	spinflinging = true
	spinflingdied = p.Character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
		exec("unspinfling")
	end)
	haha = task.spawn(function()
		repeat
			zzzz.AngularVelocity = Vector3.new(0, 999995, 0)
			task.wait(0.2)
			zzzz.AngularVelocity = Vector3.new(0, 0, 0)
			task.wait(0.1)
		until spinflinging == false
	end)
end)
addcmd("unspinfling", "Stops spinfling.", function()
	spinflinging = false
	exec("clip")
	if spinflingdied then
		spinflingdied:Disconnect()
	end
	if zzzz then
		zzzz:Destroy()
	end
end)
local flashbackpos = nil
local flashbackdied = nil
local autoflashback = false
p.CharacterAdded:Connect(function(char)
	if autoflashback and flashbackpos then
		task.spawn(function()
			local hrp = char:WaitForChild("HumanoidRootPart", 5)
			if hrp then
				task.wait(0.2)
				for i = 1, 25 do
					hrp.CFrame = flashbackpos
					task.wait(0.01)
				end
			end
		end)
	end

	local humm = char:WaitForChild("Humanoid")
	if flashbackdied then
		flashbackdied:Disconnect()
	end

	flashbackdied = humm.Died:Connect(function()
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if hrp then
			flashbackpos = hrp.CFrame
		end
	end)
end)
addcmd("flashback", "Teleports to the last position you died.", function()
	if not flashbackpos then
		notif("Kruel", "You need to die once, you know.", 3)
		return
	end
	if p.Character and p.Character.HumanoidRootPart then
		p.Character.HumanoidRootPart.CFrame = flashbackpos
	end
end)
addcmd("autoflashback", "Automatically teleports to the last position you died when you die.", function()
	autoflashback = true
end)
addcmd("unautoflashback", "Stops autoflashback.", function()
	autoflashback = false
end)
local orgdestroyheights = nil
addcmd("antivoid", "Prevents you from falling into the void.", function()
	orgdestroyheights = workspace.FallenPartsDestroyHeight
	workspace:GetPropertyChangedSignal("FallenPartsDestroyHeight"):Connect(function()
		workspace.FallenPartsDestroyHeight = 0 / 0
	end)
	workspace.FallenPartsDestroyHeight = 0 / 0
end)
addcmd("unantivoid", "Stops antivoid.", function()
	if orgdestroyheights then
		workspace.FallenPartsDestroyHeight = orgdestroyheights
	end
end)
addcmd("fakeout", "Fake going into the void.", function()
	if p.Character and p.Character.HumanoidRootPart then
		local pos = p.Character.HumanoidRootPart.CFrame
		local orgfallenparts = workspace.FallenPartsDestroyHeight
		workspace.FallenPartsDestroyHeight = 0/0
		p.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(0, orgfallenparts - 25, 0))
		task.wait(0.4)
		p.Character.HumanoidRootPart.CFrame = pos
		workspace.FallenPartsDestroyHeight = orgfallenparts
	end
end)
addcmd({ "jp", "jumppower", "jumpheight" }, "Changes JumpHeight property.", function(args)
	if p.Character and p.Character.Humanoid then
		p.Character.Humanoid.UseJumpPower = true
		p.Character.Humanoid.JumpPower = tonumber(args[1])
		notif("Kruel", "JumpPower changed to " .. tonumber(args[1]), 3)
		if not tonumber(args[1]) then
			notif("Kruel", "Argument is not a number.", 3)
		end
	end
end)
addcmd("noclip", "Allows you to go through walls.", function()
	noclipping = true
	noclipconn = rs.Stepped:Connect(function() -- stfu "undefined global" 🤖🤖🤖 ts works fine
		if p.Character then
			for _, part in players.LocalPlayer.Character:GetDescendants() do
				if part.Name ~= "Hitbox" then
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end
	end)
end)
local bangAnim = nil
local bang = nil
local bangLoop = nil
local bangDied = nil
addcmd("unbang", "Stops bang.", function()
	if bang then
		bang:Stop()
		bangAnim:Destroy()
		bangDied:Disconnect()
		bangLoop:Disconnect()
	end
end)
addcmd("bang", "Bang a player. Need I say more?", function(args)
	local vctms = findplr(args[1])
	local plrr = vctms[1]
	exec("unbang")
	task.wait()

	if not plrr or not plrr.Character then
		notif("Kruel", "Player not found or no character", 3)
		return
	end

	local humanoid = p.Character:FindFirstChildWhichIsA("Humanoid")
	bangAnim = Instance.new("Animation")
	bangAnim.AnimationId = not r15(p) and "rbxassetid://148840371" or "rbxassetid://5918726674"
	bang = humanoid:LoadAnimation(bangAnim)
	bang:Play(0.1, 1, 1)
	bang:AdjustSpeed(args[2] or 3)
	bangDied = humanoid.Died:Connect(function()
		bang:Stop()
		bangAnim:Destroy()
		bangDied:Disconnect()
		bangLoop:Disconnect()
	end)

	local bangplr = plrr.Name
	local bangOffset = CFrame.new(0, 0, 1.3)
	local velhist = {}
	local histsize = 3

	notif("Kruel", "Banging " .. bangplr, 3)

	bangLoop = rs.Heartbeat:Connect(function()
		pcall(function()
			local trgtplr = players:FindFirstChild(bangplr)
			if not trgtplr then
				return
			end

			local trgtchar = trgtplr.Character
			if not trgtchar then
				return
			end

			local otherrt = trgtchar:FindFirstChild("HumanoidRootPart")
			if not otherrt then
				return
			end

			local mychr = p.Character
			if not mychr then
				return
			end

			local myrt = mychr:FindFirstChild("HumanoidRootPart")
			if not myrt then
				return
			end

			table.insert(velhist, otherrt.AssemblyLinearVelocity)
			if #velhist > histsize then
				table.remove(velhist, 1)
			end

			local avgvl = Vector3.zero
			for _, v in pairs(velhist) do
				avgvl += v
			end
			avgvl /= #velhist

			local spd = avgvl.Magnitude
			local predmulti = math.clamp(spd / 16, 0.15, 0.4)

			local predpos = Vector3.new(
				otherrt.Position.X + (avgvl.X * predmulti),
				otherrt.Position.Y,
				otherrt.Position.Z + (avgvl.Z * predmulti)
			)
			local predcf = CFrame.new(predpos, predpos + otherrt.CFrame.LookVector)

			myrt.CFrame = predcf * bangOffset
		end)
	end)
end)
addcmd({ "unnoclip", "clip" }, "Stops noclip.", function()
	if noclipping == false then
		notif("Kruel", "You are not currently noclipping.", 3)
	end
	noclipconn:Disconnect()
end)
local viewing = false
local viewconn = nil
local leaveconn = nil
addcmd({ "view", "spectate" }, "Spectate a player.", function(args)
	local vctms = findplr(args[1])
	local plrr = vctms[1]
	if not plrr then
		return
	end
	viewing = true
	exec("thirdp")
	if viewconn then
		viewconn:Disconnect()
		viewconn = nil
	end
	if leaveconn then
		leaveconn:Disconnect()
		leaveconn = nil
	end
	if plrr and plrr.Character and plrr.Character.Humanoid then
		workspace.CurrentCamera.CameraSubject = plrr.Character.Humanoid
		notif("Kruel", "Now spectating " .. plrr.Name, 3)
	end
	viewconn = plrr.CharacterAdded:Connect(function(char)
		if viewing then
			char:WaitForChild("Humanoid", 5)
			if char.Humanoid then
				workspace.CurrentCamera.CameraSubject = char.Humanoid
			end
		end
	end)
	leaveconn = players.PlayerRemoving:Connect(function(plr)
		if plr == vctms[1] and p.Character and p.Character.Humanoid then
			workspace.CurrentCamera.CameraSubject = p.Character.Humanoid
		end
	end)
end)
local tpfreezeconn = nil
addcmd("tpfreeze", "Freezes yourself using teleportation.", function()
	if p and p.Character and p.Character.HumanoidRootPart then
		local pos = p.Character.HumanoidRootPart.CFrame
		tpfreezeconn = rs.RenderStepped:Connect(function()
			if not p.Character or not p.Character.HumanoidRootPart then
				return
			end
			p.Character.HumanoidRootPart.CFrame = pos
		end)
	end
end)
addcmd("untpfreeze", "Stops tpfreeze.", function()
	if tpfreezeconn then
		tpfreezeconn:Disconnect()
	end
end)
addcmd("weldfreeze", "Freezes yourself using welds.", function()
	if p and p.Character and p.Character.HumanoidRootPart then
		local hrp = p.Character.HumanoidRootPart
		local hrptoweld = hrp:Clone()
		hrptoweld.Name = "HumanoidRootPart2"
		hrptoweld.CanCollide = false
		hrptoweld.Anchored = true
		hrptoweld.CFrame = hrp.CFrame
		hrptoweld.Parent = hrp.Parent
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = hrp
		weld.Part1 = hrptoweld
		weld.Parent = hrp
	end
end)
addcmd("unweldfreeze", "Stops weldfreeze.", function()
	if p and p.Character and p.Character.HumanoidRootPart then
		local weldtofind = p.Character:FindFirstChild("HumanoidRootPart"):FindFirstChildWhichIsA("WeldConstraint")
		if weldtofind then
			weldtofind:Destroy()
		end
	end
end)
addcmd("antisit", "Prevents you from sitting.", function()
	if p.Character and p.Character.Humanoid then
		p.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
	end
end)
addcmd("unantisit", "Prevents you from sitting.", function()
	if p.Character and p.Character.Humanoid then
		p.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
	end
end)
addcmd("unview", "Stop viewing a player.", function()
	if p.Character and p.Character.Humanoid then
		if viewconn then
			viewconn:Disconnect()
			viewconn = nil
		end
		if leaveconn then
			leaveconn:Disconnect()
			leaveconn = nil
		end
		viewing = false
		workspace.CurrentCamera.CameraSubject = p.Character.Humanoid
	end
end)
addcmd({ "rj", "rejoin" }, "Rejoin the same server.", function()
	tp:TeleportToPlaceInstance(placeid, jobid, p)
end)
addcmd("sit", "Take a break.", function()
	p.Character.Humanoid.Sit = math.deg(2)
		+ (5 * 7 - 42 - (3 * 38) + (math.deg(2 / (4 * 2 / 4) - 0.05 * 20 + 0.1 * 20 / 2) - 2 - 8 - (5 * (5 + 4))))
end)
addcmd("trip", "Fall over forward", function()
	local char = p.Character
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChild("Humanoid")

	if hrp and hum then
		hum:ChangeState(Enum.HumanoidStateType.FallingDown)

		local shovedir = hrp.CFrame.LookVector * (hrp.AssemblyMass * 30)
		hrp:ApplyImpulse(shovedir)
	end
end)
addcmd({ "ref", "refresh" }, "Respawn at same position.", function()
	if p.Character and p.Character.HumanoidRootPart then
		local pos = p.Character.HumanoidRootPart.CFrame
		p.Character.Head:Destroy()
		p.Character.Humanoid.Health = 0
		p.CharacterAdded:Wait()
		local char = p.Character:WaitForChild("HumanoidRootPart")
		char.CFrame = pos
	end
end)
addcmd({ "loop", "loopcmd", "loopcommand" }, "Loops a command (loop [times] [command]", function(args)
	local times = tonumber(args[1])
	local cmd = tostring(args[2])
	for i = 1, times do
		exec(cmd)
		task.wait(0.05)
	end
end)
addcmd("r6", "Switches to R6 animations (R15 Only).", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Veaquach/r6for15/refs/heads/main/r6"))()
end)
addcmd({ "clicktp", "ctp" }, "Hold CTRL and click to teleport.", function()
	local mouse = p:GetMouse()
	ctpconn = mouse.Button1Down:Connect(function()
		if uis:IsKeyDown(Enum.KeyCode.LeftControl) then
			if p.Character and p.Character.HumanoidRootPart then
				p.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p) * CFrame.new(0, 3, 0)
			end
		end
	end)
	notif("Kruel", "Active! Hold Left Control and click to teleport.", 3)
end)
addcmd({ "unclicktp", "unctp" }, "Stops ClickTP.", function()
	if ctpconn then
		ctpconn:Disconnect()
	end
	notif("Kruel", "Stopped.", 3)
end)
addcmd({ "fullbright", "fb" }, "Fullbright", function()
	local l = game.Lighting
	l.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	l.Brightness = 2
	l.ClockTime = 14
	l.FogEnd = 100000
	l.GlobalShadows = false
end)
addcmd({ "shop", "serverhop" }, "Goes to another server.", function()
	loadstring(
		game:HttpGet("https://raw.githubusercontent.com/Cesare0328/my-scripts/refs/heads/main/CachedServerhop.lua")
	)()
end)
addcmd({ "chatlogs", "chatlog", "logs", "chatspy" }, "Logs the chat.", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Veaquach/kruel/refs/heads/main/kruellogs.txt"))() -- ts is not skidded btw i made it myself
end)
addcmd({ "exit", "nokruel", "destroy" }, "Closes Kruel.", function()
	psg:Destroy()
	flinging = false
	FLYING = false
	noclipping = false
	infjumping = false
	if noclipconn then
		noclipconn:Disconnect()
	end
	if plrconn then
		plrconn:Disconnect()
	end -- holy shit undefined global fucking pmo
	if ctpconn then
		ctpconn:Disconnect()
	end
	script:Destroy()
end)
addcmd({ "bypasser", "chatbypasser", "bypass", "chatbypass" }, "Loads fearless chat bypasser script.", function()
	loadstring(
		game:HttpGet("https://raw.githubusercontent.com/fearlessd3v/TEAM-FEARLESS/refs/heads/main/fearless-chat-bypass")
	)()
end)
local esploops = {}
local respawnconns = {}
local esping = false
local playeradded = nil
local esprefloop = nil

function NOESP(plr)
	if esploops[plr] then
		esploops[plr]:Disconnect()
		esploops[plr] = nil
	end

	if respawnconns[plr] then
		respawnconns[plr]:Disconnect()
		respawnconns[plr] = nil
	end

	local char = plr.Character
	if not char then
		return
	end

	local highlight = char:FindFirstChildOfClass("Highlight")
	if highlight then
		highlight:Destroy()
	end

	local head = char:FindFirstChild("Head")
	if not head then
		return
	end

	local billboard = head:FindFirstChild("usphind coding is ud asf")
	if billboard then
		billboard:Destroy()
	end
end

function ESP(plr, char)
	if plr == p then
		return
	end

	char = char or plr.Character
	if not char then
		return
	end
	if esploops[plr] then
		return
	end

	local hum = char:WaitForChild("Humanoid", 3)
	local root = char:WaitForChild("HumanoidRootPart", 3)
	local head = char:WaitForChild("Head", 3)

	if not (hum and root and head) then
		return
	end

	local bg = Instance.new("BillboardGui")
	bg.Parent = head
	bg.Name = "usphind coding is ud asf"
	bg.Adornee = head
	bg.Size = UDim2.new(0, 100, 0, 150)
	bg.StudsOffset = Vector3.new(0, 1, 0)
	bg.AlwaysOnTop = true

	local hfr = Instance.new("Frame")
	hfr.Parent = bg
	hfr.Size = UDim2.new(0, 100, 0, 8)
	hfr.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	hfr.BorderSizePixel = 0
	hfr.Position = UDim2.new(0, 2.5, 0, 40)
	hfr.ZIndex = 15

	local hfr2 = Instance.new("Frame")
	hfr2.Parent = bg
	hfr2.Size = UDim2.new(0, 104.5, 0, 12)
	hfr2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	hfr2.BorderSizePixel = 0
	hfr2.Position = UDim2.new(0, 0, 0, 38)

	local label = Instance.new("TextLabel")
	label.Font = Enum.Font.SourceSansSemibold
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1
	label.Parent = bg
	label.Position = UDim2.new(0, 0, 0, -25)
	label.TextSize = 20
	label.TextStrokeTransparency = 0
	label.ZIndex = 10
	label.Size = UDim2.new(0, 100, 0, 100)

	local highlight = Instance.new("Highlight")
	highlight.Parent = char
	highlight.Adornee = char
	highlight.FillColor = plr.TeamColor.Color
	highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

	esploops[plr] = rs.Heartbeat:Connect(function()
		if not char.Parent then
			NOESP(plr)
			return
		end

		local localChar = p.Character
		if not localChar then
			p.CharacterAdded:Wait()
			localChar = p.Character
		end
		local localRoot = localChar:WaitForChild("HumanoidRootPart", 5)
		if not localRoot then
			return
		end

		if not (char and char.Parent and hum and root and localRoot) then
			return
		end

		local distance = (localRoot.Position - root.Position).Magnitude
		local displayName = plr.DisplayName ~= plr.Name and plr.DisplayName .. " (@" .. plr.Name .. ")" or plr.Name
		label.Text = string.format("[%dHP] %s [%dM]", math.floor(hum.Health), displayName, math.floor(distance))

		highlight = char:FindFirstChildOfClass("Highlight")
		local percentage = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
		hfr.Size = UDim2.new(percentage, 0, 0, 8)
		if percentage < 0.25 then
			hfr.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		elseif percentage < 0.5 then
			hfr.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
		elseif percentage < 0.6 then
			hfr.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
		else
			hfr.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		end
		if distance > 250 then
			if highlight then
				highlight:Destroy()
				highlight = nil
			end
		else
			if not highlight then
				highlight = Instance.new("Highlight")
				highlight.Parent = char
				highlight.Adornee = char
				highlight.FillColor = plr.TeamColor.Color
				highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
				highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			end

			highlight.FillColor = plr.TeamColor.Color
		end
	end)
end

addcmd("esp", "Enables ESP", function()
	if esping then
		notif("Kruel", "ESP already enabled", 2)
		return
	end

	esping = true

	for _, plr in ipairs(players:GetPlayers()) do
		if plr ~= p then
			task.spawn(function()
				if plr.Character then
					ESP(plr, plr.Character)
				end
			end)

			respawnconns[plr] = plr.CharacterAdded:Connect(function(char)
				task.wait(0.2)
				if esping then
					ESP(plr, char)
				end
			end)
		end
	end

	playeradded = players.PlayerAdded:Connect(function(plr)
		if plr == p then
			return
		end

		respawnconns[plr] = plr.CharacterAdded:Connect(function(char)
			task.wait(0.2)
			if esping then
				ESP(plr, char)
			end
		end)

		if plr.Character then
			task.spawn(function()
				ESP(plr, plr.Character)
			end)
		end
	end)

	esprefloop = task.spawn(function()
		while esping do
			task.wait(2)
			if not esping then
				break
			end

			for _, plr in ipairs(players:GetPlayers()) do
				if plr ~= p and plr.Character then
					local char = plr.Character
					local head = char:FindFirstChild("Head")
					local hasESP = head and head:FindFirstChild("usphind coding is ud asf")

					if not esploops[plr] or not hasESP then
						NOESP(plr)
						task.spawn(function()
							ESP(plr, char)
						end)
					end
				end
			end
		end
	end)

	notif("Kruel", "ESP enabled", 2)
end)

addcmd("unesp", "Disables ESP", function()
	esping = false

	if esprefloop then
		task.cancel(esprefloop)
		esprefloop = nil
	end

	if playeradded then
		playeradded:Disconnect()
		playeradded = nil
	end

	for _, plr in ipairs(players:GetPlayers()) do
		NOESP(plr)
	end

	for plr, conn in pairs(respawnconns) do
		conn:Disconnect()
	end
	respawnconns = {}

	for plr, conn in pairs(esploops) do
		conn:Disconnect()
	end
	esploops = {}

	notif("Kruel", "ESP disabled", 2)
end)

players.PlayerRemoving:Connect(function(plr)
	NOESP(plr)
end)
local antifalldamaging = false
local fallconn = nil
local fallcharconn = nil
function noantifalldamage()
	antifalldamaging = false
	if fallconn then
		fallconn:Disconnect()
	end
	fallconn = nil
	if fallcharconn then
		fallcharconn:Disconnect()
	end
	fallcharconn = nil
end
addcmd("stopvelocity", "Stops velocity.", function()
	for i = 1, 50 do
		p.Character.HumanoidRootPart.Velocity = Vector3.zero
		p.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		p.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		task.wait()
	end
end)
local glitchconn = nil
local glitching = false
local glitchdelay = 1
addcmd("glitch", "Glitches you as you walk.", function()
	if p.Character and p.Character.HumanoidRootPart then
		glitching = true
		glitchconn = task.spawn(function()
			while glitching do
				local hrp = p.Character.HumanoidRootPart
				hrp.CFrame = hrp.CFrame * CFrame.new(math.random(-3, 3), 0, math.random(-3, 3))
				task.wait(glitchdelay)
			end
		end)
	end
end)
addcmd("unglitch", "Stops glitching.", function()
	if glitchconn then
		glitching = false
		task.cancel(glitchconn)
		glitchconn = nil
	end
end)
addcmd("glitchdelay", "Changes the delay of glitch.", function(args)
	if not tonumber(args[1]) then
		return
	end
	glitchdelay = tonumber(args[1])
end)
local antitouchconn = nil
local antitouchrange = 10
addcmd({ "antitouch", "antiskid" }, "Prevents you from getting touched by other players.", function()
	antitouchconn = rs.Heartbeat:Connect(function()
		for i, v in game.Players:GetPlayers() do
			if v ~= p then
				local hrp = v.Character.HumanoidRootPart
				local hrp2 = p.Character.HumanoidRootPart
				if hrp and hrp2 then
					local mag = (hrp2.Position - hrp.Position)
					local magg = mag.magnitude
					if magg < antitouchrange then
						local dir = mag.Unit
						ts:Create(
							hrp2,
							TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{ CFrame = CFrame.new(hrp2.Position + (dir * 2)) * (hrp2.CFrame - hrp2.Position) }
						):Play()
					end
				end
			end
		end
	end)
end)
addcmd("antitouchrange", "Changes the range of antitouch.", function(args)
	if not tonumber(args[1]) then
		return
	end
	antitouchrange = tonumber(args[1])
end)
addcmd("unantitouch", "Stops antitouch.", function()
	if antitouchconn then
		antitouchconn:Disconnect()
		antitouchconn = nil
	end
end)
local lastcall = 0
addcmd("ccu", "Gets concurrent Kruel users.", function()
	if lastcall + 5 > tick() then
		return
	end
	lastcall = tick()
	heartbeat()
	notif("Kruel", "Concurrent users: " .. heartbeat(), 2)
end)
function partisplr(part)
	if part then
		local model = part:FindFirstAncestorOfClass("Model")
		if model and model:FindFirstChildOfClass("Humanoid") then
			return true
		end
	end
end
addcmd("xray", "Turns on xray.", function()
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency < 1 then
			local model = v:FindFirstAncestorOfClass("Model")
			if model and model:FindFirstChildOfClass("Humanoid") then
				continue
			end
			v.LocalTransparencyModifier = 0.5
		end
	end
end)
addcmd("unxray", "Turns off xray.", function()
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.LocalTransparencyModifier = 0
		end
	end
end)
addcmd("follow", "Follows a player.", function(args)
	local trgt = findplr(args[1])[1]
	if not trgt then
		return
	end
	if followconn then
		followconn:Disconnect()
		followconn = nil
	end
	followconn = rs.Heartbeat:Connect(function()
		local hrp = p.Character.Humanoid
		local hrp2 = trgt.Character.HumanoidRootPart
		local mag = (hrp2.Position - hrp.Parent.HumanoidRootPart.Position)
		if hrp and hrp2 then
			if mag.magnitude > 2 then
				hrp:MoveTo(hrp2.Position)
			else
				hrp:MoveTo(hrp.Parent.HumanoidRootPart.Position)
			end
		end
	end)
end)
addcmd("unfollow", "Stops following.", function()
	if followconn then
		followconn:Disconnect()
		followconn = nil
	end
end)
addcmd("bhop", "Turns on bhop.", function()
	bhopconn = rs.Heartbeat:Connect(function()
		local hrp = p.Character.Humanoid
		if hrp.FloorMaterial ~= Enum.Material.Air then
			presskey(Enum.KeyCode.Space)
		end
	end)
end)
addcmd("unbhop", "Turns off bhop.", function()
	if bhopconn then
		bhopconn:Disconnect()
		bhopconn = nil
	end
end)
addcmd("antiafk", "Stops afk kick.", function()
	antiafking = not antiafking
	if antiafkspawn then
		task.cancel(antiafkspawn)
	end
	if antiafking then
		antiafkspawn = task.spawn(function()
			while antiafking do
				local hum = p.Character.Humanoid
				local virtualuser = cloneref(game:GetService("VirtualInputManager"))
				virtualuser:SendKeyEvent(true, Enum.KeyCode.E, false, game)
				task.wait(0.1)
				virtualuser:SendKeyEvent(false, Enum.KeyCode.E, false, game)
				task.wait(300)
			end
		end)
	end
end)
addcmd("unantiafk", "Stops antiafk.", function()
	antiafking = false
	if antiafkspawn then
		task.cancel(antiafkspawn)
	end
end)
addcmd("antifalldamage", "Stops fall damage", function()
	if antifalldamaging then
		antifalldamaging = false
		if fallconn then
			fallconn:Disconnect()
		end
		if fallcharconn then
			fallcharconn:Disconnect()
		end
		notif("Kruel", "Anti-Fall Damage Disabled", 2)
		return
	end

	antifalldamaging = true
	local lp = players.LocalPlayer
	local z = Vector3.zero

	local function startanti(c)
		local r = c:WaitForChild("HumanoidRootPart", 5)
		if r then
			if fallconn then
				fallconn:Disconnect()
			end
			fallconn = rs.Heartbeat:Connect(function()
				if not r.Parent or not antifalldamaging then
					fallconn:Disconnect()
					return
				end
				local v = r.AssemblyLinearVelocity
				r.AssemblyLinearVelocity = z
				rs.RenderStepped:Wait()
				r.AssemblyLinearVelocity = v
			end)
		end
	end

	if lp.Character then
		startanti(lp.Character)
	end
	fallcharconn = lp.CharacterAdded:Connect(startanti)
	notif("Kruel", "Anti-Fall Damage Enabled", 2)
end)
local autoclicking = false
addcmd("autoclick", "Turns on autoclick. Usage: ;autoclick [right/left] [delay], click X to stop.", function(args)
	local side = args[1]
	local delay = args[2]
	if not side or not delay then
		return
	end
	if not tonumber(delay) or not tostring(side) then
		return
	end
	if autoclickconn then
		autoclickconn:Disconnect()
		autoclickconn = nil
	end
	autoclicking = true
	notif("Kruel", "Auto-Click enabled, press X to stop.", 2)
	local uis = cloneref(game:GetService("UserInputService"))
	local virtualuser = cloneref(game:GetService("VirtualInputManager"))
	autoclickingspawn = task.spawn(function()
		while autoclicking do
			if uis:IsKeyDown(Enum.KeyCode.X) then
				autoclicking = false
				task.cancel(autoclickingspawn)
			end
			if side:lower() == "right" then
				local pos = uis:GetMouseLocation()
				virtualuser:SendMouseButtonEvent(pos.X, pos.Y, 1, true, game, 1)
				task.wait(0.01)
				virtualuser:SendMouseButtonEvent(pos.X, pos.Y, 1, false, game, 1)
				task.wait(tonumber(delay))
			elseif side:lower() == "left" then
				local pos = uis:GetMouseLocation()
				virtualuser:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 1)
				task.wait(0.01)
				virtualuser:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 1)
				task.wait(tonumber(delay))
			end
		end
	end)
end)
local autokeying = false
addcmd("autokey", "Turns on autokey. Usage: ;autokey [key] [delay], click X to stop.", function(args)
	local key = args[1]
	local delay = args[2]
	if not key or not delay then
		return
	end
	if not tonumber(delay) or not tostring(key) then
		return
	end
	if autokeyspawn then
		task.cancel(autokeyspawn)
		autokeyspawn = nil
		autokeying = false
	end
	autokeying = true
	notif("Kruel", "Auto-Key enabled, press X to stop.", 2)
	local uis = cloneref(game:GetService("UserInputService"))
	local virtualuser = cloneref(game:GetService("VirtualInputManager"))
	autokeyspawn = task.spawn(function()
		while autokeying do
			if uis:IsKeyDown(Enum.KeyCode.X) then
				autokeying = false
				task.cancel(autoclickingspawn)
			end
			if tostring(key:upper()) and Enum.KeyCode[tostring(key:upper())] then
				virtualuser:SendKeyEvent(true, Enum.KeyCode[tostring(key:upper())], false, game)
				task.wait(0.01)
				virtualuser:SendKeyEvent(false, Enum.KeyCode[tostring(key:upper())], false, game)
				task.wait(tonumber(delay))
			end
		end
	end)
end)
addcmd("autowalk", "Turns on autowalk.", function()
	autowalkconn = rs.Heartbeat:Connect(function()
		if not p.Character then
			return
		end
		local hum = p.Character:FindFirstChildWhichIsA("Humanoid")
		if not hum then
			return
		end

		hum.WalkToPoint = p.Character.HumanoidRootPart.Position + p.Character.HumanoidRootPart.CFrame.LookVector * 1000
	end)
end)
addcmd("unautowalk", "Stops autowalk.", function()
	if autowalkconn then
		autowalkconn:Disconnect()
		autowalkconn = nil
		local hum = p.Character:FindFirstChildWhichIsA("Humanoid")
		if hum then
			hum:Move(Vector3.new(0, 0, 0))
			presskey(Enum.KeyCode.W)
		end
	end
end)
addcmd("unantifalldamage", "Stops fall damage", function()
	noantifalldamage()
	notif("Kruel", "Anti-Fall Damage Disabled", 2)
end)
addcmd("flingtool", "Flings anyone you click.", function()
	local tool = Instance.new("Tool")
	tool.RequiresHandle = false
	tool.Name = "Fling Tool"
	tool.Parent = players.LocalPlayer.Backpack
	local mouse = players.LocalPlayer:GetMouse()
	tool.Activated:Connect(function()
		local hit = mouse.Target
		local hum = hit:FindFirstAncestorWhichIsA("Model")
		if hum then
			hum = hum:FindFirstChildWhichIsA("Humanoid")
		end
		if hum and hum.Parent:FindFirstChild("HumanoidRootPart") then
			Fling(hum.Parent.HumanoidRootPart)
		end
	end)
end)
--============================== FOLLOWING SHIT IS SKIDDED (😨) (I MADE A BAD VERSION OF THIS AND GAVE UP) ==============================
local FLOAT = false
local bv = nil
local function unanim()
	local char = p.Character
	if not char then
		return
	end

	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end

	local animator = humanoid:FindFirstChildOfClass("Animator")
	if not animator then
		return
	end

	for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
		track:Stop(0)
	end
end
local function anim(id)
	local char = p.Character or p.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	unanim()

	local animator = humanoid:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://" .. tostring(id)

	local track = animator:LoadAnimation(animation)
	track:Play(0)

	return track
end
local rs = cloneref(game:GetService("RunService"))
local UIS = cloneref(game:GetService("UserInputService"))

local MOVE_ID = 88355433528455
local IDLE_ID = 110655383512189

local currentTrack
local bv, bg
local FLOAT = false
local FLY = false
local function anim(id)
	local char = p.Character or p.CharacterAdded:Wait()
	local hum = char:WaitForChild("Humanoid")
	local animator = hum:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = hum
	end
	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://" .. id
	local track = animator:LoadAnimation(animation)
	track.Looped = true
	track:Play(0)
	return track
end

local function playAnim(id)
	if currentTrack then
		currentTrack:Stop(0.1)
	end
	currentTrack = anim(id)
end
local function getFloatDir()
	local cam = workspace.CurrentCamera.CFrame
	local look = Vector3.new(cam.LookVector.X, 0, cam.LookVector.Z)
	local right = Vector3.new(cam.RightVector.X, 0, cam.RightVector.Z)
	local moveDir = Vector3.zero

	if UIS:IsKeyDown(Enum.KeyCode.W) then
		moveDir = moveDir + look
	end
	if UIS:IsKeyDown(Enum.KeyCode.S) then
		moveDir = moveDir - look
	end
	if UIS:IsKeyDown(Enum.KeyCode.A) then
		moveDir = moveDir - right
	end
	if UIS:IsKeyDown(Enum.KeyCode.D) then
		moveDir = moveDir + right
	end
	if UIS:IsKeyDown(Enum.KeyCode.Space) then
		moveDir = moveDir + Vector3.new(0, 1, 0)
	end
	if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
		moveDir = moveDir - Vector3.new(0, 1, 0)
	end

	return moveDir
end
addcmd("float", "Walk-speed float, no animations", function()
	local char = p.Character or p.CharacterAdded:Wait()
	local root = char:WaitForChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not root or not hum then
		return
	end

	FLOAT = true
	hum.PlatformStand = true

	if bv then
		bv:Destroy()
	end
	bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	bv.Velocity = Vector3.zero
	bv.Parent = root

	task.spawn(function()
		while FLOAT do
			rs.Heartbeat:Wait()
			local moveDir = getFloatDir()

			if moveDir.Magnitude > 0 then
				bv.Velocity = moveDir.Unit * hum.WalkSpeed
				local horizontalDir = Vector3.new(moveDir.X, 0, moveDir.Z)
				if horizontalDir.Magnitude > 0 then
					root.CFrame = CFrame.new(root.Position, root.Position + horizontalDir)
				end
			else
				bv.Velocity = Vector3.zero
			end

			root.AssemblyAngularVelocity = Vector3.zero
		end

		if bv then
			bv:Destroy()
		end
		hum.PlatformStand = false
	end)
end)
addcmd("superman", "Superman-style free flight with animations and camera follow.", function()
	local char = p.Character or p.CharacterAdded:Wait()
	local root = char:WaitForChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not root or not hum then
		return
	end

	FLY = true
	hum.PlatformStand = true

	if bv then
		bv:Destroy()
	end
	bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
	bv.Velocity = Vector3.zero
	bv.Parent = root

	if bg then
		bg:Destroy()
	end
	bg = Instance.new("BodyGyro")
	bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
	bg.P = 2000
	bg.D = 500
	bg.CFrame = root.CFrame
	bg.Parent = root

	task.spawn(function()
		while FLY do
			cloneref(game:GetService("RunService")).Heartbeat:Wait()
			local moveDir = Vector3.zero
			local cam = workspace.CurrentCamera
			if UIS:IsKeyDown(Enum.KeyCode.W) then
				moveDir = moveDir + cam.CFrame.LookVector
			end
			if UIS:IsKeyDown(Enum.KeyCode.S) then
				moveDir = moveDir - cam.CFrame.LookVector
			end
			if UIS:IsKeyDown(Enum.KeyCode.A) then
				moveDir = moveDir - cam.CFrame.RightVector
			end
			if UIS:IsKeyDown(Enum.KeyCode.D) then
				moveDir = moveDir + cam.CFrame.RightVector
			end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then
				moveDir = moveDir + Vector3.new(0, 1, 0)
			end
			if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
				moveDir = moveDir - Vector3.new(0, 1, 0)
			end

			if moveDir.Magnitude > 0 then
				bv.Velocity = moveDir.Unit * hum.WalkSpeed * 6
				bg.CFrame = CFrame.new(root.Position, root.Position + moveDir)
				if not currentTrack or currentTrack.Animation.AnimationId ~= "rbxassetid://" .. MOVE_ID then
					if currentTrack then
						currentTrack:Stop(0)
					end
					playAnim(MOVE_ID)
				end
			else
				bv.Velocity = Vector3.zero
				bg.CFrame = CFrame.new(root.Position, root.Position + Vector3.new(0, 0, 1))
				if not currentTrack or currentTrack.Animation.AnimationId ~= "rbxassetid://" .. IDLE_ID then
					if currentTrack then
						currentTrack:Stop(0)
					end
					playAnim(IDLE_ID)
				end
			end

			root.AssemblyAngularVelocity = Vector3.zero
		end

		if bv then
			bv:Destroy()
		end
		if bg then
			bg:Destroy()
		end
		hum.PlatformStand = false
	end)
end)

addcmd("unfloat", "Stop float", function()
	FLOAT = false
	unanim()
	if bv then
		bv:Destroy()
	end
	bv = nil
	local char = p.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.PlatformStand = false
		end
	end
end)
addcmd("unsuperman", "Stop superman", function()
	FLY = false
	unanim()
	if bv then
		bv:Destroy()
	end
	bv = nil
	if bg then
		bg:Destroy()
	end
	bg = nil
	local char = p.Character
	if char then
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.PlatformStand = false
		end
	end
end)
--============================== END OF SKIDDING EZ ==============================
addcmd("whatexecutor", "Identifies executor.", function()
	local exec = executor or identifyexecutor and identifyexecutor() or "identifyexecutor() not available"
	local id = (getthreadidentity and getthreadidentity()) or (getidentity and getidentity()) or "N/A"
	local isinternal = false
	local a = setmetatable({}, {
		__index = function()
			return 1
		end,
	})
	pcall(function()
		hookmetamethod(a, "__index", function()
			return "GG"
		end)
	end)
	if a.b == "GG" then
		isinternal = true
	else
		isinternal = false
	end
	notif(
		"Kruel",
		"Your executor is: "
			.. exec
			.. "\nIdentity level: "
			.. id
			.. "\nInternal Executor: "
			.. (isinternal and "True" or "False"),
		3
	)
end)
local fovloop = nil
addcmd("fov", "Changes FOV", function(args)
	if fovloop then
		fovloop:Disconnect()
		fovloop = nil
	end
	if args[1] and tonumber(args[1]) then
		fovloop = rs.RenderStepped:Connect(function()
			workspace.CurrentCamera.FieldOfView = args[1]
		end)
	end
end)
addcmd("walkfling", "Flings anyone you touch.", function()
	local humanoid = p.Character:FindFirstChildWhichIsA("Humanoid")
	if humanoid then
		humanoid.Died:Connect(function()
			walkflinging = false
			exec("clip")
		end)
	end

	exec("noclip")
	walkflinging = true
	repeat
		rs.Heartbeat:Wait()
		local character = p.Character
		local root = character:WaitForChild("HumanoidRootPart")
		local vel, movel = nil, 0.1

		while not (character and character.Parent and root and root.Parent) do
			rs.Heartbeat:Wait()
			character = p.Character
			root = character:WaitForChild("HumanoidRootPart")
		end

		vel = root.Velocity
		root.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)

		rs.RenderStepped:Wait()
		if character and character.Parent and root and root.Parent then
			root.Velocity = vel
		end

		rs.Stepped:Wait()
		if character and character.Parent and root and root.Parent then
			root.Velocity = vel + Vector3.new(0, movel, 0)
			movel = movel * -1
		end
	until walkflinging == false
end)
addcmd("unwalkfling", "Stops walkflinging.", function()
	if walkflinging == true then
		walkflinging = false
		exec("clip")
	end
end)
addcmd("maxzoom", "Maximal zoom out.", function(args)
	p.CameraMaxZoomDistance = tonumber(args[1])
end)
addcmd("thirdp", "Allows you to go in third person.", function()
	p.CameraMode = "Classic"
	exec("maxzoom 50")
end)
addcmd("firstp", "Makes you go in first person.", function()
	p.CameraMode = Enum.CameraMode.LockFirstPerson
	p.CameraMaxZoomDistance = 0
end)
function highlightplr(plr)
	local char = plr.Character
	if char then
		local highlight = Instance.new("Highlight")
		highlight.Parent = char
		highlight.Adornee = char
		highlight.FillColor = Color3.new(1, 1, 1)
		highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		local billboard = Instance.new("BillboardGui")
		billboard.Parent = plr.Character.HumanoidRootPart
		billboard.Name = "usphind coding is ud"
		billboard.Size = UDim2.new(1, 0, 1, 0)
		billboard.StudsOffset = Vector3.new(0, 5, 0)
		billboard.AlwaysOnTop = true
		local frame = Instance.new("Frame")
		frame.Parent = billboard
		frame.Size = UDim2.new(1, 0, 1, 0)
		frame.BackgroundTransparency = 1
		local textlabel = Instance.new("TextLabel")
		textlabel.Parent = frame
		textlabel.Text = "YOU ARE UNDERGROUND,\n NO ONE CAN SEE YOU.\n(p.s. people can't see this text)"
		textlabel.Font = Enum.Font.GothamBold
		textlabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		textlabel.BackgroundTransparency = 1
		textlabel.Size = UDim2.new(1, 0, 1, 0)
		textlabel.TextSize = 15
	end
end
addcmd("invis", "Attempts to make you invisible.", function()
	hummhipheight = p.Character.Humanoid.HipHeight
	loadstring(game:HttpGet("https://pastebin.com/raw/X20V7VMw"))()
	if r15() == false then
		notif("Kruel", "You are not R15.", 3)
		return
	end
	highlightplr(p)
	exec("tpwalk 2")
	exec("antivoid")
	exec("antitrip")
	exec("antisit")
	notif(
		"Kruel",
		"Loaded! May not work perfectly, even if on your screen you are visible, might not be the same for others.",
		3
	)
end)
addcmd("stretchres", "Horizontally stretches your camera. Usage: ;stretchres SCALE", function(args)
	local scale = tonumber(args[1])
	if not scale then
		notif("Kruel", "Invalid argument. Usage: ;stretchres SCALE", 3)
		return
	end

	getgenv().Resolution = {
		["hi"] = scale,
	}

	local Camera = workspace.CurrentCamera
	if getgenv().hi == nil then
		cloneref(game:GetService("RunService")).RenderStepped:Connect(function()
			Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, getgenv().Resolution["hi"], 0, 0, 0, 1)
		end)
	end
	getgenv().hi = "veaquach"

	notif("Kruel", "Stretch applied! Scale: " .. scale, 3)
end)
addcmd("hipheight", "Changes your hip height.", function(args)
	local height = tonumber(args[1])
	if not height then
		notif("Kruel", "Invalid argument. Usage: ;hipheight HEIGHT", 3)
		return
	end
	p.Character.Humanoid.HipHeight = height
end)
addcmd({ "resetstretch", "unstretch" }, "Resets camera stretch to normal.", function()
	local Camera = workspace.CurrentCamera
	getgenv().Resolution["hi"] = 1
	notif("Kruel", "Stretch reset to normal.", 3)
end)
addcmd("proud", "Announces Kruel usage.", function()
	pcall(function()
		cloneref(game:GetService("TextChatService")).TextChannels.RBXGeneral:SendAsync(
			"I AM USING KRUEL ADMIN! THIS WAS SENT CUZ I USED THE PROUD COMMAND. KRUEL EDITED BY TEAM CORRUPTED STUDIOS! TCS ON TOP. LOL."
		)
	end)
end)
addcmd("qvape", "Loads QVape V4", function()
	if executor ~= "Xeno" and executor ~= "Solara" then
		loadstring(
			game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true)
		)()
	else
		loadstring(game:HttpGet("https://raw.githubusercontent.com/new-qwertyui/CatV5/main/init.lua"), "init.lua")()
	end
end)
local instantpping = false
addcmd("instantpp", "Instant proximity prompts", function()
	instantpping = true
	while instantpping do
		for _, prompt in pairs(workspace:GetDescendants()) do
			if prompt:IsA("ProximityPrompt") then
				prompt.HoldDuration = 0
			end
		end
		task.wait(0.5)
	end
end)
addcmd("dex", "Loads Dex Explorer (not recommended for mobile)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
end)
addcmd("tptool", "Gives you a tool that teleports you to where you click", function()
	local tp = Instance.new("Tool")
	tp.Name = "TP Tool"
	tp.RequiresHandle = false
	tp.Parent = p.Backpack
	tp.Activated:Connect(function()
		local mouse = p:GetMouse()
		if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			p.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p) * CFrame.new(0, 3, 0)
		end
	end)
end)
addcmd("untptool", "Removes TP Tool from inventory", function()
	local bp = p:FindFirstChildOfClass("Backpack")
	if bp then
		local tool = bp:FindFirstChild("TP Tool")
		if tool then
			tool:Destroy()
		else
			notif("Kruel", "You do not have the TP Tool.", 3)
		end
	end
end)
addcmd("uninstantpp", "Stops instant proximity prompts", function()
	if instantpping == false then
		notif("Kruel", "You are not using instant proximity prompts.", 3)
	else
		instantpping = false
	end
end)
addcmd("blitz", "Loads BlitZ", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/BlizTBr/scripts/main/FTAP.lua"))()
end)
local tpwalking = false
addcmd("tpwalk", "basically better speed", function(args)
	local Heartbeat = cloneref(game:GetService("RunService")).Heartbeat
	local speed = tonumber(args[1])
	local chr = p.Character
	local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

	if not speed or not chr or not hum then
		notif("Kruel", "Invalid speed or character not found.", 2)
		return
	end

	tpwalking = true
	notif("Kruel", "Started TP walking at speed " .. speed, 2)
	local deathConnection
	deathConnection = hum.Died:Connect(function()
		tpwalking = false
		notif("Kruel", "Stopped TP walking due to death.", 2)
		if deathConnection then
			deathConnection:Disconnect()
		end
	end)
	task.spawn(function()
		while tpwalking and chr and hum and hum.Parent do
			local delta = Heartbeat:Wait()
			if hum.MoveDirection.Magnitude > 0 then
				chr:TranslateBy(hum.MoveDirection * speed * delta * 10)
			end
		end
	end)
end)
addcmd("untpwalk", "Stop tpwalking", function()
	if not tpwalking then
		notif("Kruel", "Not currently TP walking.", 2)
		return
	end
	tpwalking = false
	notif("Kruel", "Stopped TP walking.", 2)
	return
end)
addcmd("spook", "Scares a player by teleporting infront of them for half a second.", function(args)
	local target = findplr(args[1])[1]
	if not target then
		return
	end
	local hrp = p.Character.HumanoidRootPart
	local backcf = hrp.CFrame + hrp.CFrame.lookVector
	local targethrp = target.Character.HumanoidRootPart
	hrp.CFrame = targethrp.CFrame * CFrame.new(0, 0, -2)
	hrp.CFrame = CFrame.lookAt(hrp.Position, targethrp.Position)
	task.wait(0.5)
	hrp.CFrame = backcf
end)
addcmd("quickspook", "Scares a player by teleporting infront of them for tenth of a second.", function(args)
	local target = findplr(args[1])[1]
	if not target then
		return
	end
	local hrp = p.Character.HumanoidRootPart
	local backcf = hrp.CFrame + hrp.CFrame.lookVector
	local targethrp = target.Character.HumanoidRootPart
	hrp.CFrame = targethrp.CFrame * CFrame.new(0, 0, -2)
	hrp.CFrame = CFrame.lookAt(hrp.Position, targethrp.Position)
	task.wait(0.1)
	hrp.CFrame = backcf
end)
addcmd("lookat", "Looks at a player", function(args)
	local target = findplr(args[1])[1]
	if not target then
		return
	end
	if
		not p.Character
		or not p.Character:FindFirstChild("HumanoidRootPart")
		or not target.Character
		or not target.Character:FindFirstChild("HumanoidRootPart")
	then
		return
	end
	local hrp = p.Character.HumanoidRootPart
	hrp.CFrame = CFrame.lookAt(hrp.Position, target.Character.HumanoidRootPart.Position)
end)
addcmd("gravity", "Changes gravity.", function(args)
	local grav = tonumber(args[1])
	workspace.Gravity = grav
end)
local plrconn = nil
addcmd("listen", "Listens to properties Added event.", function(args)
	local target = tostring(args[1] or ""):lower()
	local mode = tostring(args[2] or ""):lower()
	if target == "players" and (mode == "added" or mode == "joined" or mode == "join") then
		local plrconn = players.PlayerAdded:Connect(function(plr)
			print("Player added: " .. (plr.Name or plr.DisplayName))
		end)
		notif("Kruel", "Listening to PlayerAdded events.", 3)
	elseif target == "players" and (mode == "left" or mode == "removing" or mode == "leave") then
		plrconn = players.PlayerRemoving:Connect(function(plr)
			print("Player left: " .. (plr.DisplayName or plr.Name))
		end)
		notif("Kruel", "Listening to PlayerRemoving events.", 3)
	end
end)
addcmd("unlisten", "Stop listening for PlayerAdded/Removing events.", function()
	if plrconn then
		plrconn:Disconnect()
		notif("Kruel", "Stopped listening.", 3)
	end
end)
local antifling = nil
local antiflingcharadded = {}
local antiflingdescadded = {}
addcmd("antifling", "Prevents you from getting flung.", function()
	if antifling then
		antifling:Disconnect()
		antifling = nil
	end
	for _, conn in pairs(antiflingcharadded) do
		conn:Disconnect()
	end
	for _, conn in pairs(antiflingdescadded) do
		conn:Disconnect()
	end
	antiflingcharadded = {}
	antiflingdescadded = {}
	local function setuppart(v)
		if v:IsA("BasePart") then
			task.spawn(function()
				while task.wait() do
					pcall(function()
						v.CanCollide = false
						v.CanTouch = false
					end)
				end
			end)
		end
	end

	local function setupchar(char)
		task.spawn(function()
			char:WaitForChild("HumanoidRootPart", 5)
			for _, v in pairs(char:GetDescendants()) do
				setuppart(v)
			end
			local descadded = char.DescendantAdded:Connect(function(v)
				setuppart(v)
			end)
			table.insert(antiflingdescadded, descadded)
		end)
	end

	for _, player in pairs(players:GetPlayers()) do
		if player ~= p and player.Character then
			setupchar(player.Character)
		end
		antiflingcharadded[player] = player.CharacterAdded:Connect(setupchar)
	end

	antifling = players.PlayerAdded:Connect(function(player)
		antiflingcharadded[player] = player.CharacterAdded:Connect(setupchar)
	end)
end)
newflinging = false
addcmd({ "void", "kill" }, "New fling", function(args)
	local trgts = findplr(args[1])
	newflinging = true
	for _, trgt in pairs(trgts) do
		if not newflinging then
			break
		end
		if trgt == p then
			continue
		end

		local success = pcall(function()
			if
				not (
					trgt
					and trgt.Character
					and trgt.Character:FindFirstChild("HumanoidRootPart")
					and trgt.Character:FindFirstChild("Humanoid")
					and p.Character
					and p.Character:FindFirstChild("HumanoidRootPart")
				)
			then
				return
			end

			if trgt.Character.Humanoid.SeatPart ~= nil then
				local seat = trgt.Character.Humanoid.SeatPart
				if seat.Anchored and seat.AssemblyLinearVelocity.Magnitude < 1 then
					notif("Kruel", trgt.Name .. " is sitting on anchored seat, cannot voidfling.", 3)
					return
				end
			end

			exec("unwalkfling")
			exec("antisit")
			exec("antitrip")
			local hrp = p.Character.HumanoidRootPart
			local part = trgt.Character.HumanoidRootPart
			p.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
			local tc = tick()
			local orgpos = hrp.CFrame
			local fallenparts = workspace.FallenPartsDestroyHeight
			local char = p.Character
			workspace.FallenPartsDestroyHeight = 0 / 0
			local orgsub = workspace.CurrentCamera.CameraSubject
			workspace.CurrentCamera.CameraSubject = part.Parent.Humanoid
			local hum = p.Character.Humanoid

			local velhist = {}
			local accelhist = {}
			local yhist = {}
			local histsize = 4
			local hum = p.Character.Humanoid
			local orghipheight = hum.HipHeight
			local trgthum = trgt.Character.Humanoid
			local expecteddt = 1 / math.max(240, 30)
			local lastvel = part.AssemblyLinearVelocity
			local lasttime = tick()
			local lasty = part.Position.Y

			local hasdied = false
			local diedconn = trgt.Character.Humanoid.Died:Connect(function()
				hasdied = true
			end)
			local remconn = trgt.CharacterRemoving:Connect(function()
				hasdied = true
			end)

			repeat
				local dtstart = tick()
				rs.Heartbeat:Wait()
				local dt = tick() - dtstart
				dt = math.clamp(dt, expecteddt * 0.5, expecteddt * 4)
				if not newflinging or not part or not part.Parent or not p.Character or not hrp or not hrp.Parent then
					break
				end

				local curvel = part.AssemblyLinearVelocity
				local curtime = tick()
				local cury = part.Position.Y
				local accel = (curvel - lastvel) / math.max(curtime - lasttime, 0.001)
				local yvel = (cury - lasty) / math.max(curtime - lasttime, 0.001)

				table.insert(velhist, Vector3.new(curvel.X, 0, curvel.Z))
				if #velhist > histsize then
					table.remove(velhist, 1)
				end

				table.insert(accelhist, Vector3.new(accel.X, 0, accel.Z))
				if #accelhist > histsize then
					table.remove(accelhist, 1)
				end

				table.insert(yhist, yvel)
				if #yhist > histsize then
					table.remove(yhist, 1)
				end

				local avgvl = Vector3.zero
				for _, v in pairs(velhist) do
					avgvl += v
				end
				avgvl /= #velhist

				local avgaccel = Vector3.zero
				for _, a in pairs(accelhist) do
					avgaccel += a
				end
				avgaccel /= #accelhist

				local avgyvel = 0
				for _, y in pairs(yhist) do
					avgyvel += y
				end
				avgyvel /= #yhist

				local accelchange = (accel - avgaccel).Magnitude
				local jumpthreshold = trgthum.JumpPower * 0.6
				local isjumping = math.abs(avgyvel) > jumpthreshold or math.abs(yvel) > (jumpthreshold * 1.8)
				local accelthreshold = trgthum.WalkSpeed * 7.5
				local ischangingdir = accelchange > accelthreshold

				local speed = avgvl.Magnitude
				local walkspeed = trgthum.WalkSpeed
				local speedratio = speed / math.max(walkspeed, 0.1)

				local dynmin = math.clamp(0.18 + speedratio * 0.1, 0.18, 0.35)
				local dynmax = math.clamp(0.5 + speedratio * 0.25, 0.55, 1.0)
				local predmulti = math.clamp(speedratio, dynmin, dynmax)

				local lagoffset = math.max(dt - expecteddt, 0) * 3.5
				local pingcomp = lagoffset + dt * 1.8
				local lookahead = predmulti + pingcomp

				if isjumping then
					lookahead = lookahead * 0.5
					avgaccel = avgaccel * 0.15
				elseif ischangingdir then
					lookahead = lookahead * 0.5
					avgaccel = avgaccel * 0.3
				end

				local accelcomp = avgaccel * (lookahead * 0.45)
				local predictedvel = avgvl + accelcomp

				local targethalfh = part.Size.Y / 2
				local myhalfh = hrp.Size.Y / 2
				local yoffset = targethalfh - myhalfh + 1.15

				if isjumping then
					yoffset = yoffset + (avgyvel * lookahead * 0.15)
				end
				local flatpos = (part.CFrame + (predictedvel * lookahead)).Position
				local predicted = CFrame.new(flatpos.X, part.Position.Y + yoffset, flatpos.Z)
				hrp.CFrame = predicted
				hrp.AssemblyLinearVelocity = Vector3.new(0, math.random(-5000000000, -1000000000), 0)
				hrp.AssemblyAngularVelocity = Vector3.new(0, math.random(-5000000000, -1000000000), 0)
				hum.HipHeight = hummhipheight or p.Character.Humanoid.HipHeight
				rs.Stepped:Wait()

				lastvel = curvel
				lasttime = curtime
				lasty = cury

			until (part.AssemblyLinearVelocity.Magnitude > 500)
				or hasdied
				or not newflinging
				or not part
				or not part.Parent
				or tick() - tc > 5

			if hrp and hrp.Parent then
				hrp.Anchored = true
				task.wait()
				task.wait()
			end
			exec("unantitrip")
			exec("unantisit")
			if hum then
				hum.HipHeight = orghipheight
			end
			if p.Character and p.Character.Humanoid then
				p.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			end
			if hrp and hrp.Parent then
				hrp.Velocity = Vector3.zero
				hrp.RotVelocity = Vector3.zero
				hrp.AssemblyLinearVelocity = Vector3.zero
				hrp.AssemblyAngularVelocity = Vector3.zero
				hrp.CFrame = orgpos
				hrp.Anchored = false
			end
			workspace.FallenPartsDestroyHeight = fallenparts
			local tasktospawn
			tasktospawn = task.spawn(function()
				for i = 1, 50 do
					exec("unview")
					rs.RenderStepped:Wait()
				end
			end)
			task.wait(0.01)
			task.cancel(tasktospawn)
			tasktospawn = nil
			if p.Character and p.Character.Humanoid then
				local hum = p.Character.Humanoid
				hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
				hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
				hum:ChangeState(Enum.HumanoidStateType.GettingUp)
				hum.PlatformStand = false
				hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
				hum:SetStateEnabled(Enum.HumanoidStateType.Running, true)
			end

			diedconn:Disconnect()
			remconn:Disconnect()
			task.spawn(function()
				task.wait(5)
				if hasdied then
					notif("Kruel", trgt.Name .. " is confirmed dead.", 2)
				else
					if not trgt.Character or not trgt.Character:FindFirstChild("HumanoidRootPart") then
						notif("Kruel", trgt.Name .. " is confirmed dead.", 2)
					elseif trgt.Character.Humanoid.Health <= 0 then
						notif("Kruel", trgt.Name .. " is confirmed dead.", 2)
					else
						notif("Kruel", trgt.Name .. " hasn't died.", 2)
					end
				end

				task.wait(0.1)
			end)
		end)

		if not success then
			task.wait(0.1)
		end
	end
	newflinging = false
end)
addcmd("stopvoid", "Stops voiding.", function()
	newflinging = false
end)

local loopvoid = {}
local loopvoidconns = {}

addcmd("loopvoid", "Voids someone in a loop.", function(args)
	for _, v in pairs(findplr(args[1])) do
		if v == p then
			continue
		end
		if loopvoid[v] then
			continue
		end

		local pos = p.Character.HumanoidRootPart.CFrame
		loopvoid[v] = true

		task.spawn(function()
			while loopvoid[v] and v.Parent do
				if not newflinging then
					exec("void " .. v.Name)
				end
				while newflinging do
					task.wait()
				end
				if not loopvoid[v] then
					break
				end

				task.wait(1)
				if not loopvoid[v] then
					break
				end

				pcall(function()
					p.Character.HumanoidRootPart.Velocity = Vector3.zero
					p.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
				end)
			end
		end)

		loopvoidconns[v] = v.CharacterAdded:Connect(function(char)
			if loopvoid[v] then
				char:WaitForChild("HumanoidRootPart")
				while newflinging do
					task.wait()
				end
				if loopvoid[v] then
					exec("void " .. v.Name)
				end
			end
		end)
	end
end)

addcmd("unloopvoid", "Stops loop void.", function()
	for v, _ in pairs(loopvoid) do
		loopvoid[v] = nil
	end
	for v, conn in pairs(loopvoidconns) do
		conn:Disconnect()
		loopvoidconns[v] = nil
	end
end)

-- loopfling
local loopfling = {}
local loopflingconns = {}

addcmd("loopfling", "Flings someone in a loop.", function(args)
	for _, v in pairs(findplr(args[1])) do
		if v == p then
			continue
		end
		if loopfling[v] then
			continue
		end

		local pos = p.Character.HumanoidRootPart.CFrame
		loopfling[v] = true

		task.spawn(function()
			while loopfling[v] and v.Parent do
				if not flinging then
					exec("fling " .. v.Name)
				end
				while flinging do
					task.wait()
				end
				if not loopfling[v] then
					break
				end

				task.wait(1)
				if not loopfling[v] then
					break
				end

				pcall(function()
					p.Character.HumanoidRootPart.Velocity = Vector3.zero
					p.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
					p.Character.HumanoidRootPart.CFrame = pos
				end)
			end
		end)

		loopflingconns[v] = v.CharacterAdded:Connect(function(char)
			if loopfling[v] then
				char:WaitForChild("HumanoidRootPart")
				while flinging do
					task.wait()
				end
				if loopfling[v] then
					exec("fling " .. v.Name)
				end
			end
		end)
	end
end)

addcmd("unloopfling", "Stops loop fling.", function()
	for v, _ in pairs(loopfling) do
		loopfling[v] = nil
	end
	for v, conn in pairs(loopflingconns) do
		conn:Disconnect()
		loopflingconns[v] = nil
	end
end)
addcmd("voidtool", "Gives you a void tool.", function()
	local tool = Instance.new("Tool")
	tool.RequiresHandle = false
	tool.Name = "Void Tool"
	tool.Parent = players.LocalPlayer.Backpack
	local mouse = players.LocalPlayer:GetMouse()
	tool.Activated:Connect(function()
		local hit = mouse.Target
		local hum = hit:FindFirstAncestorWhichIsA("Model")
		if hum then
			hum = hum:FindFirstChildWhichIsA("Humanoid")
		end
		if hum and hum.Parent:FindFirstChild("HumanoidRootPart") then
			exec("void " .. hum.Parent.Name)
		end
	end)
end)
local voidauraconn = nil
local voidingplayers = {}
local voidaurarange = 15

addcmd("voidaura", "Voids anyone near you.", function()
	if voidauraconn then
		voidauraconn:Disconnect()
	end
	voidauraconn = rs.Heartbeat:Connect(function()
		if newflinging then
			return
		end
		for i, v in pairs(players:GetPlayers()) do
			if v ~= p and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = v.Character.HumanoidRootPart
				local dist = (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude
				if dist < voidaurarange and not voidingplayers[v.UserId] then
					voidingplayers[v.UserId] = true
					task.spawn(function()
						exec("void " .. v.Name)
						while newflinging do
							task.wait()
						end
						task.wait(0.5)
						voidingplayers[v.UserId] = nil
					end)
					return
				end
			end
		end
	end)
end)

addcmd("voidaurarange", "Changes the range of the void aura.", function(args)
	voidaurarange = tonumber(args[1]) or 15
end)

addcmd("unvoidaura", "Stops the void aura.", function()
	if voidauraconn then
		voidauraconn:Disconnect()
		voidauraconn = nil
	end
	voidingplayers = {}
end)
local hitlering = false
addcmd("hitler", "Hitler salute tool.", function()
	local tool = Instance.new("Tool")
	tool.Name = "HITLER"
	tool.RequiresHandle = false
	tool.Parent = p:FindFirstChildOfClass("Backpack")
	local character = p.Character or p.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")

	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://698251653"
	local zz = humanoid:LoadAnimation(animation)
	zz.Looped = false

	local connection

	tool.Equipped:Connect(function()
		zz:Play()
		zz:AdjustSpeed(3)
		connection = game:GetService("RunService").Heartbeat:Connect(function()
			if zz.TimePosition >= 0.32 then
				zz:AdjustSpeed(0.01)
				zz.TimePosition = 0.32
			end
		end)
	end)

	tool.Unequipped:Connect(function()
		if zz.IsPlaying then
			zz:Stop()
		end

		if connection then
			connection:Disconnect()
			connection = nil
		end
	end)
end)
addcmd("flingui", "Opens the fling ui.", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Veaquach/kruel/refs/heads/main/flingui"))()
end)
rocketing = false
addcmd("rocket", "Rocket someone up.", function(args)
	local trgt = findplr(args[1])[1]
	if trgt == p then
		return
	end
	if trgt and trgt.Character and trgt.Character.HumanoidRootPart and p.Character and p.Character.HumanoidRootPart then
		local hrp = p.Character.HumanoidRootPart
		local part = trgt.Character.HumanoidRootPart
		local tc = tick()
		rocketing = true
		local orgpos = hrp.CFrame
		local fallenparts = workspace.FallenPartsDestroyHeight
		local char = p.Character
		workspace.FallenPartsDestroyHeight = 0 / 0
		local orgsub = workspace.CurrentCamera.CameraSubject
		workspace.CurrentCamera.CameraSubject = part.Parent.Humanoid
		exec("walkfling")
		exec("antitrip")
		local orgmasses = {}
		for _, v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				orgmasses[v] = v.AssemblyMass
				v.Massless = true
			end
		end

		local velhist = {}
		local histsize = 3

		repeat
			rs.Heartbeat:Wait()

			table.insert(velhist, part.AssemblyLinearVelocity)
			if #velhist > histsize then
				table.remove(velhist, 1)
			end
			local avgvl = Vector3.zero
			for _, v in pairs(velhist) do
				avgvl += v
			end
			avgvl /= #velhist

			local speed = avgvl.Magnitude
			local predmulti = math.clamp(speed / trgt.Character.Humanoid.WalkSpeed, 0.15, 0.45)

			local predicted = part.CFrame
			predicted += avgvl * predmulti
			char:PivotTo(predicted)

			hrp.Velocity = Vector3.new(0, 250, 0)
			hrp.RotVelocity = Vector3.new(250, 250, 250)
			hrp.AssemblyLinearVelocity = Vector3.new(0, 250, 0)
			hrp.AssemblyAngularVelocity = Vector3.new(250, 250, 250)

			for i = 1, 5 do
				hrp.CFrame = predicted * CFrame.new(0, -2, 0)
			end

		until part.AssemblyLinearVelocity.Magnitude > 75 or tick() - tc > 4

		rocketing = false

		for part, mass in pairs(orgmasses) do
			if part and part.Parent then
				part.Massless = false
			end
		end

		hrp.Anchored = true
		task.wait()
		exec("unwalkfling")
		exec("fly")
		task.wait()
		exec("unfly")
		exec("unantitrip")
		hrp.Velocity = Vector3.zero
		hrp.RotVelocity = Vector3.zero
		hrp.AssemblyLinearVelocity = Vector3.zero
		hrp.AssemblyAngularVelocity = Vector3.zero
		hrp.CFrame = orgpos
		hrp.Anchored = false
		workspace.FallenPartsDestroyHeight = fallenparts
		workspace.CurrentCamera.CameraSubject = orgsub
		task.wait(0.01)
		hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
		hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
		hum:ChangeState(Enum.HumanoidStateType.GettingUp)
		hum.PlatformStand = false
		hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
	end
end)
local supperrocketing = false
addcmd("superrocket", "Rocket someone up very high.", function(args)
	local trgts = findplr(args[1])
	supperrocketing = true
	for _, trgt in pairs(trgts) do
		print(trgt.Name)
		if not supperrocketing then
			break
		end
		if trgt == p then
			continue
		end

		local success = pcall(function()
			if
				not (
					trgt
					and trgt.Character
					and trgt.Character:FindFirstChild("HumanoidRootPart")
					and trgt.Character:FindFirstChild("Humanoid")
					and p.Character
					and p.Character:FindFirstChild("HumanoidRootPart")
				)
			then
				return
			end

			if trgt.Character.Humanoid.SeatPart ~= nil then
				local seat = trgt.Character.Humanoid.SeatPart
				if seat.Anchored and seat.AssemblyLinearVelocity.Magnitude < 1 then
					notif("Kruel", trgt.Name .. " is sitting on anchored seat, cannot voidfling.", 3)
					return
				end
			end

			exec("unwalkfling")
			exec("antisit")
			exec("antitrip")
			local hrp = p.Character.HumanoidRootPart
			local part = trgt.Character.HumanoidRootPart
			p.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
			local tc = tick()
			local orgpos = hrp.CFrame
			local fallenparts = workspace.FallenPartsDestroyHeight
			local char = p.Character
			workspace.FallenPartsDestroyHeight = 0 / 0
			local orgsub = workspace.CurrentCamera.CameraSubject
			workspace.CurrentCamera.CameraSubject = part.Parent.Humanoid
			local hum = p.Character.Humanoid

			local velhist = {}
			local accelhist = {}
			local yhist = {}
			local histsize = 4
			local hum = p.Character.Humanoid
			local orghipheight = hum.HipHeight
			local trgthum = trgt.Character.Humanoid
			local expecteddt = 1 / math.max(240, 30)
			local lastvel = part.AssemblyLinearVelocity
			local lasttime = tick()
			local lasty = part.Position.Y
			local hasdied = false
			local diedconn = trgt.Character.Humanoid.Died:Connect(function()
				hasdied = true
			end)
			local remconn = trgt.CharacterRemoving:Connect(function()
				hasdied = true
			end)

			repeat
				local dtstart = tick()
				rs.Heartbeat:Wait()
				local dt = tick() - dtstart
				dt = math.clamp(dt, expecteddt * 0.5, expecteddt * 4)
				if not supperrocketing or not part or not part.Parent or not p.Character or not hrp or not hrp.Parent then
					break
				end

				local curvel = part.AssemblyLinearVelocity
				local curtime = tick()
				local cury = part.Position.Y
				local accel = (curvel - lastvel) / math.max(curtime - lasttime, 0.001)
				local yvel = (cury - lasty) / math.max(curtime - lasttime, 0.001)

				table.insert(velhist, Vector3.new(curvel.X, 0, curvel.Z))
				if #velhist > histsize then
					table.remove(velhist, 1)
				end

				table.insert(accelhist, Vector3.new(accel.X, 0, accel.Z))
				if #accelhist > histsize then
					table.remove(accelhist, 1)
				end

				table.insert(yhist, yvel)
				if #yhist > histsize then
					table.remove(yhist, 1)
				end

				local avgvl = Vector3.zero
				for _, v in pairs(velhist) do
					avgvl += v
				end
				avgvl /= #velhist

				local avgaccel = Vector3.zero
				for _, a in pairs(accelhist) do
					avgaccel += a
				end
				avgaccel /= #accelhist

				local avgyvel = 0
				for _, y in pairs(yhist) do
					avgyvel += y
				end
				avgyvel /= #yhist

				local accelchange = (accel - avgaccel).Magnitude
				local jumpthreshold = trgthum.JumpPower * 0.6
				local isjumping = math.abs(avgyvel) > jumpthreshold or math.abs(yvel) > (jumpthreshold * 1.8)
				local accelthreshold = trgthum.WalkSpeed * 7.5
				local ischangingdir = accelchange > accelthreshold

				local speed = avgvl.Magnitude
				local walkspeed = trgthum.WalkSpeed
				local speedratio = speed / math.max(walkspeed, 0.1)

				local dynmin = math.clamp(0.18 + speedratio * 0.1, 0.18, 0.35)
				local dynmax = math.clamp(0.5 + speedratio * 0.25, 0.55, 1.0)
				local predmulti = math.clamp(speedratio, dynmin, dynmax)

				local lagoffset = math.max(dt - expecteddt, 0) * 3.5
				local pingcomp = lagoffset + dt * 1.8
				local lookahead = predmulti + pingcomp

				if isjumping then
					lookahead = lookahead * 0.5
					avgaccel = avgaccel * 0.15
				elseif ischangingdir then
					lookahead = lookahead * 0.5
					avgaccel = avgaccel * 0.3
				end

				local accelcomp = avgaccel * (lookahead * 0.45)
				local predictedvel = avgvl + accelcomp

				local targethalfh = part.Size.Y / 2
				local myhalfh = hrp.Size.Y / 2
				local yoffset = targethalfh - myhalfh - 1.15

				if isjumping then
					yoffset = yoffset + (avgyvel * lookahead * 0.15)
				end
				local flatpos = (part.CFrame + (predictedvel * lookahead)).Position
				local predicted = CFrame.new(flatpos.X, part.Position.Y + yoffset, flatpos.Z)
				hrp.CFrame = predicted
				local rng = Random.new()
				hrp.AssemblyLinearVelocity = Vector3.new(0, rng:NextInteger(1e9, 5e9), 0)
				hrp.AssemblyAngularVelocity = Vector3.new(0, rng:NextInteger(1e9, 5e9), 0)
				hum.HipHeight = hummhipheight or p.Character.Humanoid.HipHeight
				rs.Stepped:Wait()

				lastvel = curvel
				lasttime = curtime
				lasty = cury

			until (part.AssemblyLinearVelocity.Magnitude > 500)
				or hasdied
				or not supperrocketing
				or not part
				or not part.Parent
				or tick() - tc > 5

			if hrp and hrp.Parent then
				hrp.Anchored = true
				task.wait()
				task.wait()
			end
			exec("unantitrip")
			exec("unantisit")
			if hum then
				hum.HipHeight = orghipheight
			end
			if p.Character and p.Character.Humanoid then
				p.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			end
			if hrp and hrp.Parent then
				hrp.Velocity = Vector3.zero
				hrp.RotVelocity = Vector3.zero
				hrp.AssemblyLinearVelocity = Vector3.zero
				hrp.AssemblyAngularVelocity = Vector3.zero
				hrp.CFrame = orgpos
				hrp.Anchored = false
			end
			workspace.FallenPartsDestroyHeight = fallenparts
			local tasktospawn
			tasktospawn = task.spawn(function()
				for i = 1, 50 do
					exec("unview")
					rs.RenderStepped:Wait()
				end
			end)
			task.wait(0.01)
			task.cancel(tasktospawn)
			tasktospawn = nil
			if p.Character and p.Character.Humanoid then
				local hum = p.Character.Humanoid
				hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
				hum:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
				hum:ChangeState(Enum.HumanoidStateType.GettingUp)
				hum.PlatformStand = false
				hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
				hum:SetStateEnabled(Enum.HumanoidStateType.Running, true)
			end

			diedconn:Disconnect()
			remconn:Disconnect()
						task.spawn(function()
				task.wait(5)
				if hasdied then
					notif("Kruel", trgt.Name .. " is confirmed dead.", 2)
				else
					if not trgt.Character or not trgt.Character:FindFirstChild("HumanoidRootPart") then
						notif("Kruel", trgt.Name .. " is confirmed dead.", 2)
					elseif trgt.Character.Humanoid.Health <= 0 then
						notif("Kruel", trgt.Name .. " is confirmed dead.", 2)
					else
						notif("Kruel", trgt.Name .. " hasn't died.", 2)
					end
				end

				task.wait(0.1)
			end)
		end)

		if not success then
			task.wait(0.1)
		end
	end
	supperrocketing = false
end)
addcmd({ "freecam", "fc" }, "Lets you use freecam with Shift + P.", function()
	loadstring(game:HttpGet("https://pastebin.com/raw/TJB21Kxy"))()
	notif("Kruel", "Active! Press Shift + P to active.", 3)
end)
addcmd("unantifling", "Stops antifling.", function()
	if antifling then
		antifling:Disconnect()
		antifling = nil
	end
	for _, conn in pairs(antiflingcharadded) do
		conn:Disconnect()
	end
	for _, conn in pairs(antiflingdescadded) do
		conn:Disconnect()
	end
	antiflingcharadded = {}
	antiflingdescadded = {}
	for _, player in pairs(players:GetPlayers()) do
		if player ~= p and player.Character then
			for _, v in pairs(player.Character:GetDescendants()) do
				if v:IsA("BasePart") then
					pcall(function()
						v.CanCollide = true
						v.CanTouch = true
					end)
				end
			end
		end
	end
end)
addcmd({ "cmdcount", "commandcount" }, "Lists how much commands Kruel has. (Number)", function()
	notif("Kruel", "Commands: " .. cmdcount, 3)
end)
local dances = {
	"/e dance",
	"/e dance2",
	"/e dance3",
	"/e laugh",
	"/e cheer",
	"/e point",
	"/e wave",
}
-- bla bla bla
addcmd("antikillbrick", "Turns CanTouch to off on all parts", function()
	for _, part in pairs(workspace:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanTouch = false
		end
	end
end)
addcmd("dance", "Dances (only default animations, needs chat enabled)", function()
	local dancess = getrandomvalue(dances)
	notif("Tried to use " .. dancess)
	pcall(function()
		cloneref(game:GetService("TextChatService")).TextChannels.RBXGeneral:SendAsync(dancess)
	end)
end)
addcmd("rspy", "Remote Spy", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
end)
addcmd("spin", "Spins your character.", function(args)
	local speed = tonumber(args[1]) or 5
	if p.Character and p.Character.HumanoidRootPart then
		local hrp = p.Character.HumanoidRootPart
		local bv = Instance.new("BodyAngularVelocity")
		bv.AngularVelocity = Vector3.new(0, speed, 0)
		bv.Name = "Spin"
		bv.Parent = hrp
		bv.MaxTorque = Vector3.new(0, math.huge, 0)
	end
end)
local annoyconn = nil
addcmd("annoy", "Annoys a player.", function(args)
	local trgts = findplr(args[1])
	local trgt = trgts[1]
	if
		trgt ~= p
		and trgt.Character
		and trgt.Character.HumanoidRootPart
		and p.Character
		and p.Character.HumanoidRootPart
	then
		local hrp = p.Character.HumanoidRootPart
		local thrp = trgt.Character.HumanoidRootPart
		if not hrp or not thrp then
			return
		end
		local velhist = {}
		local histsize = 3
		annoyconn = rs.Heartbeat:Connect(function()
			table.insert(velhist, thrp.AssemblyLinearVelocity)
			if #velhist > histsize then
				table.remove(velhist, 1)
			end

			local avgvl = Vector3.zero
			for _, v in pairs(velhist) do
				avgvl += v
			end
			avgvl /= #velhist

			local speed = avgvl.Magnitude
			local predmulti = math.clamp(speed / trgt.Character.Humanoid.WalkSpeed, 0.15, 0.45)
			local predicted = thrp.CFrame + (avgvl * predmulti)
			hrp.CFrame = predicted * CFrame.Angles(math.random() > 0.3 and 90 or -135, 90, -180)
			hrp.AssemblyAngularVelocity = Vector3.new(math.random(0, 75), math.random(0, 75), math.random(0, 75))
			if thrp.AssemblyLinearVelocity.Magnitude > 100 then
				annoyconn:Disconnect()
			end
		end)
		notif("Kruel", "Annoying " .. trgt.Name .. ".", 3)
	end
end)
addcmd("unannoy", "Stops annoying a player.", function()
	if annoyconn then
		annoyconn:Disconnect()
		annoyconn = nil
		notif("Kruel", "Stopped annoying.", 3)
	end
end)
local semiannoyconn = nil
addcmd("semiannoy", "Annoys a player lightly.", function(args)
	local trgt = findplr(args[1])[1]
	if
		trgt ~= p
		and trgt.Character
		and trgt.Character.HumanoidRootPart
		and p.Character
		and p.Character.HumanoidRootPart
	then
		local hrp = p.Character.HumanoidRootPart
		local thrp = trgt.Character.HumanoidRootPart
		if not hrp or not thrp then
			return
		end
		exec("view " .. trgt.Name)
		semiannoyconn = rs.Heartbeat:Connect(function()
			local predicted = thrp.CFrame
			predicted += Vector3.new(0, thrp.AssemblyLinearVelocity.Y, 0) * 0.2152321
			predicted += (Vector3.new(thrp.AssemblyLinearVelocity.X, 0, thrp.AssemblyLinearVelocity.Z) / 2.152321)
			hrp.CFrame = predicted * CFrame.new(math.random(-1.5, 1.5), math.random(-0.5, 0.5), math.random(-1.5, 1.5))
		end)
	end
end)
addcmd("unsemiannoy", "Stops lightly annoying a player.", function()
	if semiannoyconn then
		semiannoyconn:Disconnect()
		semiannoyconn = nil
	end
	exec("unview")
end)
local sitconn = nil
local orbitangle = 0.05
local orbitradius = 5
local jumpsitconn = nil
local orbitconn = nil
local orbitheight = 8.5
addcmd("orbit", "Orbits around a player.", function(args)
	local trgts = findplr(args[1])
	local trgt = trgts[1]
	local rotangle = 0

	if
		trgt ~= p
		and trgt.Character
		and trgt.Character.HumanoidRootPart
		and p.Character
		and p.Character.HumanoidRootPart
	then
		p.Character.Humanoid.Sit = false
		p.Character.Humanoid.PlatformStand = true
		exec("noclip")

		local velhist = {}
		local accelhist = {}
		local yhist = {}
		local histsize = 4
		local expecteddt = 1 / math.max(getfpscap(), 30)
		local lastvel = trgt.Character.HumanoidRootPart.AssemblyLinearVelocity
		local lasttime = tick()
		local lasty = trgt.Character.HumanoidRootPart.Position.Y

		orbitconn = rs.Heartbeat:Connect(function()
			local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
			local part = trgt.Character and trgt.Character:FindFirstChild("HumanoidRootPart")

			if not part or not hrp or not trgt.Character or not p.Character then
				if orbitconn then
					orbitconn:Disconnect()
				end
				exec("clip")
				p.Character.Humanoid.PlatformStand = false
				for i = 1, 5 do
					p.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
				end
				hrp.Velocity = Vector3.zero
				return
			end

			local dtstart = tick()
			local dt = tick() - dtstart
			dt = math.clamp(dt, expecteddt * 0.5, expecteddt * 4)

			local curvel = part.AssemblyLinearVelocity
			local curtime = tick()
			local cury = part.Position.Y
			local accel = (curvel - lastvel) / math.max(curtime - lasttime, 0.001)
			local yvel = (cury - lasty) / math.max(curtime - lasttime, 0.001)

			table.insert(velhist, Vector3.new(curvel.X, 0, curvel.Z))
			if #velhist > histsize then
				table.remove(velhist, 1)
			end

			table.insert(accelhist, Vector3.new(accel.X, 0, accel.Z))
			if #accelhist > histsize then
				table.remove(accelhist, 1)
			end

			table.insert(yhist, yvel)
			if #yhist > histsize then
				table.remove(yhist, 1)
			end

			local avgvl = Vector3.zero
			for _, v in pairs(velhist) do
				avgvl += v
			end
			avgvl /= #velhist

			local avgaccel = Vector3.zero
			for _, a in pairs(accelhist) do
				avgaccel += a
			end
			avgaccel /= #accelhist

			local avgyvel = 0
			for _, y in pairs(yhist) do
				avgyvel += y
			end
			avgyvel /= #yhist

			local accelchange = (accel - avgaccel).Magnitude
			local isjumping = math.abs(avgyvel) > 8 or math.abs(yvel) > 12
			local ischangingdir = accelchange > 120

			local speed = avgvl.Magnitude
			local walkspeed = trgt.Character.Humanoid.WalkSpeed
			local speedratio = speed / math.max(walkspeed, 0.1)

			local dynmin = math.clamp(0.18 + speedratio * 0.1, 0.18, 0.35)
			local dynmax = math.clamp(0.5 + speedratio * 0.25, 0.55, 1.0)
			local predmulti = math.clamp(speedratio, dynmin, dynmax)

			local lagoffset = math.max(dt - expecteddt, 0) * 3.5
			local pingcomp = lagoffset + dt * 1.8
			local lookahead = predmulti + pingcomp

			if isjumping then
				lookahead = lookahead * 1.4
				avgaccel = avgaccel * 0.6
			elseif ischangingdir then
				lookahead = lookahead * 0.5
				avgaccel = avgaccel * 0.3
			end

			local accelcomp = avgaccel * (lookahead * 0.45)
			local predictedvel = avgvl + accelcomp

			local flatpos = (part.CFrame + (predictedvel * lookahead)).Position
			local predictedpos = Vector3.new(flatpos.X, part.Position.Y, flatpos.Z)

			local offset = Vector3.new(
				math.cos(rotangle) * orbitradius,
				math.sin(rotangle) * orbitheight + 5,
				math.sin(rotangle) * orbitradius
			)

			local newpos = predictedpos + offset
			hrp.CFrame = CFrame.new(newpos, predictedpos)
			hrp.Velocity = Vector3.zero
			hrp.RotVelocity = Vector3.zero

			rotangle = rotangle + orbitangle

			lastvel = curvel
			lasttime = curtime
			lasty = cury
		end)
	end
end)
addcmd("orbitradius", "Changes orbit radius.", function(args)
	orbitradius = tonumber(args[1]) or 5
end)
addcmd("orbitspeed", "Changes orbit speed.", function(args)
	orbitangle = tonumber(args[1]) * 0.01 or 0.05
end)
addcmd("orbitheight", "Changes how far you go down/up while orbiting.", function(args)
	orbitheight = tonumber(args[1]) or 8.5
end)
addcmd("unorbit", "Stops orbiting.", function()
	if orbitconn then
		orbitconn:Disconnect()
	end
	exec("clip")
	p.Character.Humanoid.PlatformStand = false
	for i = 1, 5 do
		p.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end
	p.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
end)
addcmd("jobid", "Copies Server link to clipboard.", function()
	setclipboard(("roblox://placeId=%s&gameInstanceId=%s"):format(game.PlaceId, game.JobId))
end)
addcmd("mm2", "Loads a in-development Murder Murder Mystery 2 script.", function()
	if game.PlaceId ~= 142823291 then
		return
	end
	loadstring(
		game:HttpGet("https://raw.githubusercontent.com/justkittybro/apocHub/refs/heads/main/eclipsehubreborn", true)
	)()
end)
addcmd("mm22", "Loads a Murder Mystery 2 script.", function()
	if game.PlaceId ~= 142823291 then
		return
	end
	loadstring(game:HttpGet("https://raw.githubusercontent.com/thunderXhub/ThunderXHUB/refs/heads/main/loader"))()
	notif("Kruel", "Please also try ;mm2, it's a new script in development.", 3)
end)
addcmd("headsit", "Headsit", function(args)
	local trgts = findplr(args[1])
	local trgt = trgts[1]
	if trgt ~= p and trgt.Character and trgt.Character.Head and p.Character and p.Character.HumanoidRootPart then
		if sitconn then
			sitconn:Disconnect()
		end
		if jumpsitconn then
			jumpsitconn:Disconnect()
		end
		exec("noclip")

		local velhist = {}
		local accelhist = {}
		local yhist = {}
		local histsize = 4
		local hum = trgt.Character.Humanoid
		local expecteddt = 1 / math.max(getfpscap(), 30)
		local lastvel = trgt.Character.Head.AssemblyLinearVelocity
		local lasttime = tick()
		local lasty = trgt.Character.Head.Position.Y

		jumpsitconn = uis.InputBegan:Connect(function(input, gpe)
			if gpe then
				return
			end
			local head = trgt.Character.Head
			local hrp = p.Character.HumanoidRootPart
			if input.KeyCode == Enum.KeyCode.Space then
				sitconn:Disconnect()
				hrp.CFrame = head.CFrame * CFrame.new(0, 2, 0)
				p.Character.Humanoid.Sit = false
				exec("clip")
				jumpsitconn:Disconnect()
			end
		end)

		local head = trgt.Character.Head
		local hrp = p.Character.HumanoidRootPart
		hrp.CFrame = head.CFrame * CFrame.new(0, 2, 0)
		sitconn = rs.Heartbeat:Connect(function()
			if
				trgt.Character
				and trgt.Character:FindFirstChild("Head")
				and p.Character
				and p.Character:FindFirstChild("HumanoidRootPart")
			then
				local dtstart = tick()
				local head = trgt.Character.Head
				local hrp = p.Character.HumanoidRootPart
				p.Character.Humanoid.Sit = true

				local dt = tick() - dtstart
				dt = math.clamp(dt, expecteddt * 0.5, expecteddt * 4)

				local curvel = head.AssemblyLinearVelocity
				local curtime = tick()
				local cury = head.Position.Y
				local accel = (curvel - lastvel) / math.max(curtime - lasttime, 0.001)
				local yvel = (cury - lasty) / math.max(curtime - lasttime, 0.001)

				table.insert(velhist, Vector3.new(curvel.X, curvel.Y, curvel.Z))
				if #velhist > histsize then
					table.remove(velhist, 1)
				end

				table.insert(accelhist, Vector3.new(accel.X, accel.Y, accel.Z))
				if #accelhist > histsize then
					table.remove(accelhist, 1)
				end

				table.insert(yhist, yvel)
				if #yhist > histsize then
					table.remove(yhist, 1)
				end

				local avgvl = Vector3.zero
				for _, v in pairs(velhist) do
					avgvl += v
				end
				avgvl /= #velhist

				local avgaccel = Vector3.zero
				for _, a in pairs(accelhist) do
					avgaccel += a
				end
				avgaccel /= #accelhist

				local avgyvel = 0
				for _, y in pairs(yhist) do
					avgyvel += y
				end
				avgyvel /= #yhist

				local accelchange = (accel - avgaccel).Magnitude
				local jumpthreshold = hum.JumpPower * 0.6
				local isjumping = math.abs(avgyvel) > jumpthreshold or math.abs(yvel) > (jumpthreshold * 1.8)
				local accelthreshold = hum.WalkSpeed * 7.5
				local ischangingdir = accelchange > accelthreshold

				local speed = avgvl.Magnitude
				local walkspeed = hum.WalkSpeed
				local speedratio = speed / math.max(walkspeed, 0.1)

				local basepredmin = 0.05
				local basepredmax = 0.15
				local speedinfluence = 0.03
				local maxspeedinfluence = 0.08

				local dynmin =
					math.clamp(basepredmin + speedratio * speedinfluence, basepredmin, basepredmin + speedinfluence * 2)
				local dynmax = math.clamp(
					basepredmax + speedratio * maxspeedinfluence,
					basepredmax + maxspeedinfluence * 0.5,
					basepredmax + maxspeedinfluence * 2
				)
				local predmulti = math.clamp(speedratio, dynmin, dynmax)

				local lagmultiplier = 1.5
				local pingmultiplier = 0.8
				local lagoffset = math.max(dt - expecteddt, 0) * lagmultiplier
				local pingcomp = lagoffset + dt * pingmultiplier
				local lookahead = predmulti + pingcomp
				local jumplookaheadmulti = 0.5
				local jumpacceldamp = 0.15
				local dirlookaheadmulti = 0.4
				local diracceldamp = 0.2

				if isjumping then
					lookahead = lookahead * jumplookaheadmulti
					avgaccel = avgaccel * jumpacceldamp
				elseif ischangingdir then
					lookahead = lookahead * dirlookaheadmulti
					avgaccel = avgaccel * diracceldamp
				end

				local accelweight = 0.25
				local accelcomp = avgaccel * (lookahead * accelweight)
				local predictedvel = avgvl + accelcomp

				local headsizey = head.Size.Y / 2
				local hrpsizey = hrp.Size.Y / 2
				local basegap = 0.2
				local offset = headsizey + hrpsizey + basegap

				if isjumping then
					local yvelweight = 0.15
					offset = offset + (avgyvel * lookahead * yvelweight)
				end

				local flatpos = (head.CFrame + (predictedvel * lookahead)).Position
				local predicted = head.CFrame * CFrame.new(0, offset, 0)
				predicted = CFrame.new(flatpos.X, flatpos.Y + offset, flatpos.Z) * (head.CFrame - head.CFrame.Position)

				hrp.CFrame = predicted
				hrp.Velocity = Vector3.new(0, 0, 0)
				hrp.RotVelocity = Vector3.new(0, 0, 0)

				lastvel = curvel
				lasttime = curtime
				lasty = cury
			else
				if sitconn then
					sitconn:Disconnect()
				end
				if jumpsitconn then
					jumpsitconn:Disconnect()
				end
				exec("clip")
				p.Character.Humanoid.Sit = false
			end
		end)
	else
		notif("Kruel", "Target player is either dead, not found, or is you.", 3)
	end
end)
addcmd("unspin", "Stop spinning.", function()
	for _, v in pairs(players.LocalPlayer.Character:GetDescendants()) do
		if v.Name == "Spin" then
			v:Destroy()
		end
	end
end)
addcmd("copypos", "Copies your position to clipboard.", function()
	if p.Character and p.Character.HumanoidRootPart then
		local pos = p.Character.HumanoidRootPart.Position
		setclipboard(tostring(pos.X) .. ", " .. tostring(pos.Y) .. ", " .. tostring(pos.Z))
		notif("Kruel", "Position copied to clipboard.", 3)
	end
end)
local credits = false
addcmd("credits", "Roll the credits!", function()
	if credits == true then
		return
	end
	credits = true
	local frs = Instance.new("Frame")
	frs.BackgroundTransparency = 0
	frs.Parent = psg
	frs.Position = UDim2.new(0.5, -20, 0.5, -20)
	frs.ZIndex = 999
	local logo = Instance.new("ImageLabel")
	logo.Name = "KruelIcon"
	logo.BackgroundTransparency = 1
	logo.Position = UDim2.new(0, 0, 0, 0)
	logo.ZIndex = 12
	logo.Size = UDim2.new(0, 256, 0, 256)
	logo.Image = "rbxassetid://130500547668668"
	logo.ImageTransparency = 1
	logo.Parent = frs
	local txl = Instance.new("TextLabel")
	txl.Text = "Kruel — a project made with love.\nMade by: @veaquach on discord."
	txl.TextColor3 = Color3.fromRGB(165, 165, 165)
	txl.TextTransparency = 1
	txl.Position = UDim2.new(0, 125, 0, 225)
	txl.BackgroundTransparency = 1
	txl.Parent = frs
	txl.Font = Enum.Font.GothamBold
	txl.TextSize = 20
	ts:Create(logo, ti, { ImageTransparency = 0 }):Play()
	task.wait(1)
	ts:Create(logo, ti, { Position = UDim2.new(0, 0, 0, -50) }):Play()
	task.wait(0.5)
	ts:Create(txl, ti, { TextTransparency = 0 }):Play()
	task.wait(5)
	ts:Create(txl, ti, { TextTransparency = 1 }):Play()
	task.wait(1)
	ts:Create(logo, ti, { Position = UDim2.new(0, 0, 0, 0) }):Play()
	task.wait(1)
	ts:Create(logo, ti, { ImageTransparency = 1 }):Play()
	task.wait(0.9)
	frs:Destroy()
	credits = false
end)

-- hardcoded binds cuz ez its private script so idc enough to make bind command work 🤣 wow anyone seeing this is cool ez its not private anymore but i still dk if ill make it date: 1/30/2026 today
uis.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	if psg:FindFirstChildOfClass("TextBox") and psg.TextBox:IsFocused() then
		return
	end
	local e = input.UserInputType
	local ee = input.KeyCode
	local e2 = Enum.KeyCode
	local e3 = Enum.UserInputType
	if ee == e2.Y then
		exec("fly")
	end
end)
local frr = Instance.new("Frame")
frr.Size = UDim2.new(0, 350, 0, 500)
frr.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frr.Position = UDim2.new(0.5, -175, 0.5, -250)
frr.Parent = psg
frr.Visible = false
local cmdss = {}
local count = 0
for _, data in pairs(cmds) do
	if not cmdss[data.Button] then
		cmdss[data.Button] = true
		count = count + 1
	end
end
countt = count
local drgfr = Instance.new("Frame")
drgfr.Position = UDim2.new(0, 0, 0, 0)
drgfr.Size = UDim2.new(1, 0, 0, 20)
drgfr.BackgroundColor3 = theme.Title
drgfr.Parent = frr
local mlogoo = Instance.new("ImageLabel")
mlogoo.Name = "KruelIconn"
mlogoo.BackgroundTransparency = 1
mlogoo.Position = UDim2.new(0.025, 0, 0, 0)
mlogoo.ZIndex = 12
mlogoo.Size = UDim2.new(0, 25, 0, 19)
mlogoo.Image = "rbxassetid://130500547668668"
mlogoo.Parent = drgfr
local gradd = Instance.new("UIGradient")
gradd.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, theme.Title),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180)),
})
gradd.Parent = drgfr
local cmdtitle = Instance.new("TextLabel")
cmdtitle.Text = "Commands - " .. cmdcount
cmdtitle.Font = Enum.Font.GothamBold
cmdtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
cmdtitle.TextSize = 16
cmdtitle.Size = UDim2.new(1, 0, 1, 0)
cmdtitle.Position = UDim2.new(0, 0, 0, 0)
cmdtitle.BackgroundTransparency = 1
cmdtitle.Parent = drgfr

local grad3 = Instance.new("UIGradient")
grad3.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(115, 115, 115)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180)),
})
grad3.Parent = cmdtitle
local fr2 = Instance.new("ScrollingFrame")
fr2.Size = UDim2.new(0, 350, 0, 480)
fr2.Position = UDim2.new(0, 0, 0, 20)
fr2.ScrollBarThickness = 0
fr2.AutomaticCanvasSize = Enum.AutomaticSize.Y
fr2.CanvasSize = UDim2.new(0, 0, 0, 0)
fr2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
fr2.Parent = frr
fr2.ClipsDescendants = true

local fr2list = Instance.new("UIListLayout")
fr2list.Parent = fr2
fr2list.SortOrder = Enum.SortOrder.LayoutOrder
fr2list.Padding = UDim.new(0, 5)
local function addcmds(name, desc, func)
	local display
	if typeof(name) == "table" then
		display = name[1]
		if #name > 1 then
			display ..= " (" .. table.concat({ select(2, unpack(name)) }, ", ") .. ")"
		end
	else
		display = name
	end

	local cmdbtn = Instance.new("TextButton")
	cmdbtn.Size = UDim2.new(1, 0, 0, 50)
	cmdbtn.TextXAlignment = Enum.TextXAlignment.Left
	cmdbtn.TextYAlignment = Enum.TextYAlignment.Top
	cmdbtn.Text = "  " .. display
	cmdbtn.Font = Enum.Font.GothamBold
	cmdbtn.TextSize = 19
	cmdbtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	cmdbtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	cmdbtn.Parent = fr2
	cmdbtn.AutomaticSize = Enum.AutomaticSize.Y

	local descttl = Instance.new("TextLabel")
	descttl.Size = UDim2.new(1, -10, 0, 0)
	descttl.Position = UDim2.new(0, 5, 0, 25)
	descttl.TextWrapped = true
	descttl.AutomaticSize = Enum.AutomaticSize.Y
	descttl.Text = desc
	descttl.Font = Enum.Font.Gotham
	descttl.TextSize = 14
	descttl.BackgroundTransparency = 1
	descttl.TextColor3 = Color3.fromRGB(0, 0, 0)
	descttl.TextXAlignment = Enum.TextXAlignment.Left
	descttl.TextYAlignment = Enum.TextYAlignment.Top
	descttl.Parent = cmdbtn

	local grad2 = Instance.new("UIGradient")
	grad2.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 75, 75)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(195, 195, 195)),
	})

	local crnr = Instance.new("UICorner")
	crnr.CornerRadius = UDim.new(0, 7)
	crnr.Parent = cmdbtn
	grad2.Parent = cmdbtn

	cmdbtn.MouseButton1Click:Connect(function()
		func({})
	end)
end

local paddingg = Instance.new("UIPadding")
paddingg.Parent = fr2
paddingg.PaddingLeft = UDim.new(0, 10)
paddingg.PaddingRight = UDim.new(0, 10)
paddingg.PaddingTop = UDim.new(0, 10)
paddingg.PaddingBottom = UDim.new(0, 10)
gradd.Parent = drgfr
local mnbtn = Instance.new("TextButton")
mnbtn.Size = UDim2.new(0, 35, 0, 20)
mnbtn.Position = UDim2.new(0, 315, 0, 0)
mnbtn.Text = "X"
mnbtn.Font = Enum.Font.GothamBold
mnbtn.TextSize = 19
mnbtn.BackgroundTransparency = 1
mnbtn.TextColor3 = Color3.fromRGB(155, 155, 155)
mnbtn.Parent = drgfr
local clbtn = Instance.new("TextButton")
clbtn.Size = UDim2.new(0, 35, 0, 20)
clbtn.Position = UDim2.new(0, 285, 0, 0.5)
clbtn.Text = "^"
clbtn.Font = Enum.Font.GothamBold
clbtn.TextSize = 30
clbtn.BackgroundTransparency = 1
clbtn.TextColor3 = Color3.fromRGB(155, 155, 155)
clbtn.Parent = drgfr
local tss = game:GetService("TweenService")
local tiii = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
clbtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		if frr.Size == UDim2.new(0, 350, 0, 500) then
			tss:Create(frr, tiii, { Size = UDim2.new(0, 350, 0, 0) }):Play()
			tss:Create(fr2, tiii, { Size = UDim2.new(0, 350, 0, 0) }):Play()
			tss:Create(clbtn, tiii, { Rotation = 180 }):Play()
		else
			tss:Create(frr, tiii, { Size = UDim2.new(0, 350, 0, 500) }):Play()
			tss:Create(fr2, tiii, { Size = UDim2.new(0, 350, 0, 500) }):Play()
			tss:Create(clbtn, tiii, { Rotation = 0 }):Play()
		end
	end
end)
mnbtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		tss:Create(frr, tiii, { Position = UDim2.new(0, frr.Position.X.Offset, 0, -1000) }):Play()
	end
end)
local draggingg = false
local dragStartt
local startPoss
drgfr.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingg = true
		-- yayyyy line 2000 woohoo yay my biggest project (already was ez) to anyone seeing this: <3 (idk if this is line 2000 anymore maybe i update when i need to maybe not ezz) ts is line 2114 now wow
		dragStartt = input.Position
		startPoss = frr.Position
	end
end)

drgfr.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		draggingg = false
	end
end)
local UIS = cloneref(game:GetService("UserInputService"))
UIS.InputChanged:Connect(function(input)
	if
		draggingg and input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	then
		local delta = input.Position - dragStartt
		ts:Create(frr, tii, {
			Position = UDim2.new(
				startPoss.X.Scale,
				startPoss.X.Offset + delta.X,
				startPoss.Y.Scale,
				startPoss.Y.Offset + delta.Y
			),
		}):Play()
	end
end)
addcmd({ "cmds", "help" }, "Lists all commands.", function()
	if frr.Visible == true then
		frr.Visible = false
		return
	end
	frr.Position = UDim2.new(0.5, -175, 0.5, -250)
	frr.Visible = true
end)
addcmd("freeze", "Freezes you in place.", function()
	local char = p.Character
	if not char then
		return
	end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp or not char then
		return
	end
	hrp.Anchored = true
end)
addcmd("unfreeze", "Stops freeze.", function()
	local char = p.Character
	if not char then
		return
	end
	local hrp = char.HumanoidRootPart
	if not hrp or not char then
		return
	end
	hrp.Anchored = false
end)
for cmdName, cmdData in pairs(cmds) do
	local alreadyAdded = false
	for otherName, otherData in pairs(cmds) do
		if otherData.Button == cmdData.Button and otherName < cmdName then
			alreadyAdded = true
			break
		end
	end
	if not alreadyAdded then
		local allNames = {}
		for name, data in pairs(cmds) do
			if data.Button == cmdData.Button then
				table.insert(allNames, name)
			end
		end

		table.sort(allNames)

		addcmds(allNames, cmdData.Description, cmdData.Function)
	end
end
local timetoload = os.clock() - start
-- a little bit of flexing optimization flexing here
local ccu = heartbeat()
notif(
	"Kruel",
	"Kruel Admin loaded, please consider joining our server! (;discord)\nLoading time: "
		.. string.format("%.4f", timetoload)
		.. "s\nConcurrent Kruel users: "
		.. (ccu == 1 and "1 (you)" or ccu),
	5
)
if timetoload < 0.01 then
	notif("Kruel", "Loaded below .01s gg", 5)
end
task.spawn(function()
	while task.wait(120) do
		heartbeat()
	end
end)
