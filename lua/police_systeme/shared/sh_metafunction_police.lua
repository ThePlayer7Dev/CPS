local meta = FindMetaTable("Player")
local Fonction = {}


function meta:PoliceGetTablePlayer()

  return PoliceSysteme.Config.Rank[self:GetNWInt("Rank::PlayerIDInTbl")]

end

function meta:GetPoliceRankName()

  return PoliceSysteme.Config.Rank[self:GetNWInt("Rank::PlayerIDInTbl")].name

end

function PoliceSysteme:GetPhrase(str)

  return PoliceSysteme.Config.Text[PoliceSysteme.Config.Language][str]

end



net.Receive("PoliceSysteme::PlayerResetConfig",function(_,ply)

  if not ply:IsSuperAdmin() then return end

  net.Start("PoliceSysteme::PlayerResetConfigSend")
  net.WriteTable(PoliceSysteme.Config)
  net.Send(ply)

end)

net.Receive("PoliceSysteme::ConfigStart",function(_,ply)

  if not ply:IsSuperAdmin() then return end

  local tbl1 = net.ReadTable()
  local tbl2 = net.ReadTable()

  local sort_func = function(a,b) return tonumber(a.time) < tonumber(b.time) end
  table.sort(tbl2, sort_func)

  PoliceSysteme.Config = tbl1
  PoliceSysteme.Config.Rank = tbl2

  for k,v in pairs(PoliceSysteme.Config.Rank) do

    PoliceSysteme.Config.RankTime[v.time] = k

  end

  file.Write("policedata/config.txt",util.TableToJSON(PoliceSysteme))
  net.Start("PoliceText::NotificationText")
  net.WriteString(PoliceSysteme:GetPhrase("succes"))
  net.Send(ply)

  local tbl = util.JSONToTable(file.Read("policedata/config.txt", "DATA"))

  local files, direc = file.Find("policedata/rank/*","DATA")

  for _,v in pairs(files) do

    if istable(PoliceSysteme.Config.Rank[tonumber(file.Read("policedata/rank/" .. v,"DATA"))]) then continue end

    file.Write("policedata/rank/" .. v,table.GetFirstKey(PoliceSysteme.Config.Rank))

  end

  for _,v in pairs(player.GetAll()) do

    v:SetNWInt("Rank::PlayerIDInTbl",tonumber(file.Read("policedata/rank/" .. v:SteamID64() .. ".txt","DATA")))

    net.Start("PoliceSysteme::ConfigSendPlayer")
    net.WriteTable(PoliceSysteme.Config)
    net.WriteTable(PoliceSysteme.Config.Rank)
    net.Send(v)

  end

end)



local CMoveData = FindMetaTable("CMoveData")

function CMoveData:RemoveKeys(keys)

	local newbuttons = bit.band(self:GetButtons(), bit.bnot(keys))
	self:SetButtons(newbuttons)

end


hook.Add("Move","Move::MoveCanMoove",function(ply,mv)

  if ply:GetNWBool("WasInaFloor") then
    mv:SetMaxSpeed(0)
    return false
  end

end)

hook.Add("PlayerSwitchWeapon","PlayerSwitchWeapon::PlayerSwitchWeaponCanPlayer",function(ply)

  if ply:GetNWBool("WasInaFloor") then
    return true
  end

end)

hook.Add("SetupMove", "Disable Jumping", function(ply, mvd, cmd)

  if ply:GetNWBool("WasInaFloor") then

  	if mvd:KeyDown(IN_JUMP) then

  		mvd:RemoveKeys(IN_JUMP)

    elseif mvd:KeyDown(IN_DUCK) then

      mvd:RemoveKeys(IN_DUCK)

  	end

  end

end)
