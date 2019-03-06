AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
end

function ENT:AcceptInput(_,_,called)

		if self:GetColor().a == 0 then return end

		if table.HasValue(PoliceSysteme.Config.TeamPolice, called:Team()) then

			if IsValid(called:GetWeapon(self.WeaponGive)) then

				called:GiveAmmo(PoliceSysteme.Config.Ammogive,called:GetWeapon(self.WeaponGive):GetPrimaryAmmoType())

			else

				if not called.AntiSpamWeapon or called.AntiSpamWeapon < CurTime() then

					if called:PoliceGetTablePlayer().weapons[self.WeaponGive] then

						called:Give(self.WeaponGive)
						called.AntiSpamWeapon = CurTime() + PoliceSysteme.Config.TimeWaitForCanWeap

					else

						net.Start("PoliceText::NotificationText")
						net.WriteString(PoliceSysteme:GetPhrase("cantake"))
						net.Send(called)

					end

				else

					net.Start("PoliceText::NotificationText")
					net.WriteString(PoliceSysteme:GetPhrase("waitweap"))
					net.Send(called)

				end

			end

		else

			net.Start("PoliceText::NotificationText")
			net.WriteString(PoliceSysteme:GetPhrase("notpolice"))
			net.Send(called)

		end

end
