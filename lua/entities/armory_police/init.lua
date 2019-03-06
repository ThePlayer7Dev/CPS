AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("Armory::OpenMenu")
util.AddNetworkString("Armory::GiveWeapon")
util.AddNetworkString("Armory::CloseBox")
util.AddNetworkString("Armory::Create")
util.AddNetworkString("Armory::SetPosWeapon")
util.AddNetworkString("Armory::ValideConfig")
util.AddNetworkString("Armory::StopConfig")


function ENT:Initialize()
	self:SetModel(PoliceSysteme.Config.Model.Armory)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self.OpenBox = false
	self.EnCours = false
	self.OpenBox = false
	self.TableWeap = {}

	local oldpos = self:GetPos()
	local oldang = self:GetAngles()


	if file.Exists("policedata/config_armory.txt","DATA") and not self.NotConfig then

		local tbl = util.JSONToTable(file.Read("policedata/config_armory.txt"))

		self:SetPos(tbl.armory.pos)
		self:SetAngles(tbl.armory.ang)

		local ang = self:GetAngles()
		ang:RotateAroundAxis(ang:Up(), 270)
		ang:RotateAroundAxis(ang:Right(), 180)
		ang:RotateAroundAxis(ang:Forward(), 270)

		for k,v in pairs(tbl.weap) do

			local weap = ents.Create("weapon_armory")
			weap:SetPos(v.pos)
			weap:SetAngles(ang)
			weap:SetParent(self)
			weap:Spawn()
			weap:SetModel(v.model)
			weap.WeaponGive = v.class
			weap:SetNWString("WeaponName::Armory",v.class)

			table.insert(self.TableWeap,weap)

		end

		self:SetPos(oldpos)
		self:SetAngles(oldang)

		for _,v in pairs(self.TableWeap) do

			v:SetColor(Color(255,255,255,0))
			v:SetRenderMode(RENDERMODE_TRANSALPHA)

		end

	elseif not file.Exists("policedata/config_armory.txt","DATA") then

		for _,v in pairs(player.GetAll()) do

			if not v:IsSuperAdmin() then continue end

			net.Start("PoliceText::NotificationText")
			net.WriteString(PoliceSysteme:GetPhrase("configarm"))
			net.Send(v)

		end

	end

end

function ENT:AcceptInput(_,_,called)

		if table.HasValue(PoliceSysteme.Config.TeamPolice, called:Team()) then

			if not self.OpenBox and not self.EnCours and self:GetModel() == "models/items/ammocrate_smg1.mdl" then

				self:OpenCaisse()

			elseif self.OpenBox and not self.EnCours and self:GetModel() == "models/items/ammocrate_smg1.mdl" then

				self:CloseCaisse()

			end

		else

			net.Start("PoliceText::NotificationText")
			net.WriteString(PoliceSysteme:GetPhrase("notpolice"))
			net.Send(called)

		end
		
end

function ENT:OpenCaisse()

	local Ang1 = 0
	self.EnCours = true

	for _,v in pairs(self.TableWeap) do

		v:SetColor(Color(255,255,255,255))
		v:SetRenderMode(RENDERMODE_NORMAL)

	end

	hook.Add("Think","Think::OpenCaisse" .. self:EntIndex(),function()

		if not IsValid(self) then hook.Remove("Think","Think::OpenCaisse") return end

		if Ang1 > -100 then

			Ang1 = Ang1 - 3

			for _,v in pairs(self.TableWeap) do

				local ang = v:GetAngles()
				ang:RotateAroundAxis(ang:Forward(),-3.2)

				v:SetAngles(ang)
			end

		else

			self.EnCours = false
			self.OpenBox = true
			hook.Remove("Think","Think::OpenCaisse" .. self:EntIndex())

		end
		self:ManipulateBoneAngles(1, Angle(0,0,Ang1))

	end)

end

function ENT:CloseCaisse()

	local Ang1 = -90
	self.EnCours = true

	hook.Add("Think","Think::CloseCaisse" .. self:EntIndex(),function()

		if not IsValid(self) then hook.Remove("Think","Think::CloseCaisse" .. self:EntIndex()) return end

		if Ang1 < 0 then

			Ang1 = Ang1 + 3

			for _,v in pairs(self.TableWeap) do

				local ang = v:GetAngles()
				ang:RotateAroundAxis(ang:Forward(),3.63)

				v:SetAngles(ang)
			end

		else

			for _,v in pairs(self.TableWeap) do

				v:SetColor(Color(255,255,255,0))
				v:SetRenderMode(RENDERMODE_TRANSALPHA)

			end

			self.EnCours = false
			self.OpenBox = false
			hook.Remove("Think","Think::CloseCaisse" .. self:EntIndex())

		end
		self:ManipulateBoneAngles(1, Angle(0,0,Ang1))

	end)

end
