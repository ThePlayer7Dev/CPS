surface.CreateFont("Font::2d3d1", {
	font = "Arial",
	extended = false,
	size = 40,
	weight = 1000,
})

surface.CreateFont("Font::2d3d2", {
	font = "Arial",
	extended = false,
	size = 500,
	weight = 1000,
})

surface.CreateFont("Font::2d3d3", {
	font = "Arial",
	extended = false,
	size = 45,
	weight = 1000,
})

surface.CreateFont("Font::2d3d4", {
	font = "Arial",
	extended = false,
	size = 25,
	weight = 1000,
})

surface.CreateFont("Font::2d3d5", {
	font = "Roboto",
	extended = false,
	size = 20,
	weight = 500,
})

local ScreenshotRequested = false
local ScreenshotRequestedPlayer
local menu_wanted = {}

hook.Add("PostRender", "Screeeshot::Player", function()

	if (!ScreenshotRequested) then return end
	ScreenshotRequested = false

	if not file.Exists("imgwanted","DATA") then
		file.CreateDir("imgwanted")
	end

	local data = render.Capture({
		format = "jpeg",
		quality = 100,
		h = ScrW() / 25,
		w = ScrW() / 25,
		x = 0,
		y = 0,
	})
	local f = file.Open("imgwanted/" .. ScreenshotRequestedPlayer:SteamID64() .. ".jpg", "wb", "DATA")
	f:Write(data)
	f:Close()

	ScreenshotRequestedPlayer.label:Remove()
	ScreenshotRequestedPlayer.icon:Remove()

end)

net.Receive("PoliceSysteme::WantedInfoSend",function()

  PoliceSysteme.Config.Wanted = net.ReadTable()
	local time = 0.1

	for _, v in pairs(PoliceSysteme.Config.Wanted) do

		timer.Simple(time,function()

			menu_wanted.DLabel = vgui.Create( "DLabel" )
			menu_wanted.DLabel:SetSize(ScrW() / 25, ScrW() / 25)
			menu_wanted.DLabel:SetPos(0,0)
			menu_wanted.DLabel:SetText("")
			menu_wanted.DLabel.Paint = function(self,w,h)

				draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 255))

				for i = 1, 8 do

					draw.RoundedBox(0, 0, h - h/7.68*i, w, h/30, Color(0, 0, 0, 255))

				end

				timer.Simple(0.5,function()
					if IsValid(self) then
						self:Remove()
					end
				end)

			end

			menu_wanted.icon = vgui.Create("DModelPanel")
	    menu_wanted.icon:SetSize(ScrW() / 25, ScrW() / 25)
	    menu_wanted.icon:SetPos(0,0)
	    menu_wanted.icon:SetModel(v:GetModel())
	    function menu_wanted.icon:LayoutEntity(Entity) return end
	    function menu_wanted.icon.Entity:GetPlayerColor() return Vector (1, 0, 0) end
	    local headpos = menu_wanted.icon.Entity:GetBonePosition(menu_wanted.icon.Entity:LookupBone("ValveBiped.Bip01_Head1"))
	    menu_wanted.icon:SetLookAt(headpos + Vector(0,0,0))
	    menu_wanted.icon:SetCamPos(headpos-Vector(-20, 0, 0))
			menu_wanted.icon.Think = function(self)
				timer.Simple(0.5,function()
					if IsValid(self) then
						self:Remove()
					end
				end)
			end

			ScreenshotRequested = true
			ScreenshotRequestedPlayer = v

			timer.Simple(1,function()
				v.Material = Material("data/imgwanted/" .. v:SteamID64() .. ".jpg")
			end)
			v.label = menu_wanted.DLabel
			v.icon = menu_wanted.icon


		end)

			time = time + 0.2
	end


end)


hook.Add("PreDrawTranslucentRenderables","PreDrawTranslucentRenderables::WantedDraw",function()

  for _,v in pairs(ents.FindByClass("wanted_panneau")) do

    local ang = v:GetAngles()
    local id = 0
    ang:RotateAroundAxis(ang:Up(), 270)


    cam.Start3D2D(v:GetPos() + v:GetForward() * -10 + v:GetUp() * 1.55, ang , 0.1)

			draw.RoundedBox(0,-2840/2,-1625/2,2840,1420,Color(25, 145, 236, 255))
			draw.RoundedBox(0,-2840/2,-1625/2,2840,1420/8,Color(255, 255, 255))

			for i = 0, 5 do

				draw.RoundedBox(0,-2840/2 + i*564,-1625/2.6,1420/70,1420/1.15,Color(255, 255, 255))

			end

			for i = 0, 2 do

				draw.RoundedBox(0,-2840/2,600 -620*i,2840,1420/70,Color(255, 255, 255))

			end

			draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("wanted"),"Font::2d3d2", -2840/100, -1625/2.2 , Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 5, Color(0,0,0))

      for k,f in pairs(PoliceSysteme.Config.Wanted) do

				if not IsValid(f) then continue end

        if id < 5 then

					local up = -575
          draw.RoundedBox(30,-1380 + id*565,up,500,500,Color(255,255,255,255))

					if f.Material then
	          surface.SetDrawColor(Color(255,255,255,255))
	          surface.SetMaterial(f.Material)
	          surface.DrawTexturedRectRotated(-1130 + id*565,up+220,250,250,0)
					end
					draw.RoundedBox(0,-1230 + id*565,up+290,200,40,Color(0,0,0))
					draw.SimpleTextOutlined(f:getWantedReason(),"Font::2d3d3", -1130 + id*565, up + 380, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, Color(0,0,0))
					draw.SimpleTextOutlined(f:Nick(),"Font::2d3d4", -1130 + id*565, up+310, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))

					for i = 1, 6 do
						draw.SimpleTextOutlined((100 + i * 10) / 100,"Font::2d3d4", -1240 + id*565, up+300 -i*32, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
					end

        elseif id < 10 then

					local up = 50
          draw.RoundedBox(30,-1375 + (id-5)*565,up,500,500,Color(255,255,255,255))
					if f.Material then
	          surface.SetDrawColor(Color(255,255,255,255))
	        	surface.SetMaterial(f.Material)
	          surface.DrawTexturedRectRotated(-1125 + (id-5)*565,up+220,250,250,0)
					end
					draw.RoundedBox(0,-1225 + (id-5)*565,up+290,200,40,Color(0,0,0))
					draw.SimpleTextOutlined(f:getWantedReason(),"Font::2d3d3", -1125 + (id-5)*565, up + 380, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 3, Color(0,0,0))
					draw.SimpleTextOutlined(f:Nick(),"Font::2d3d4", -1125 + (id-5)*565, up+310, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))

					for i = 1, 6 do
						draw.SimpleTextOutlined((100 + i * 10) / 100,"Font::2d3d4", -1235 + (id-5)*565, up+330 -i*32, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
					end

        end

        id = id + 1

      end

    cam.End3D2D()

  end

	if LocalPlayer():GetEyeTrace() and IsValid(LocalPlayer():GetEyeTrace().Entity) and LocalPlayer():GetEyeTrace().Entity:GetClass() == "weapon_armory" then

		local ent = LocalPlayer():GetEyeTrace().Entity
		local ang = Angle(0, LocalPlayer():EyeAngles().y - 90, 90)

    cam.Start3D2D(ent:GetPos() + ent:GetForward() * 10, ang , 0.1)

			if ent:GetColor().a == 255 then
				draw.SimpleTextOutlined(ent:GetNWString("WeaponName::Armory"),"Font::2d3d5", 0, -120, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))
			end

    cam.End3D2D()

  end

end)

hook.Add("InitPostEntity","InitPostEntity::CreateData",function()

	if not file.Exists("imgwanted","DATA") then
		file.CreateDir("imgwanted")
	end

end)
