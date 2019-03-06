local TimePerSecond = CurTime()

local Fonction = {}

function Fonction.PlayerSpawnInitial(ply)

  if file.Exists("policedata/time/" .. ply:SteamID64() .. ".txt","DATA") then

    ply.TotalTimePolice = tonumber(file.Read("policedata/time/" .. ply:SteamID64() .. ".txt"))
    ply:SetNWInt("Rank::PlayerIDInTbl",tonumber(file.Read("policedata/rank/" .. ply:SteamID64() .. ".txt","DATA")))

  else

    file.Write("policedata/time/" .. ply:SteamID64() .. ".txt",0)
    file.Write("policedata/rank/" .. ply:SteamID64() .. ".txt",1)
    ply:SetNWInt("Rank::PlayerIDInTbl",1)
    ply.TotalTimePolice = 0

  end

end

hook.Add("PlayerInitialSpawn","PlayerInitialSpawn::SetDataTime",Fonction.PlayerSpawnInitial)


function Fonction.PlayerDisconnect(ply)

    file.Write("policedata/time/" .. ply:SteamID64() .. ".txt", ply.TotalTimePolice)

end

hook.Add("PlayerDisconnected","PlayerDisconnected::SetDataTime",Fonction.PlayerDisconnect)



function Fonction.AddTimePolice()

  if not PoliceSysteme.Config.CanUpWithTime then return end
  if TimePerSecond > CurTime() then return end

  for _,v in pairs(player.GetAll()) do

    if not table.HasValue(PoliceSysteme.Config.TeamPolice, v:Team()) then continue end

    v.TotalTimePolice = v.TotalTimePolice + 1

    if PoliceSysteme.Config.RankTime[v.TotalTimePolice / 60] then

      file.Write("policedata/time/" .. v:SteamID64() .. ".txt", v.TotalTimePolice)
      file.Write("policedata/rank/" .. v:SteamID64() .. ".txt", PoliceSysteme.Config.RankTime[v.TotalTimePolice / 60])
      v:SetNWInt("Rank::PlayerIDInTbl", PoliceSysteme.Config.RankTime[v.TotalTimePolice / 60])

      net.Start("PoliceText::NotificationText")
      net.WriteString(PoliceSysteme:GetPhrase("promotemsg") .. v:GetPoliceRankName())
      net.Send(v)

    end

  end

  TimePerSecond = CurTime() + 1

end

hook.Add("Think","Think::AddTime",Fonction.AddTimePolice)



function Fonction.ShutDownServer()

  for _,v in pairs(player.GetAll()) do

    if not IsValid(v) or v:IsBot() or not v.TotalTimePolice or not IsValid(v:SteamID64()) then continue end

    file.Write("policedata/time/" .. v:SteamID64() .. ".txt", v.TotalTimePolice)

  end

end

hook.Add("ShutDown","ShutDown::SaveTimePlayer",Fonction.ShutDownServer)
