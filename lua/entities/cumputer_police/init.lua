AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("PoliceText::NotificationText")
util.AddNetworkString("Computer::OpenMenu")
util.AddNetworkString("Computer::UpGrade")
util.AddNetworkString("Computer::DeleteFile")
util.AddNetworkString("Computer::ReadFile")
util.AddNetworkString("Computer::ReadFileSend")
util.AddNetworkString("Computer::WriteFile")
util.AddNetworkString("Computer::WantedPersonn")
util.AddNetworkString("Computer::UnWantedPersonn")



function ENT:Initialize()
	self:SetModel(PoliceSysteme.Config.Model.Computer)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
end

function ENT:AcceptInput(_,_,called)

		if table.HasValue(PoliceSysteme.Config.TeamPolice, called:Team()) then

			net.Start("Computer::OpenMenu")
			net.WriteTable(file.Find("policedata/rapport/*", "DATA") or {})
			net.Send(called)

		else

			net.Start("PoliceText::NotificationText")
			net.WriteString(PoliceSysteme:GetPhrase("notpolice"))
			net.Send(called)

		end

end
