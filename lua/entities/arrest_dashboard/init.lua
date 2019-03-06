AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("Arrest::ArrestPlayer")
util.AddNetworkString("Arrest::UnArrestPlayer")

function ENT:Initialize()
	self:SetModel("models/hunter/plates/plate1x2.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
end
