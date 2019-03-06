include("shared.lua")

local Mate = {

  [1] = Material("materials/police_systeme/prison1.png"),
	[2] = Material("materials/police_systeme/prison2.png"),
  [3] = Material("materials/police_systeme/fleche1.png"),
}

local function BoutonSetPos(ent,x,y,w,h)

	local mins, maxs = ent:OBBMins() , ent:OBBMaxs()

	pos1 = Vector(mins.x, mins.y + w/10 + x/10, ent:OBBCenter().z + 7)
  pos2 = Vector(mins.x + h/10 + y/10, mins.y , ent:OBBCenter().z - 7)

	pos1 = ent:LocalToWorld(pos1)
  pos2 = ent:LocalToWorld(pos2)

	return ent:LocalToWorld(Vector(maxs.x, mins.y + maxs.y/2 , ent:OBBCenter().z - 10))

end

local function BoutonPosMaxX(ent)

	local mins, maxs = ent:OBBMins() , ent:OBBMaxs()

	return LocalPlayer():GetEyeTrace().HitPos:WithinAABox(ent:LocalToWorld(Vector(mins.x, maxs.y , ent:OBBCenter().z + 10)), ent:LocalToWorld(Vector(mins.x/1.01 + maxs.x, mins.y + maxs.y , ent:OBBCenter().z - 10)))

end

local function BoutonPosMinX(ent)

	local mins, maxs = ent:OBBMins() , ent:OBBMaxs()

	return LocalPlayer():GetEyeTrace().HitPos:WithinAABox(ent:LocalToWorld(Vector(mins.x, mins.y, ent:OBBCenter().z+10)), ent:LocalToWorld(Vector(mins.x/1.01 + maxs.x, mins.y + maxs.y , ent:OBBCenter().z - 10)))

end

local function BoutonPosMaxY(ent)

	local mins, maxs = ent:OBBMins() , ent:OBBMaxs()

	return LocalPlayer():GetEyeTrace().HitPos:WithinAABox(ent:LocalToWorld(Vector(mins.x/1.01 + maxs.x, maxs.y , ent:OBBCenter().z + 10)), ent:LocalToWorld(Vector(maxs.x, mins.y/2 + maxs.y , ent:OBBCenter().z - 10)))

end

local function BoutonPosMinY(ent)

	local mins, maxs = ent:OBBMins() , ent:OBBMaxs()

	return LocalPlayer():GetEyeTrace().HitPos:WithinAABox(ent:LocalToWorld(Vector(mins.x/1.01 + maxs.x, mins.y, ent:OBBCenter().z+10)), ent:LocalToWorld(Vector(maxs.x, mins.y + maxs.y/2 , ent:OBBCenter().z - 10)))

end

local LastKey = true
local id = 1

function ENT:Draw()

    self.TablePlayer = {}

    for _,v in pairs(ents.FindInSphere(self:GetPos(),200)) do

      if not v:IsPlayer() then continue end
      if table.HasValue(PoliceSysteme.Config.TeamPolice, v:Team()) then continue end

      table.insert(self.TablePlayer,v)

    end

    local ang = self:GetAngles()
    ang:RotateAroundAxis(ang:Up(), 270)

    cam.Start3D2D(self:GetPos() + self:GetForward() * -10 + self:GetUp() * 1.55, ang , 0.1)

      if BoutonPosMinX(self) then   -- "UnArrest"

        draw.RoundedBox(0,0,-340/3.295,950/2,475/2,Color(85, 140, 57))

        if LocalPlayer():KeyDown(IN_USE) and LastKey == true then

          LastKey = false

          net.Start("Arrest::UnArrestPlayer")
          net.WriteEntity(self.TablePlayer[id])
          net.SendToServer()

        elseif not LocalPlayer():KeyDown(IN_USE) then

          LastKey = true

        end

      else

        draw.RoundedBox(0,0,-340/3.295,950/2,475/2,Color(85, 167, 57))

      end

			surface.SetDrawColor(255,255,255)
			surface.SetMaterial(Mate[2])
			surface.DrawTexturedRect(125,-340/3.5,475/2,475/2)


      if BoutonPosMaxX(self) then    -- "Arrest"

        draw.RoundedBox(0,-475,-340/3.295,950/2,475/2,Color(142, 18, 27))

        if LocalPlayer():KeyDown(IN_USE) and LastKey == true then

          LastKey = false

          net.Start("Arrest::ArrestPlayer")
          net.WriteEntity(self.TablePlayer[id])
          net.SendToServer()

        elseif not LocalPlayer():KeyDown(IN_USE) then

          LastKey = true

        end

      else

        draw.RoundedBox(0,-475,-340/3.295,950/2,475/2,Color(158, 18, 27))

      end

			surface.SetDrawColor(255,255,255)
			surface.SetMaterial(Mate[1])
			surface.DrawTexturedRect(-370,-340/3.5,475/2,475/2)


      if BoutonPosMaxY(self) then    -- "<"

        draw.RoundedBox(0,-475,-340,950/4,475/2,Color(0, 0, 200))

        if LocalPlayer():KeyDown(IN_USE) and LastKey == true then

          LastKey = false

          if id == 1 then

            id = #self.TablePlayer

          else

            id = id -1

          end

        elseif not LocalPlayer():KeyDown(IN_USE) then

          LastKey = true

        end

      else

        draw.RoundedBox(0,-475,-340,950/4,475/2,Color(50, 120, 255))

      end


      surface.SetDrawColor(255,255,255)
      surface.SetMaterial(Mate[3])
      surface.DrawTexturedRectRotated(-380,-210,950/4,475/2,180)



      if BoutonPosMinY(self) then    -- ">"

        draw.RoundedBox(0,950/4,-340,950/4,475/2,Color(0, 0, 200))

        if LocalPlayer():KeyDown(IN_USE) and LastKey == true then

          LastKey = false
          if id == #self.TablePlayer then

            id = 1

          else

            id = id + 1

          end

        elseif not LocalPlayer():KeyDown(IN_USE) then

          LastKey = true

        end

      else

        draw.RoundedBox(0,950/4,-340,950/4,475/2,Color(50, 120, 255))

      end

      surface.SetDrawColor(255,255,255)
      surface.SetMaterial(Mate[3])
      surface.DrawTexturedRect(950/4,-340,950/4,475/2)


      draw.RoundedBox(0,-950/4,-340,950/2,475/2,Color(255, 255, 255))
			draw.RoundedBox(0,-475,-340/3.295,950,475/25,Color(0, 0, 0))
      draw.RoundedBox(0,-475,-340,950,475/25,Color(0, 0, 0))
      draw.RoundedBox(0,-475,118,950,475/25,Color(0, 0, 0))
			draw.RoundedBox(0,-475 - 950/50,-340,950/50,475,Color(0, 0, 0))
      draw.RoundedBox(0,475,-340,950/50,475,Color(0, 0, 0))

      if #self.TablePlayer >= 1 and IsValid(self.TablePlayer[id]) then

        draw.SimpleTextOutlined("Statut :","Font::2d3d1", 0, -180 , Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
        if self.TablePlayer[id]:isArrested() then

          draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("arrested"),"Font::2d3d1", 0, -135 , Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

        else

          draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("free"),"Font::2d3d1", 0, -135 , Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

        end

        draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("name") .. " :","Font::2d3d1", 0, -300 , Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
        draw.SimpleTextOutlined(self.TablePlayer[id]:Nick(),"Font::2d3d1", 0, -260 , Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      else

        id = 1

      end

    cam.End3D2D()

end
