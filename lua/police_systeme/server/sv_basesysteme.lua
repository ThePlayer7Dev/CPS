util.AddNetworkString("PoliceSysteme::WantedInfoSend")
util.AddNetworkString("PoliceSysteme::EmergencyCall")
util.AddNetworkString("PoliceSysteme::EmergencyCallCancel")
util.AddNetworkString("PoliceSysteme::ConfigStart")
util.AddNetworkString("PoliceSysteme::PlayerResetConfig")
util.AddNetworkString("PoliceSysteme::PlayerResetConfigSend")
util.AddNetworkString("PoliceSysteme::ConfigSendPlayer")
util.AddNetworkString("PoliceSysteme::SetDown")


local Fonction = {}
local meta = FindMetaTable("Player")

function Fonction.WantedPlayerSend(crim)

  if crim:IsBot() then return end

  table.insert(PoliceSysteme.Config.Wanted,crim)

  for _,v in pairs(player.GetAll()) do

    net.Start("PoliceSysteme::WantedInfoSend")
    net.WriteTable(PoliceSysteme.Config.Wanted)
    net.Send(v)

  end


end

hook.Add("playerWanted","playerWanted::SendInfoPlayer",Fonction.WantedPlayerSend)



function Fonction.UnWantedPlayerSend(crim)

  table.RemoveByValue(PoliceSysteme.Config.Wanted,crim)

  for _,v in pairs(player.GetAll()) do

    net.Start("PoliceSysteme::WantedInfoSend")
    net.WriteTable(PoliceSysteme.Config.Wanted)
    net.Send(v)

  end

end

hook.Add("playerUnWanted","playerUnWanted::SendInfoPlayer",Fonction.UnWantedPlayerSend)



function Fonction.PlayerSendInfo(ply)

  net.Start("PoliceSysteme::ConfigSendPlayer")
  net.WriteTable(PoliceSysteme.Config)
  net.WriteTable(PoliceSysteme.Config.Rank)
  net.Send(ply)

  if not istable(PoliceSysteme.Config.Wanted) then return end

  net.Start("PoliceSysteme::WantedInfoSend")
  net.WriteTable(PoliceSysteme.Config.Wanted)
  net.Send(ply)

end

hook.Add("PlayerInitialSpawn","PlayerInitialSpawn::PoliceSendInfo",Fonction.PlayerSendInfo)


function Fonction.EmergencyCall(ply, str)

  if table.HasValue(PoliceSysteme.Config.TeamPolice, ply:Team()) and PoliceSysteme.Config.ActiveCommandeHelp and str and str == PoliceSysteme.Config.Commande then

    if not ply.HasEmergencyCall then

      net.Start("PoliceText::NotificationText")
      net.WriteString(PoliceSysteme:GetPhrase("callsucces"))
      net.Send(ply)
      ply.HasEmergencyCall = true

    else

      net.Start("PoliceText::NotificationText")
      net.WriteString(PoliceSysteme:GetPhrase("callcancel"))
      net.Send(ply)
      ply.HasEmergencyCall = false

    end

    for _,v in pairs(player.GetAll()) do

      if not table.HasValue(PoliceSysteme.Config.TeamPolice, v:Team()) or ply == v then continue end

      if ply.HasEmergencyCall then

        net.Start("PoliceSysteme::EmergencyCallCancel")
        net.Send(v)

      else

        net.Start("PoliceSysteme::EmergencyCall")
        net.WriteEntity(ply)
        net.Send(v)

      end

    end

    return ""

  end

end

hook.Add("PlayerSay","PlayerSay::Emergency",Fonction.EmergencyCall)


function meta:SetAccroupie()

  if self:GetNWBool("WasInaFloor") then

    self:SetNWBool("WasInaFloor",false)

    for i=0, self:GetBoneCount()-1 do

      self:ManipulateBonePosition(i, Vector(0,0,0))
      self:ManipulateBoneAngles(i, Angle(0,0,0))

    end

  else

    self:SetActiveWeapon(self:GetWeapon("keys"))
    self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_L_Calf"), Angle(-20,90,0))
    self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_R_Calf"), Angle(20,90,0))

    self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_L_UpperArm"), Angle(-120,-90,0))
    self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_R_UpperArm"), Angle(120,-90,0))

    self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(-20,-120,-50))
    self:ManipulateBoneAngles(self:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(20,-120,50))

    self:ManipulateBonePosition(self:LookupBone("ValveBiped.Bip01_Pelvis"), Vector(0,0,-20))

    self:SetNWBool("WasInaFloor",true)

  end

end

net.Receive("PoliceSysteme::SetDown",function(_,ply)

  local ent = net.ReadEntity()

  if not table.HasValue(PoliceSysteme.Config.TeamPolice, ply:Team()) and not ply:GetNWBool("WasInaFloor") then return end
  if not IsValid(ent) or not ent:IsPlayer() or table.HasValue(PoliceSysteme.Config.TeamPolice, ent:Team()) and not ply:GetNWBool("WasInaFloor") then return end
  if ply:GetPos():DistToSqr(ent:GetPos()) > 5000 then return end

  ent:SetAccroupie()

end)


function Fonction.SetPingPos(ply,key)

  if not PoliceSysteme.Config.ActivePing then

    if table.HasValue(PoliceSysteme.Config.TeamPolice, ply:Team()) then

      if key == KEY_G then

        if ply:GetNWVector("Vector::PingPolice") == Vector(0,0,0) then

          ply:SetNWVector("Vector::PingPolice",ply:GetEyeTrace().HitPos)

        else

          ply:SetNWVector("Vector::PingPolice",Vector(0,0,0))

        end

      end

    end

  end

end

hook.Add("PlayerButtonDown","PlayerButtonDown::Test123132",Fonction.SetPingPos)


function Fonction.RemovePingPolice(ply, old, new)

  if table.HasValue(PoliceSysteme.Config.TeamPolice, old) and not table.HasValue(PoliceSysteme.Config.TeamPolice, new) and ply:GetNWVector("Vector::PingPolice") != Vector(0,0,0) then

    ply:SetNWVector("Vector::PingPolice",Vector(0,0,0))

  end

end

hook.Add("OnPlayerChangedTeam","OnPlayerChangedTeam::RemovePing",Fonction.RemovePingPolice)


function Fonction.RemoveFreezWhenRespawn(ply)

  if ply:GetNWBool("WasInaFloor") then

    ply:SetAccroupie()

  end

end

hook.Add("PlayerSpawn","PlayerSpawn::SetAccroupieRemove",Fonction.RemoveFreezWhenRespawn)
