surface.CreateFont("FontNick1", {
    font = "Roboto",
    size = 30,
    weight = 500,
})

surface.CreateFont("FontNick2", {
    font = "Roboto",
    size = 25,
    weight = 500,
})

local Mat = {

  [1] = Material("materials/police_systeme/ping1.png")
}

hook.Add("HUDPaint","HUDPaint::RankOnHead",function()

  if not PoliceSysteme.Config.RankAndNick then return end
  if not table.HasValue(PoliceSysteme.Config.TeamPolice, LocalPlayer():Team()) then return end
  for _, v in pairs(player.GetAll()) do

    if not table.HasValue(PoliceSysteme.Config.TeamPolice, v:Team()) then continue end

    if v:GetNWVector("Vector::PingPolice") != Vector(0,0,0) then

      v.PosToScreen = v:GetNWVector("Vector::PingPolice"):ToScreen()
      surface.SetDrawColor(255,255,255)
      surface.SetMaterial(Mat[1])
      surface.DrawTexturedRect(v.PosToScreen.x - 25, v.PosToScreen.y - 50, 50, 50)
      draw.SimpleTextOutlined(math.Round(math.sqrt(v:GetNWVector("Vector::PingPolice"):DistToSqr(LocalPlayer():GetPos())) / 20) .. "m","FontNick2", v.PosToScreen.x, v.PosToScreen.y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
      draw.SimpleTextOutlined(v:Nick(),"FontNick2", v.PosToScreen.x, v.PosToScreen.y+20, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))

    end

    if v == LocalPlayer() then continue end

    local shootPos = LocalPlayer():GetShootPos()
    local aimVec = LocalPlayer():GetAimVector()
    local hisPos = v:GetShootPos()

    if hisPos:DistToSqr(shootPos) < PoliceSysteme.Config.DistanceMaxSee then

    local pos = v:GetPos() + Vector(0,0,70 - hisPos:DistToSqr(shootPos) / 15000)
    pos = pos:ToScreen()

    local poss = hisPos - shootPos
    local unitPos = poss:GetNormalized()

      if unitPos:Dot(aimVec) > 0.5 and pos.visible then
      local trace = util.QuickTrace(shootPos, poss, LocalPlayer())

        if trace.Hit and trace.Entity ~= v then break end

        draw.SimpleTextOutlined(v:Nick(),"FontNick1", pos.x, pos.y - 100 , PoliceSysteme.Config.ColorTextNick, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, PoliceSysteme.Config.ColorStrokeNick)
        draw.SimpleTextOutlined(v:GetPoliceRankName(),"FontNick2", pos.x, pos.y - 80, PoliceSysteme.Config.ColorTextRank, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, PoliceSysteme.Config.ColorStrokeRank)

      end

    end

  end

end)

net.Receive("PoliceSysteme::EmergencyCall",function()

  local ent = net.ReadEntity()
  local color = PoliceSysteme.Config.Color1

  hook.Add("HUDPaint","HUDPaint::DrawEmergency",function()

    if IsValid(ent) and ent:IsPlayer() then

      local pos = ent:GetPos():ToScreen()
      local shootPos = LocalPlayer():GetShootPos()
      local hisPos = ent:GetShootPos()
      local dist = hisPos:DistToSqr(shootPos)

      if dist > 2000 then

        if pos.visible then

          if PoliceSysteme.Config.DrawIconDanger then

            surface.SetDrawColor(255,255,255)
            surface.SetMaterial(PoliceSysteme.Material.MaterialDanger)
            surface.DrawTexturedRect(pos.x - 25, pos.y - 120, 50, 50)

          end

          draw.SimpleTextOutlined(ent:Nick() .. PoliceSysteme:GetPhrase("help"),"FontNick1", pos.x, pos.y - 75, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))

        end

        if not PoliceSysteme.Config.ColorChange or LocalPlayer().AntiSpam and LocalPlayer().AntiSpam > CurTime() then return end
        if color == PoliceSysteme.Config.Color1 then

          color = PoliceSysteme.Config.Color2

        else

          color = PoliceSysteme.Config.Color1

        end

        LocalPlayer().AntiSpam = CurTime() + 0.5


      else

        hook.Remove("HUDPaint","HUDPaint::DrawEmergency")

      end

    else

      hook.Remove("HUDPaint","HUDPaint::DrawEmergency")

    end

  end)

end)

net.Receive("PoliceSysteme::EmergencyCallCancel",function()

  hook.Remove("HUDPaint","HUDPaint::DrawEmergency")

end)
