local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextButton_1 = Instance.new("TextButton")
local TextButton_2 = Instance.new("TextButton")
local TextButton_3 = Instance.new("TextButton")
local TextButton_4 = Instance.new("TextButton")
local TextButton_5 = Instance.new("TextButton")
local TextButton_6 = Instance.new("TextButton")
local TextButton_7 = Instance.new("TextButton")
local TextButton_8 = Instance.new("TextButton")
local TextButton_9 = Instance.new("TextButton")
local TextButton_10 = Instance.new("TextButton")
local TextButton_11 = Instance.new("TextButton")
local TextButton_12 = Instance.new("TextButton")
local TextButton_13 = Instance.new("TextButton")
local TextButton_14 = Instance.new("TextButton")
local TextButton_15 = Instance.new("TextButton")
local TextButton_16 = Instance.new("TextButton")
local TextButton_17 = Instance.new("TextButton")
local TextButton_18 = Instance.new("TextButton")
local TextButton_19 = Instance.new("TextButton")
local TextButton_20 = Instance.new("TextButton")
local TextButton_21 = Instance.new("TextButton")
local TextButton_22 = Instance.new("TextButton")
local TextButton_23 = Instance.new("TextButton")
local TextButton_24 = Instance.new("TextButton")
local TextButton_25 = Instance.new("TextButton")
local TextButton_26 = Instance.new("TextButton")
local TextButton_27 = Instance.new("TextButton")
local TextButton_28 = Instance.new("TextButton")
local TextButton_29 = Instance.new("TextButton")
local TextButton_30 = Instance.new("TextButton")
local TextButton_31 = Instance.new("TextButton")
local TextButton_32 = Instance.new("TextButton")
local TextButton_33 = Instance.new("TextButton")
local TextButton_34 = Instance.new("TextButton")
local TextButton_35 = Instance.new("TextButton")
local TextButton_36 = Instance.new("TextButton")
local TextButton_37 = Instance.new("TextButton")
local TextButton_38 = Instance.new("TextButton")
local TextButton_39 = Instance.new("TextButton")
local TextButton_40 = Instance.new("TextButton")




ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false



local function VRSV_fake_script() -- Frame.LocalScript 
	local script = Instance.new('LocalScript', Frame)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(VRSV_fake_script)()

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderColor3 = Color3.fromRGB(255,255, 0)
Frame.BorderSizePixel = 3
Frame.Position = UDim2.new(0.7000, 0, 0.200, 0)
Frame.Size = UDim2.new(0,400, 0, 550)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextLabel.BorderColor3 = Color3.fromRGB(255,255, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Size = UDim2.new(0, 400, 0, 50)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "TCS F3X GUI (credits to z000rzkidd)"
TextLabel.TextColor3 = Color3.fromRGB(255,255, 0)
TextLabel.TextSize = 35.000

TextButton_1.Parent = Frame
TextButton_1.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_1.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_1.BorderSizePixel = 3
TextButton_1.Position = UDim2.new(0, 0,0.100, 0)
TextButton_1.Size = UDim2.new(0, 100, 0,50)
TextButton_1.Font = Enum.Font.SourceSans
TextButton_1.Text = "Btools"
TextButton_1.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_1.TextSize = 25.000

local function QLCKFKL_fake_script() -- TextButton_1.LocalScript 
	local script = Instance.new('LocalScript', TextButton_1)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";btools me")
	end)
end
coroutine.wrap(QLCKFKL_fake_script)()

TextButton_2.Parent = Frame
TextButton_2.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_2.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_2.BorderSizePixel = 3
TextButton_2.Position = UDim2.new(0.250, 0,0.100, 0)
TextButton_2.Size = UDim2.new(0, 100, 0,50)
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.Text = "Kill Others"
TextButton_2.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_2.TextSize = 25.000

local function QLCKFKL_fake_script() -- TextButton_2.LocalScript 
	local script = Instance.new('LocalScript', TextButton_2)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";kill others")
	end)
end
coroutine.wrap(QLCKFKL_fake_script)()

TextButton_3.Parent = Frame
TextButton_3.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_3.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_3.BorderSizePixel = 3
TextButton_3.Position = UDim2.new(0.500, 0,0.100, 0)
TextButton_3.Size = UDim2.new(0, 100, 0,50)
TextButton_3.Font = Enum.Font.SourceSans
TextButton_3.Text = "Jail Others"
TextButton_3.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_3.TextSize = 25.000

local function QLCKFKL_fake_script() -- TextButton_3.LocalScript 
	local script = Instance.new('LocalScript', TextButton_3)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";jail others")
	end)
end
coroutine.wrap(QLCKFKL_fake_script)()

TextButton_4.Parent = Frame
TextButton_4.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_4.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_4.BorderSizePixel = 3
TextButton_4.Position = UDim2.new(0.750, 0,0.100, 0)
TextButton_4.Size = UDim2.new(0, 100, 0,50)
TextButton_4.Font = Enum.Font.SourceSans
TextButton_4.Text = "Unjail Others"
TextButton_4.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_4.TextSize = 22.000

local function QLCKFKL_fake_script() -- TextButton_4.LocalScript 
	local script = Instance.new('LocalScript', TextButton_4)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";unjail others")
	end)
end
coroutine.wrap(QLCKFKL_fake_script)()

TextButton_5.Parent = Frame
TextButton_5.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_5.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_5.BorderSizePixel = 3
TextButton_5.Position = UDim2.new(0, 0,0.200, 0)
TextButton_5.Size = UDim2.new(0, 100, 0,50)
TextButton_5.Font = Enum.Font.SourceSans
TextButton_5.Text = "Fly"
TextButton_5.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_5.TextSize = 25.000

local function QLCKFKL_fake_script() -- TextButton_5.LocalScript 
	local script = Instance.new('LocalScript', TextButton_5)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";fly")
	end)
end
coroutine.wrap(QLCKFKL_fake_script)()

TextButton_6.Parent = Frame
TextButton_6.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_6.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_6.BorderSizePixel = 3
TextButton_6.Position = UDim2.new(0.250, 0,0.200, 0)
TextButton_6.Size = UDim2.new(0, 100, 0,50)
TextButton_6.Font = Enum.Font.SourceSans
TextButton_6.Text = "UnFly"
TextButton_6.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_6.TextSize = 25.000

local function QLCKFKL_fake_script() -- TextButton_6.LocalScript 
	local script = Instance.new('LocalScript', TextButton_6)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";unfly")
	end)
end
coroutine.wrap(QLCKFKL_fake_script)()

TextButton_7.Parent = Frame
TextButton_7.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_7.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_7.BorderSizePixel = 3
TextButton_7.Position = UDim2.new(0.500, 0,0.200, 0)
TextButton_7.Size = UDim2.new(0, 100, 0,50)
TextButton_7.Font = Enum.Font.SourceSans
TextButton_7.Text = "Speed"
TextButton_7.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_7.TextSize = 25.000

local function QLCKFKL_fake_script() -- TextButton_7.LocalScript 
	local script = Instance.new('LocalScript', TextButton_7)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";speed me 100")
	end)
end
coroutine.wrap(QLCKFKL_fake_script)()

TextButton_8.Parent = Frame
TextButton_8.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_8.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_8.BorderSizePixel = 3
TextButton_8.Position = UDim2.new(0.750, 0,0.200, 0)
TextButton_8.Size = UDim2.new(0, 100, 0,50)
TextButton_8.Font = Enum.Font.SourceSans
TextButton_8.Text = "UnSpeed"
TextButton_8.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_8.TextSize = 25.000

local function QLCKFKL_fake_script() -- TextButton_8.LocalScript 
	local script = Instance.new('LocalScript', TextButton_8)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";speed me 20")
	end)
end
coroutine.wrap(QLCKFKL_fake_script)()

TextButton_9.Parent = Frame
TextButton_9.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_9.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_9.BorderSizePixel = 3
TextButton_9.Position = UDim2.new(0, 0,0.300, 0)
TextButton_9.Size = UDim2.new(0, 100, 0,50)
TextButton_9.Font = Enum.Font.SourceSans
TextButton_9.Text = "Sparta"
TextButton_9.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_9.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_9.LocalScript 
	local script = Instance.new('LocalScript', TextButton_9)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";music 140240856766854 ;pitch 0.2 ;volume inf ")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_10.Parent = Frame
TextButton_10.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_10.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_10.BorderSizePixel = 3
TextButton_10.Position = UDim2.new(0.250, 0,0.300, 0)
TextButton_10.Size = UDim2.new(0, 100, 0,50)
TextButton_10.Font = Enum.Font.SourceSans
TextButton_10.Text = "OMFG"
TextButton_10.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_10.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_10.LocalScript 
	local script = Instance.new('LocalScript', TextButton_10)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";music 80068856419698 ;pitch 0.15 ;volume inf ")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_11.Parent = Frame
TextButton_11.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_11.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_11.BorderSizePixel = 3
TextButton_11.Position = UDim2.new(0.500, 0,0.300, 0)
TextButton_11.Size = UDim2.new(0, 100, 0,50)
TextButton_11.Font = Enum.Font.SourceSans
TextButton_11.Text = "My Theme"
TextButton_11.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_11.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_11.LocalScript 
	local script = Instance.new('LocalScript', TextButton_11)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";music 16190761193 ;pitch 1 ;volume inf ")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_12.Parent = Frame
TextButton_12.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_12.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_12.BorderSizePixel = 3
TextButton_12.Position = UDim2.new(0.750, 0,0.300, 0)
TextButton_12.Size = UDim2.new(0, 100, 0,50)
TextButton_12.Font = Enum.Font.SourceSans
TextButton_12.Text = "Gothic"
TextButton_12.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_12.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_12.LocalScript 
	local script = Instance.new('LocalScript', TextButton_12)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";music 139488665764275 ;pitch 0.8 ;volume inf ")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_13.Parent = Frame
TextButton_13.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_13.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_13.BorderSizePixel = 3
TextButton_13.Position = UDim2.new(0.0, 0,0.400, 0)
TextButton_13.Size = UDim2.new(0, 100, 0,50)
TextButton_13.Font = Enum.Font.SourceSans
TextButton_13.Text = "Decal Spam"
TextButton_13.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_13.TextSize = 25.000

local function DECALSPAM13_fake_script() -- TextButton_13.LocalScript
	local script = Instance.new('LocalScript', TextButton_13)
	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local tool
		
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		
		remote = tool.SyncAPI.ServerEndpoint
		function _(args)
			remote:InvokeServer(unpack(args))
		end

		function SetLocked(part,boolean)
			local args = {[1] = "SetLocked", [2] = {[1] = part}, [3] = boolean}
			_(args)
		end

		function SpawnDecal(part,side)
			local args = {
				[1] = "CreateTextures",
				[2] = {[1] = {["Part"] = part, ["Face"] = side, ["TextureType"] = "Decal"}}
			}
			_(args)
		end

		function AddDecal(part,asset,side)
			local args = {
				[1] = "SyncTexture",
				[2] = {[1] = {["Part"] = part, ["Face"] = side, ["TextureType"] = "Decal", ["Texture"] = "rbxassetid://91844965966988"}}
			}
			_(args)
		end

		function spam(id)
			for i,v in game.workspace:GetDescendants() do
				if v:IsA("BasePart") then
					spawn(function()
						SetLocked(v, false)
						
						SpawnDecal(v, Enum.NormalId.Front)  AddDecal(v, id, Enum.NormalId.Front)
						SpawnDecal(v, Enum.NormalId.Back)   AddDecal(v, id, Enum.NormalId.Back)
						SpawnDecal(v, Enum.NormalId.Right)  AddDecal(v, id, Enum.NormalId.Right)
						SpawnDecal(v, Enum.NormalId.Left)   AddDecal(v, id, Enum.NormalId.Left)
						SpawnDecal(v, Enum.NormalId.Bottom) AddDecal(v, id, Enum.NormalId.Bottom)
						SpawnDecal(v, Enum.NormalId.Top)    AddDecal(v, id, Enum.NormalId.Top)
					end)
				end
			end
		end
		
		spam("106933259953201") 
	end)
end
coroutine.wrap(DECALSPAM13_fake_script)()

TextButton_14.Parent = Frame
TextButton_14.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_14.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_14.BorderSizePixel = 3
TextButton_14.Position = UDim2.new(0.250, 0,0.400, 0)
TextButton_14.Size = UDim2.new(0, 100, 0,50)
TextButton_14.Font = Enum.Font.SourceSans
TextButton_14.Text = "Skybox"
TextButton_14.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_14.TextSize = 25.000

local function FJPT_fake_script() -- TextButton_14.LocalScript 
	local script = Instance.new('LocalScript', TextButton_14)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";fogcolor black")
		wait (0.2)
		local player = game.Players.LocalPlayer
		local char = player.Character
		local tool
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		--craaa
		remote = tool.SyncAPI.ServerEndpoint
		function _(args)
			remote:InvokeServer(unpack(args))
		end
		function SetCollision(part,boolean)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = boolean
					}
				}
			}
			_(args)
		end
		function SetAnchor(boolean,part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			_(args)
		end
		function CreatePart(cf,parent)
			local args = {
				[1] = "CreatePart",
				[2] = "Normal",
				[3] = cf,
				[4] = parent
			}
			_(args)
		end
		function DestroyPart(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			_(args)
		end
		function MovePart(part,cf)
			local args = {
				[1] = "SyncMove",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf
					}
				}
			}
			_(args)
		end
		function Resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			_(args)
		end
		function AddMesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			_(args)
		end
	
		function SetMesh(part,meshid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://"..meshid
					}
				}
			}
			_(args)
		end
		function SetTexture(part, texid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] = "rbxassetid://"..texid
					}
				}
			}
			_(args)
		end
		function SetName(part, stringg)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringg
			}
	
			_(args)
		end
		function MeshResize(part,size)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = size
					}
				}
			}
			_(args)
		end
		function Weld(part1, part2,lead)
			local args = {
				[1] = "CreateWelds",
				[2] = {
					[1] = part1,
					[2] = part2
				},
				[3] = lead
			}
			_(args)
	
		end
		function SetLocked(part,boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			_(args)
		end
		function SetTrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			_(args)
		end
		function CreateSpotlight(part)
			local args = {
				[1] = "CreateLights",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight"
					}
				}
			}
			_(args)
		end
		function SyncLighting(part,brightness)
			local args = {
				[1] = "SyncLighting",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight",
						["Brightness"] = brightness
					}
				}
			}
			_(args)
		end
		function Color(part,color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color --[[Color3]],
						["UnionColoring"] = false
					}
				}
			}
			_(args)
		end
		function SpawnDecal(part,side)
			local args = {
				[1] = "CreateTextures",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal"
					}
				}
			}
	
			_(args)
		end
		function AddDecal(part,asset,side)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal",
						["Texture"] = "rbxassetid://91844965966988"}}
					}
				}
			}
			_(args)
		end
	
		function Sky(id)
			e = char.HumanoidRootPart.CFrame.x
			f = char.HumanoidRootPart.CFrame.y
			g = char.HumanoidRootPart.CFrame.z
			CreatePart(CFrame.new(math.floor(e),math.floor(f),math.floor(g)) + Vector3.new(0,6,0),workspace)
			for i,v in game.Workspace:GetDescendants() do
				if v:IsA("BasePart") and v.CFrame.x == math.floor(e) and v.CFrame.z == math.floor(g) then
					--spawn(function()
					SetName(v,"team z000rzkidd member")
					AddMesh(v)
					--end)
					--spawn(function()
					SetMesh(v,"111891702759441")
					SetTexture(v,id)
					--end)
					MeshResize(v,Vector3.new(99999,99999,99999))
					SetLocked(v,true)
				end
			end
		end
		Sky("106933259953201")
	end)
end
coroutine.wrap(FJPT_fake_script)()

TextButton_15.Parent = Frame
TextButton_15.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_15.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_15.BorderSizePixel = 3
TextButton_15.Position = UDim2.new(0.500, 0,0.400, 0)
TextButton_15.Size = UDim2.new(0, 100, 0,50)
TextButton_15.Font = Enum.Font.SourceSans
TextButton_15.Text = "Sparkles"
TextButton_15.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_15.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_15.LocalScript 
	local script = Instance.new('LocalScript', TextButton_15)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";sparkles all ")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_16.Parent = Frame
TextButton_16.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_16.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_16.BorderSizePixel = 3
TextButton_16.Position = UDim2.new(0.750, 0,0.400, 0)
TextButton_16.Size = UDim2.new(0, 100, 0,50)
TextButton_16.Font = Enum.Font.SourceSans
TextButton_16.Text = "Fling All"
TextButton_16.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_16.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_16.LocalScript 
	local script = Instance.new('LocalScript', TextButton_16)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";fling all ")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_17.Parent = Frame
TextButton_17.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_17.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_17.BorderSizePixel = 3
TextButton_17.Position = UDim2.new(0., 0,0.500, 0)
TextButton_17.Size = UDim2.new(0, 100, 0,50)
TextButton_17.Font = Enum.Font.SourceSans
TextButton_17.Text = "UnSparkles"
TextButton_17.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_17.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_17.LocalScript 
	local script = Instance.new('LocalScript', TextButton_17)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";unsparkles all ")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_18.Parent = Frame
TextButton_18.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_18.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_18.BorderSizePixel = 3
TextButton_18.Position = UDim2.new(0.250, 0,0.500, 0)
TextButton_18.Size = UDim2.new(0, 100, 0,50)
TextButton_18.Font = Enum.Font.SourceSans
TextButton_18.Text = "Notice All"
TextButton_18.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_18.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_18.LocalScript 
	local script = Instance.new('LocalScript', TextButton_18)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";notice all team z000rzkidd join today ! ")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_19.Parent = Frame
TextButton_19.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_19.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_19.BorderSizePixel = 3
TextButton_19.Position = UDim2.new(0.500, 0,0.500, 0)
TextButton_19.Size = UDim2.new(0, 100, 0,50)
TextButton_19.Font = Enum.Font.SourceSans
TextButton_19.Text = "Hint"
TextButton_19.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_19.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_19.LocalScript 
	local script = Instance.new('LocalScript', TextButton_19)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";hy Big Respect To team z000rzkidd Members ! ")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_20.Parent = Frame
TextButton_20.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_20.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_20.BorderSizePixel = 3
TextButton_20.Position = UDim2.new(0.750, 0,0.500, 0)
TextButton_20.Size = UDim2.new(0, 100, 0,50)
TextButton_20.Font = Enum.Font.SourceSans
TextButton_20.Text = "Message 1"
TextButton_20.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_20.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_20.LocalScript 
	local script = Instance.new('LocalScript', TextButton_20)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";sm This server is haxxed By team corrupted studios")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_21.Parent = Frame
TextButton_21.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_21.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_21.BorderSizePixel = 3
TextButton_21.Position = UDim2.new(0., 0,0.600, 0)
TextButton_21.Size = UDim2.new(0, 100, 0,50)
TextButton_21.Font = Enum.Font.SourceSans
TextButton_21.Text = "Message 2"
TextButton_21.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_21.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_21.LocalScript 
	local script = Instance.new('LocalScript', TextButton_21)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";sm team corrupted studios join today ")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_22.Parent = Frame
TextButton_22.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_22.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_22.BorderSizePixel = 3
TextButton_22.Position = UDim2.new(0.250, 0,0.600, 0)
TextButton_22.Size = UDim2.new(0, 100, 0,50)
TextButton_22.Font = Enum.Font.SourceSans
TextButton_22.Text = "Title Others"
TextButton_22.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_22.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_22.LocalScript 
	local script = Instance.new('LocalScript', TextButton_22)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";titley other team corrupted studios victim")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_23.Parent = Frame
TextButton_23.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_23.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_23.BorderSizePixel = 3
TextButton_23.Position = UDim2.new(0.500, 0,0.600, 0)
TextButton_23.Size = UDim2.new(0, 100, 0,50)
TextButton_23.Font = Enum.Font.SourceSans
TextButton_23.Text = "Title Me"
TextButton_23.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_23.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_23.LocalScript 
	local script = Instance.new('LocalScript', TextButton_23)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";titleb me team corrupted studios member")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_24.Parent = Frame
TextButton_24.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_24.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_24.BorderSizePixel = 3
TextButton_24.Position = UDim2.new(0.750, 0,0.600, 0)
TextButton_24.Size = UDim2.new(0, 100, 0,50)
TextButton_24.Font = Enum.Font.SourceSans
TextButton_24.Text = "Fire All"
TextButton_24.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_24.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_24.LocalScript 
	local script = Instance.new('LocalScript', TextButton_24)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";fire all")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_25.Parent = Frame
TextButton_25.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_25.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_25.BorderSizePixel = 3
TextButton_25.Position = UDim2.new(0., 0,0.700, 0)
TextButton_25.Size = UDim2.new(0, 100, 0,50)
TextButton_25.Font = Enum.Font.SourceSans
TextButton_25.Text = "R6 All"
TextButton_25.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_25.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_25.LocalScript 
	local script = Instance.new('LocalScript', TextButton_25)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";r6 all")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_26.Parent = Frame
TextButton_26.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_26.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_26.BorderSizePixel = 3
TextButton_26.Position = UDim2.new(0.250, 0,0.700, 0)
TextButton_26.Size = UDim2.new(0, 100, 0,50)
TextButton_26.Font = Enum.Font.SourceSans
TextButton_26.Text = "R15 All"
TextButton_26.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_26.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_26.LocalScript 
	local script = Instance.new('LocalScript', TextButton_26)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";r15 all")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_27.Parent = Frame
TextButton_27.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_27.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_27.BorderSizePixel = 3
TextButton_27.Position = UDim2.new(0.500, 0,0.700, 0)
TextButton_27.Size = UDim2.new(0, 100, 0,50)
TextButton_27.Font = Enum.Font.SourceSans
TextButton_27.Text = "Sp00ky"
TextButton_27.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_27.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_27.LocalScript 
	local script = Instance.new('LocalScript', TextButton_27)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";music 95156028272944 ;pitch 0.2 ;volume inf")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_28.Parent = Frame
TextButton_28.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_28.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_28.BorderSizePixel = 3
TextButton_28.Position = UDim2.new(0.750, 0,0.700, 0)
TextButton_28.Size = UDim2.new(0, 100, 0,50)
TextButton_28.Font = Enum.Font.SourceSans
TextButton_28.Text = "Bass"
TextButton_28.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_28.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_28.LocalScript 
	local script = Instance.new('LocalScript', TextButton_28)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";music 112836804811863 ;pitch 0.1 ;volume inf")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_29.Parent = Frame
TextButton_29.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_29.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_29.BorderSizePixel = 3
TextButton_29.Position = UDim2.new(0., 0,0.800, 0)
TextButton_29.Size = UDim2.new(0, 100, 0,50)
TextButton_29.Font = Enum.Font.SourceSans
TextButton_29.Text = "FreakBob"
TextButton_29.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_29.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_29.LocalScript 
	local script = Instance.new('LocalScript', TextButton_29)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";music 133170570098799 ;pitch 1 ;volume inf")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_30.Parent = Frame
TextButton_30.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_30.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_30.BorderSizePixel = 3
TextButton_30.Position = UDim2.new(0.250, 0,0.800, 0)
TextButton_30.Size = UDim2.new(0, 100, 0,50)
TextButton_30.Font = Enum.Font.SourceSans
TextButton_30.Text = "UnFire All"
TextButton_30.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_30.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_30.LocalScript 
	local script = Instance.new('LocalScript', TextButton_30)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";unfire all")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_31.Parent = Frame
TextButton_31.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_31.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_31.BorderSizePixel = 3
TextButton_31.Position = UDim2.new(0.500, 0,0.800, 0)
TextButton_31.Size = UDim2.new(0, 100, 0,50)
TextButton_31.Font = Enum.Font.SourceSans
TextButton_31.Text = "Spin All"
TextButton_31.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_31.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_31.LocalScript 
	local script = Instance.new('LocalScript', TextButton_31)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";spin all")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_32.Parent = Frame
TextButton_32.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_32.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_32.BorderSizePixel = 3
TextButton_32.Position = UDim2.new(0.750, 0,0.800, 0)
TextButton_32.Size = UDim2.new(0, 100, 0,50)
TextButton_32.Font = Enum.Font.SourceSans
TextButton_32.Text = "UnSpin All"
TextButton_32.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_32.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_32.LocalScript 
	local script = Instance.new('LocalScript', TextButton_32)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";unspin all")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_33.Parent = Frame
TextButton_33.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_33.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_33.BorderSizePixel = 3
TextButton_33.Position = UDim2.new(0., 0,0.900, 0)
TextButton_33.Size = UDim2.new(0, 100, 0,50)
TextButton_33.Font = Enum.Font.SourceSans
TextButton_33.Text = "Dance 1"
TextButton_33.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_33.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_33.LocalScript 
	local script = Instance.new('LocalScript', TextButton_33)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";emote all takeTheL")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_34.Parent = Frame
TextButton_34.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_34.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_34.BorderSizePixel = 3
TextButton_34.Position = UDim2.new(0.250, 0,0.900, 0)
TextButton_34.Size = UDim2.new(0, 100, 0,50)
TextButton_34.Font = Enum.Font.SourceSans
TextButton_34.Text = "Dance 2"
TextButton_34.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_34.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_34.LocalScript 
	local script = Instance.new('LocalScript', TextButton_34)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";emote all floss")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_35.Parent = Frame
TextButton_35.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_35.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_35.BorderSizePixel = 3
TextButton_35.Position = UDim2.new(0.500, 0,0.900, 0)
TextButton_35.Size = UDim2.new(0, 100, 0,50)
TextButton_35.Font = Enum.Font.SourceSans
TextButton_35.Text = "Dance 3"
TextButton_35.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_35.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_35.LocalScript 
	local script = Instance.new('LocalScript', TextButton_35)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";emote all dorky")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_36.Parent = Frame
TextButton_36.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_36.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_36.BorderSizePixel = 3
TextButton_36.Position = UDim2.new(0.750, 0,0.900, 0)
TextButton_36.Size = UDim2.new(0, 100, 0,50)
TextButton_36.Font = Enum.Font.SourceSans
TextButton_36.Text = "UnEmote"
TextButton_36.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_36.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_36.LocalScript 
	local script = Instance.new('LocalScript', TextButton_36)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";unemote all")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_37.Parent = Frame
TextButton_37.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_37.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_37.BorderSizePixel = 3
TextButton_37.Position = UDim2.new(0., 0,1, 0)
TextButton_37.Size = UDim2.new(0, 100, 0,50)
TextButton_37.Font = Enum.Font.SourceSans
TextButton_37.Text = "Night"
TextButton_37.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_37.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_37.LocalScript 
	local script = Instance.new('LocalScript', TextButton_37)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";time 0")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_38.Parent = Frame
TextButton_38.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_38.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_38.BorderSizePixel = 3
TextButton_38.Position = UDim2.new(0.250, 0,1, 0)
TextButton_38.Size = UDim2.new(0, 100, 0,50)
TextButton_38.Font = Enum.Font.SourceSans
TextButton_38.Text = "Day"
TextButton_38.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_38.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_38.LocalScript 
	local script = Instance.new('LocalScript', TextButton_38)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";time 12")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_39.Parent = Frame
TextButton_39.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_39.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_39.BorderSizePixel = 3
TextButton_39.Position = UDim2.new(0.500, 0,1, 0)
TextButton_39.Size = UDim2.new(0, 100, 0,50)
TextButton_39.Font = Enum.Font.SourceSans
TextButton_39.Text = "Dog All"
TextButton_39.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_39.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_39.LocalScript 
	local script = Instance.new('LocalScript', TextButton_39)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";emote all dog")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()

TextButton_40.Parent = Frame
TextButton_40.BackgroundColor3 = Color3.fromRGB(0,0,0)
TextButton_40.BorderColor3 = Color3.fromRGB(255,255, 0)
TextButton_40.BorderSizePixel = 3
TextButton_40.Position = UDim2.new(0.750, 0,1, 0)
TextButton_40.Size = UDim2.new(0, 100, 0,50)
TextButton_40.Font = Enum.Font.SourceSans
TextButton_40.Text = "Shutdown"
TextButton_40.TextColor3 = Color3.fromRGB(255,255, 0)
TextButton_40.TextSize = 25.000

local function WFHZHYQ_fake_script() -- TextButton_40.LocalScript 
	local script = Instance.new('LocalScript', TextButton_40)

	local button = script.Parent
	
	button.MouseButton1Click:Connect(function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local RequestCommand = ReplicatedStorage:WaitForChild("HDAdminHDClient").Signals.RequestCommandSilent
	
		RequestCommand:InvokeServer(";shutdown")
	end)
end
coroutine.wrap(WFHZHYQ_fake_script)()
