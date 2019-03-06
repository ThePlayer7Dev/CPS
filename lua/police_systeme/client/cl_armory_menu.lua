local Fonction = {}

local Mate = {

  [1] = Material("materials/police_systeme/monitor.png"),
  [2] = Material("materials/police_systeme/computer2.png"),
  [3] = Material("materials/police_systeme/onoff.png"),
  [4] = Material("materials/police_systeme/policier.png"),
  [5] = Material("materials/police_systeme/blocnote.png"),
  [6] = Material("materials/police_systeme/wanted.png"),
  [7] = Material("materials/police_systeme/loupe.png"),
  [8] = Material("materials/police_systeme/edit.png"),
  [9] = Material("materials/police_systeme/fenetre.png"),
  [10] = Material("materials/police_systeme/barre1.png"),
  [11] = Material("materials/police_systeme/windows.jpg"),
  [12] = Material("materials/police_systeme/dossier.png"),
  [13] = Material("materials/police_systeme/text.png"),
  [14] = Material("materials/police_systeme/on.png"),
  [15] = Material("materials/police_systeme/off.png"),
}


concommand.Add("ConfigArmory",function()

   local AntiSpam = 0

   if IsValid(c_Model) then
     c_Model:Remove()
   end

   local c_Model

   c_Model = ents.CreateClientProp()
   c_Model:SetPos(LocalPlayer():GetPos())
   c_Model:SetAngles(Angle(0,0,0))
   c_Model:SetModel(PoliceSysteme.Config.Model.Armory)
   c_Model:Spawn()
   c_Model:SetColor(Color(0,0,0,150))
   c_Model:SetRenderMode(RENDERMODE_TRANSALPHA)

   local min = c_Model:OBBMins()

   hook.Add("Think","Think::DrawModelArmory",function()

     c_Model:SetPos(LocalPlayer():GetEyeTrace().HitPos - LocalPlayer():GetEyeTrace().HitNormal * min.z)

     if LocalPlayer():KeyDown(IN_ATTACK) then

       c_Model:Remove()
       hook.Remove("Think","Think::DrawModelArmory")

       net.Start("Armory::Create")
       net.WriteAngle(c_Model:GetAngles())
       net.WriteVector(c_Model:GetPos())
       net.SendToServer()

     elseif LocalPlayer():KeyDown(IN_RELOAD) then

       if AntiSpam < CurTime() then

         local ang = c_Model:GetAngles()
         ang:RotateAroundAxis(ang:Up(), 45)

         c_Model:SetAngles(ang)

         AntiSpam = CurTime() + 0.5

       end

     elseif LocalPlayer():KeyDown(IN_ATTACK2) then

       c_Model:Remove()
       hook.Remove("Think","Think::DrawModelArmory")

     end

   end)

end)


 local FonctionConfig = {}
 FonctionConfig.ent = {}
 FonctionConfig.Tbl = {}

 net.Receive("Armory::SetPosWeapon",function()

   local menu_cump = {}

   FonctionConfig.frame = vgui.Create("DFrame")
   FonctionConfig.frame:SetSize(ScrW()/5, ScrH()/1)
   FonctionConfig.frame:SetPos(ScrW() - ScrW()/5,0)
   FonctionConfig.frame:SetTitle("")
   FonctionConfig.frame:ShowCloseButton(false)
   FonctionConfig.frame:SetVisible(true)
   FonctionConfig.frame:SetDraggable(false)
   FonctionConfig.frame.Paint = function(self,w,h)

     surface.SetDrawColor(255,255,255)
     surface.SetMaterial(Mate[9])
     surface.DrawTexturedRect(0, -h + h/1.1, w, h*1.1)

   end


   menu_cump.close = vgui.Create("DButton", FonctionConfig.frame)
   menu_cump.close:SetSize(FonctionConfig.frame:GetWide() / 10, FonctionConfig.frame:GetTall() / 18)
   menu_cump.close:SetPos(FonctionConfig.frame:GetWide() - menu_cump.close:GetWide() * 1.1, ScrH() / 50)
   menu_cump.close:SetText("")
   menu_cump.close.OnCursorEntered = function(self)

     surface.PlaySound("UI/buttonrollover.wav")

   end
   menu_cump.close.Paint = function(self,w,h)

     if self:IsHovered() then

       draw.DrawText("X", "FontPolice2", w / 2, h / 50 - 5, Color(200, 0, 0, 255), TEXT_ALIGN_CENTER)

     else

       draw.DrawText("X", "FontPolice2", w / 2, h / 50 - 5, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER)

     end

   end
   menu_cump.close.DoClick = function()

     surface.PlaySound("UI/buttonclick.wav")
     FonctionConfig.frame:Remove()

     net.Start("Armory::StopConfig")
     net.SendToServer()

     for _,v in pairs(FonctionConfig.ent) do

       if IsValid(v) then

         v:Remove()

       end

     end

   end

   FonctionConfig.panel3 = vgui.Create("DPanel", FonctionConfig.frame)
   FonctionConfig.panel3:SetSize(FonctionConfig.frame:GetWide() / 1.2, FonctionConfig.frame:GetTall() / 1.2)
   FonctionConfig.panel3:Center()
   FonctionConfig.panel3.Paint = function(self, w, h)
   end

   menu_cump.scroll = vgui.Create("DScrollPanel", FonctionConfig.panel3)
   menu_cump.scroll:Dock(FILL)


   menu_cump.sbar = menu_cump.scroll:GetVBar()
   function menu_cump.sbar:Paint()end
   function menu_cump.sbar.btnUp:Paint() end
   function menu_cump.sbar.btnDown:Paint() end
   function menu_cump.sbar.btnGrip:Paint() end

   FonctionConfig.layout = vgui.Create("DIconLayout", menu_cump.scroll)
   FonctionConfig.layout:Dock(FILL)
   FonctionConfig.layout:SetSpaceY(5)
   FonctionConfig.layout:SetSpaceX(5)

   menu_cump.Weap = vgui.Create("DButton", FonctionConfig.layout)
   menu_cump.Weap:SetSize(FonctionConfig.panel3:GetWide(), FonctionConfig.panel3:GetTall() / 15)
   menu_cump.Weap:SetText("")
   menu_cump.Weap.OnCursorEntered = function(self)

     surface.PlaySound("UI/buttonrollover.wav")

   end
   menu_cump.Weap.Paint = function(self,w,h)

     if self:IsHovered() then

       draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

     else

       draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 100))

     end

     draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("addweap"),"FontPolice2", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

   end

   menu_cump.Weap.DoClick = function()

     Fonction.ConfigWeapon()

   end

 end)

function Fonction.ConfigWeapon()

  local menu_cump = {}

  menu_cump.frame = vgui.Create("DFrame")
  menu_cump.frame:SetSize(ScrW() / 2, ScrH() / 2)
  menu_cump.frame:Center()
  menu_cump.frame:SetTitle("")
  menu_cump.frame:ShowCloseButton(true)
  menu_cump.frame:SetVisible(true)
  menu_cump.frame:SetDraggable(false)
  menu_cump.frame:MakePopup()
  menu_cump.frame.Paint = function(self,w,h)

    surface.SetDrawColor(255,255,255)
    surface.SetMaterial(Mate[9])
    surface.DrawTexturedRect(0, 0, w, h)

    draw.RoundedBox(0, 0, 0, w, h/20, Color(0, 0, 0, 255))

    draw.DrawText("Model : ", "FontPolice2", w / 2, h / 4, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)
    draw.DrawText("ClassName : ", "FontPolice2", w / 2, h / 1.9, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER)

  end

  menu_cump.TextEntry1 = vgui.Create("DTextEntry", menu_cump.frame)
  menu_cump.TextEntry1:SetSize(menu_cump.frame:GetWide() / 2.5, menu_cump.frame:GetTall() / 15)
  menu_cump.TextEntry1:SetText("")
  menu_cump.TextEntry1:Center()
  menu_cump.TextEntry1:CenterVertical(0.35)

  menu_cump.TextEntry2 = vgui.Create("DTextEntry", menu_cump.frame)
  menu_cump.TextEntry2:SetSize(menu_cump.frame:GetWide() / 2.5, menu_cump.frame:GetTall() / 15)
  menu_cump.TextEntry2:SetText("")
  menu_cump.TextEntry2:Center()
  menu_cump.TextEntry2:CenterVertical(0.65)

  menu_cump.Validate = vgui.Create("DButton", menu_cump.frame)
  menu_cump.Validate:SetSize(menu_cump.frame:GetWide() / 5, menu_cump.frame:GetTall() / 18)
  menu_cump.Validate:Center()
  menu_cump.Validate:CenterVertical(0.8)
  menu_cump.Validate:SetText("")
  menu_cump.Validate.OnCursorEntered = function(self)

    surface.PlaySound("UI/buttonrollover.wav")

  end
  menu_cump.Validate.Paint = function(self,w,h)

    if self:IsHovered() then

      draw.DrawText(PoliceSysteme:GetPhrase("valid"), "FontPolice2", w / 2, h / 50 - 5, Color(200, 0, 0, 255), TEXT_ALIGN_CENTER)

    else

      draw.DrawText(PoliceSysteme:GetPhrase("valid"), "FontPolice2", w / 2, h / 50 - 5, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER)

    end

  end
  menu_cump.Validate.DoClick = function()
    surface.PlaySound("UI/buttonclick.wav")

    if menu_cump.TextEntry1:GetValue() != "" and menu_cump.TextEntry2:GetValue() != "" and menu_cump.TextEntry1:GetValue() != nil and menu_cump.TextEntry2:GetValue() != nil then

      Fonction.PlaceWeap(menu_cump.TextEntry1:GetValue(),menu_cump.TextEntry2:GetValue())
      menu_cump.frame:Remove()

    end

  end

end

function Fonction.PlaceWeap(mdl,str)

  local AntiSpam = 0

  if IsValid(c_Model) then
    c_Model:Remove()
  end

  local ang = LocalPlayer():GetNWEntity("Entity::Armory"):GetAngles()
	ang:RotateAroundAxis(ang:Up(), 270)
	ang:RotateAroundAxis(ang:Right(), 180)
	ang:RotateAroundAxis(ang:Forward(), 270)

  local c_Model2 = ents.CreateClientProp()
  c_Model2:SetAngles(ang)
  c_Model2:SetModel(mdl)
  c_Model2:Spawn()
  c_Model2:SetColor(Color(255,255,255,255))
  c_Model2:SetRenderMode(RENDERMODE_TRANSALPHA)
  c_Model2.Class = str

  local min = c_Model2:OBBMins()

  hook.Add("Think","Think::DrawModelArmory",function()

    if IsValid(LocalPlayer():GetEyeTrace().Entity) and LocalPlayer():GetEyeTrace().Entity:GetClass() == "armory_police" then

      c_Model2:SetPos(LocalPlayer():GetEyeTrace().HitPos - LocalPlayer():GetEyeTrace().HitNormal * min.z + Vector(0,0,-5))

      if LocalPlayer():KeyDown(IN_ATTACK) then

        c_Model2:SetParent(ent)

        hook.Remove("Think","Think::DrawModelArmory")
        table.insert(FonctionConfig.Tbl, {pos = c_Model2:GetPos(), class = str, model = mdl})
        table.insert(FonctionConfig.ent,c_Model2)
        Fonction.AddWeaponContextmenu(str,mdl,ent)

      elseif LocalPlayer():KeyDown(IN_ATTACK2) then

        c_Model2:Remove()
        hook.Remove("Think","Think::DrawModelArmory")

      end

    end

  end)

end

function Fonction.AddWeaponContextmenu(str,mdl,ent)

  if FonctionConfig.layout then

    FonctionConfig.layout:Remove()

  end

  local menu_cump = {}

  FonctionConfig.panel3 = vgui.Create("DPanel", FonctionConfig.frame)
  FonctionConfig.panel3:SetSize(FonctionConfig.frame:GetWide() / 1.2, FonctionConfig.frame:GetTall() / 1.2)
  FonctionConfig.panel3:Center()
  FonctionConfig.panel3.Paint = function(self, w, h)
  end

  menu_cump.scroll = vgui.Create("DScrollPanel", FonctionConfig.panel3)
  menu_cump.scroll:Dock(FILL)


  menu_cump.sbar = menu_cump.scroll:GetVBar()
  function menu_cump.sbar:Paint()end
  function menu_cump.sbar.btnUp:Paint() end
  function menu_cump.sbar.btnDown:Paint() end
  function menu_cump.sbar.btnGrip:Paint() end


  FonctionConfig.layout = vgui.Create("DIconLayout", menu_cump.scroll)
  FonctionConfig.layout:Dock(FILL)
  FonctionConfig.layout:SetSpaceY(5)
  FonctionConfig.layout:SetSpaceX(5)

  menu_cump.Weap = vgui.Create("DButton", FonctionConfig.layout)
  menu_cump.Weap:SetSize(FonctionConfig.panel3:GetWide(), FonctionConfig.panel3:GetTall() / 15)
  menu_cump.Weap:SetText("")
  menu_cump.Weap.OnCursorEntered = function(self)

    surface.PlaySound("UI/buttonrollover.wav")

  end
  menu_cump.Weap.Paint = function(self,w,h)

    if self:IsHovered() then

      draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

    else

      draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 100))

    end

    draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("addweap"),"FontPolice2", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

  end

  menu_cump.Weap.DoClick = function()

    Fonction.ConfigWeapon()
    surface.PlaySound("UI/buttonclick.wav")

  end

  menu_cump.Valide = vgui.Create("DButton", FonctionConfig.layout)
  menu_cump.Valide:SetSize(FonctionConfig.panel3:GetWide(), FonctionConfig.panel3:GetTall() / 15)
  menu_cump.Valide:SetText("")
  menu_cump.Valide.OnCursorEntered = function(self)

    surface.PlaySound("UI/buttonrollover.wav")

  end
  menu_cump.Valide.Paint = function(self,w,h)

    if self:IsHovered() then

      draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

    else

      draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 100))

    end
    draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("valid"),"FontPolice2", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

  end

  menu_cump.Valide.DoClick = function()

    net.Start("Armory::ValideConfig")
    net.WriteTable(FonctionConfig.Tbl)
    net.SendToServer()

    for _,v in pairs(FonctionConfig.ent) do
      v:Remove()
    end
    FonctionConfig.frame:Remove()
    surface.PlaySound("UI/buttonclick.wav")

  end

  for _,v in pairs(FonctionConfig.Tbl) do

    menu_cump.Weapon = vgui.Create("DButton", FonctionConfig.layout)
    menu_cump.Weapon:SetSize(FonctionConfig.panel3:GetWide(), FonctionConfig.panel3:GetTall() / 15)
    menu_cump.Weapon:SetText("")
    menu_cump.Weapon:SetVisible(true)
    menu_cump.Weapon.OnCursorEntered = function(self)

      surface.PlaySound("UI/buttonrollover.wav")

    end
    menu_cump.Weapon.Paint = function(self,w,h)

      if self:IsHovered() then

        draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))
        draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("delete"),"FontPolice2", w / 2, h / 1.4, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))
        draw.SimpleTextOutlined(v.class,"FontPolice3", w / 2, h / 3.7, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

      else

        draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 100))
        draw.SimpleTextOutlined(v.class,"FontPolice2", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

      end

    end

    menu_cump.Weapon.DoClick = function(self)

      table.RemoveByValue(FonctionConfig.Tbl,v)
      self:Remove()

    end

  end

end

net.Receive("PoliceSysteme::ConfigSendPlayer",function()

  PoliceSysteme.Config = net.ReadTable()
  PoliceSysteme.Config.Rank = net.ReadTable()

end)
