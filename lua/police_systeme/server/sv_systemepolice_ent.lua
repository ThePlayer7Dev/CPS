net.Receive("Computer::UpGrade",function(_,ply)

  local k = net.ReadFloat()
  local plya = net.ReadEntity()

  if not ply:PoliceGetTablePlayer().canpromote or not table.HasValue(PoliceSysteme.Config.TeamPolice, ply:Team()) then return end
  if k >= ply:GetNWInt("Rank::PlayerIDInTbl") and not ply:PoliceGetTablePlayer().canpromoteAll then return end
  if not istable(PoliceSysteme.Config.Rank[k]) then return end

  if IsValid(plya) and plya:IsPlayer() then

    plya.TotalTimePolice = PoliceSysteme.Config.Rank[k].time * 60
    file.Write("policedata/time/" .. plya:SteamID64() .. ".txt", plya.TotalTimePolice)
    file.Write("policedata/rank/" .. plya:SteamID64() .. ".txt", k)
    plya:SetNWInt("Rank::PlayerIDInTbl",k)

    net.Start("PoliceText::NotificationText")
    net.WriteString(PoliceSysteme:GetPhrase("succes"))
    net.Send(ply)

    net.Start("PoliceText::NotificationText")
    net.WriteString(PoliceSysteme:GetPhrase("promotemsg") .. PoliceSysteme.Config.Rank[k].name)
    net.Send(plya)

  end

end)


net.Receive("Computer::DeleteFile",function(_,ply)

  if not ply:PoliceGetTablePlayer().canDeleteReport or not table.HasValue(PoliceSysteme.Config.TeamPolice, ply:Team()) then return end

  local str = net.ReadString()

  file.Delete("policedata/rapport/" .. str)

  net.Start("PoliceText::NotificationText")
  net.WriteString(PoliceSysteme:GetPhrase("succes"))
  net.Send(ply)

end)

net.Receive("Computer::ReadFile",function(_,ply)

  if not table.HasValue(PoliceSysteme.Config.TeamPolice, ply:Team()) then return end
  local str = net.ReadString()
  if file.Exists("policedata/rapport/" .. str,"DATA") then

    net.Start("Computer::ReadFileSend")
    net.WriteString(file.Read("policedata/rapport/" .. str,"DATA"))
    net.Send(ply)

  else

    net.Start("Computer::ReadFileSend")
    net.WriteString(PoliceSysteme:GetPhrase("noexist"))
    net.Send(ply)

  end

end)

net.Receive("Computer::WriteFile",function(_,ply)

    if not table.HasValue(PoliceSysteme.Config.TeamPolice, ply:Team()) then return end

    local str1 = net.ReadString()
    local str2 = net.ReadString()

    if str1 == "" or str2 == "" then return end

    if file.Exists("policedata/rapport/" .. str1 .. ".txt","DATA") then

      net.Start("PoliceText::NotificationText")
      net.WriteString(PoliceSysteme:GetPhrase("filepri"))
      net.Send(ply)

      return

    end

    file.Write("policedata/rapport/" .. str1 .. ".txt",str2)

    net.Start("PoliceText::NotificationText")
    net.WriteString(PoliceSysteme:GetPhrase("succes"))
    net.Send(ply)


end)

net.Receive("Armory::CloseBox",function()

	local ent = net.ReadEntity()

	if IsValid(ent) and ent:GetClass() == "armory_police" and ent:GetModel() == "models/items/ammocrate_ar2.mdl" then

		ent:CloseCaisse()

	end

end)


net.Receive("Armory::GiveWeapon",function(_,ply)

  local ent = net.ReadEntity()

  if ent.OpenBox and not ent.EnCours then
    ent:CloseCaisse()
  end

  if not table.HasValue(PoliceSysteme.Config.TeamPolice, ply:Team()) then return end
  if ply.AntiSpamWeapon and ply.AntiSpamWeapon > CurTime() then

    net.Start("PoliceText::NotificationText")
    net.WriteString(PoliceSysteme:GetPhrase("waitweap"))
    net.Send(ply)

     return end

   for _,v in pairs(ply:PoliceGetTablePlayer().weapons) do

     ply:Give(v.class)

   end

   ply.AntiSpamWeapon = CurTime() + PoliceSysteme.Config.TimeWaitForCanWeap


end)

net.Receive("Armory::Create",function(_,ply)

  if not ply:IsSuperAdmin() then return end

  local ent = ents.Create("armory_police")
  ent.NotConfig = true
  ent:SetAngles(net.ReadAngle())
  ent:SetPos(net.ReadVector()+Vector(0,0,2))
  ent:Spawn()
  ent:CPPISetOwner(ply)

  local phys = ent:GetPhysicsObject()
  phys:EnableMotion(false)

  net.Start("Armory::SetPosWeapon")
  net.WriteEntity(ent)
  net.Send(ply)

  ply:SetNWEntity("Entity::Armory",ent)

  ent:OpenCaisse()

  timer.Simple(0.6,function()
    ent.EnCours = true
  end)

end)

net.Receive("Armory::ValideConfig",function(_,ply)

  if not ply:IsSuperAdmin() then return end

  local tbl = {}
  tbl.weap = net.ReadTable()
  tbl.armory = {pos = ply:GetNWEntity("Entity::Armory"):GetPos(), ang = ply:GetNWEntity("Entity::Armory"):GetAngles()}

  ply:GetNWEntity("Entity::Armory"):Remove()

  local str = util.TableToJSON(tbl)

  file.Write("policedata/config_armory.txt",str)

  net.Start("PoliceText::NotificationText")
  net.WriteString(PoliceSysteme:GetPhrase("configsav"))
  net.Send(ply)

end)


net.Receive("Armory::StopConfig",function(_,ply)

  if not ply:IsSuperAdmin() then return end

  ply:GetNWEntity("Entity::Armory"):Remove()

end)

net.Receive("Computer::WantedPersonn",function(_,ply)

  if not table.HasValue(PoliceSysteme.Config.TeamPolice, ply:Team()) then return end

  local str = net.ReadString()
  local want = net.ReadEntity()

  if not IsValid(want) or not want:IsPlayer() then return end

  if want:isWanted() then

    net.Start("PoliceText::NotificationText")
    net.WriteString(PoliceSysteme:GetPhrase("wantedno"))
    net.Send(ply)

    return end

  want:wanted(ply,str,PoliceSysteme.Config.TimeWanted)
  net.Start("PoliceText::NotificationText")
  net.WriteString(PoliceSysteme:GetPhrase("succes"))
  net.Send(ply)


end)

net.Receive("Computer::UnWantedPersonn",function(_,ply)

  local want = net.ReadEntity()

  if not table.HasValue(PoliceSysteme.Config.TeamPolice, ply:Team()) then return end
  if not IsValid(want) or not want:IsPlayer() then return end
  if not want:isWanted() then return end

  want:unWanted(ply)

  net.Start("PoliceText::NotificationText")
  net.WriteString(PoliceSysteme:GetPhrase("succes"))
  net.Send(ply)

end)

net.Receive("Arrest::ArrestPlayer",function(_,ply)

  if not table.HasValue(PoliceSysteme.Config.TeamPolice, ply:Team()) then return end
  local ent = net.ReadEntity()
  if not IsValid(ent) or not ent:IsPlayer() or table.HasValue(PoliceSysteme.Config.TeamPolice, ent:Team()) then return end
  if ent:GetPos():Distance(ply:GetPos()) > 300 then return end

  if ent:isArrested() then

    net.Start("PoliceText::NotificationText")
    net.WriteString(PoliceSysteme:GetPhrase("wasarrest"))
    net.Send(ply)

    return end

  ent:arrest(PoliceSysteme.Config.TimeArrest,ply)

  net.Start("PoliceText::NotificationText")
  net.WriteString(PoliceSysteme:GetPhrase("succes"))
  net.Send(ply)


end)

net.Receive("Arrest::UnArrestPlayer",function(_,ply)

  if not table.HasValue(PoliceSysteme.Config.TeamPolice, ply:Team()) then return end
  local ent = net.ReadEntity()
  if not IsValid(ent) or not ent:IsPlayer() or table.HasValue(PoliceSysteme.Config.TeamPolice, ent:Team()) then return end
  if ent:GetPos():Distance(ply:GetPos()) > 300 then return end

  if not ent:isArrested() then

    net.Start("PoliceText::NotificationText")
    net.WriteString(PoliceSysteme:GetPhrase("wasarresnot"))
    net.Send(ply)

    return end

  ent:unArrest(ply)

  net.Start("PoliceText::NotificationText")
  net.WriteString(PoliceSysteme:GetPhrase("succes"))
  net.Send(ply)

end)
