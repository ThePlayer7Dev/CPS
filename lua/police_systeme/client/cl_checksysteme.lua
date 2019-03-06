local size = 0
local AntiBugHUD = CurTime()

hook.Add("PostDrawOpaqueRenderables","PostDrawOpaqueRenderables::SetPressEToSetOnthefloor",function()

  local ang = Angle(0,LocalPlayer():EyeAngles().y - 90,90)

  if LocalPlayer():GetNWBool("WasInaFloor") then

    cam.Start3D2D(LocalPlayer():GetPos() + LocalPlayer():GetForward() * 40 + Vector(0,0,50), ang , 0.1)

      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("wakeupply"),"Font::2d3d4", 125, -30, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
      draw.SimpleTextOutlined("E","Font::2d3d4", 125, -5, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
      draw.SimpleTextOutlined(math.Round(size/190*100) .. "%","Font::2d3d4", 125, 45, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))

      draw.RoundedBox(3,25,7.5,200,25,Color(255, 255, 255))
      draw.RoundedBox(3,30,10,size,20,Color(0, 0, 255))

    cam.End3D2D()

    if LocalPlayer():KeyDown(IN_USE) then

      if size >= 190 then

        size = 0
        net.Start("PoliceSysteme::SetDown")
        net.WriteEntity(LocalPlayer())
        net.SendToServer()

      else

        size = size + 0.2

      end

    else

      size = 0

    end

  end

  if AntiBugHUD > CurTime() then return end
  if not table.HasValue(PoliceSysteme.Config.TeamPolice, LocalPlayer():Team()) then return end
  local ent = LocalPlayer():GetEyeTrace().Entity
  if not IsValid(ent) or not ent:IsPlayer() or table.HasValue(PoliceSysteme.Config.TeamPolice, ent:Team()) then return end

  if LocalPlayer():GetPos():DistToSqr(ent:GetPos()) < 5000 and LocalPlayer():KeyDown(IN_ATTACK2) then
    cam.Start3D2D(ent:GetPos() + ent:GetUp() * 50 + LocalPlayer():GetRight() * 15, ang , 0.1)

      if ent:GetNWBool("WasInaFloor") then
        draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("wakeup"),"Font::2d3d4", 125, -30, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
      else
        draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("putdown"),"Font::2d3d4", 125, -30, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
      end

      draw.SimpleTextOutlined("E","Font::2d3d4", 125, -5, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
      draw.SimpleTextOutlined(math.Round(size/190*100) .. "%","Font::2d3d4", 125, 45, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0))
      draw.RoundedBox(3,25,7.5,200,25,Color(255, 255, 255))
      draw.RoundedBox(3,30,10,size,20,Color(0, 0, 255))

    cam.End3D2D()

    if LocalPlayer():KeyDown(IN_USE) then

      if size >= 190 then

        size = 0
        net.Start("PoliceSysteme::SetDown")
        net.WriteEntity(ent)
        net.SendToServer()
        AntiBugHUD = CurTime() + 0.8

      else

        size = size + 1

      end

    else

      size = 0

    end

  end

end)
