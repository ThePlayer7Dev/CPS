surface.CreateFont("FontPolice1", {
    font = "Roboto",
    size = ScrW() / 40,
    weight = ScrW()/1.366,
})

surface.CreateFont("FontPolice2", {
    font = "Roboto",
    size = ScrW() / 50,
    weight = ScrW() / 1.95,
})

surface.CreateFont("FontPolice3", {
    font = "Roboto",
    size = ScrW() / 80,
    weight = ScrW() / 1.366,
})

surface.CreateFont("FontPolice4", {
    font = "Roboto",
    size = ScrW() / 200,
    weight = ScrW() / 4,
})

surface.CreateFont("FontPolice5", {
    font = "Roboto",
    size = ScrW() / 100,
    weight = ScrW() / 4,
})

surface.CreateFont("FontPolice6", {
    font = "Roboto",
    size = ScrW() / 80,
    weight = ScrW() / 10,
})

surface.CreateFont("FontPolice7", {
    font = "Roboto",
    size = ScrW() / 50,
    weight = ScrW() / 10,
})

local configmenu = include("cl_configmenu.lua")

local Fonction = {}
Fonction.Texte = ""
Fonction.LastBoutton = ""

function Fonction.timeToStr( time )
  local tnp = time
  local s = tnp % 60
  tnp = math.floor(tnp / 60)
  local m = tnp % 60
  tnp = math.floor(tnp / 60)
  local h = tnp % 24 + 1
  tnp = math.floor(tnp / 24)


  return string.format("%02i:%02i", h, m)
end


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
  [10] = Material("materials/police_systeme/barre2.png"),
  [11] = Material("materials/police_systeme/windows.jpg"),
  [12] = Material("materials/police_systeme/dossier.png"),
  [13] = Material("materials/police_systeme/text.png"),
  [14] = Material("materials/police_systeme/on.png"),
  [15] = Material("materials/police_systeme/off.png"),
  [16] = Material("materials/police_systeme/prison1.png"),
  [17] = Material("materials/police_systeme/page1.png"),
  [18] = Material("materials/police_systeme/windowover.png"),
  [19] = Material("materials/police_systeme/close1.png"),
  [20] = Material("materials/police_systeme/close2.png"),
  [21] = Material("materials/police_systeme/world.png"),
  [22] = Material("materials/police_systeme/textreport.png"),
  [23] = Material("materials/police_systeme/title.png"),
  [24] = Material("materials/police_systeme/internet.png"),
  [25] = Material("materials/police_systeme/chrome.png"),
  [26] = Material("materials/police_systeme/parametreicon.png"),
}


function Fonction.OpenLitleMenu(frame)

  local Menu_Cump = {}

  Menu_Cump.frame = vgui.Create("DFrame", frame)
  Menu_Cump.frame:SetSize(frame:GetWide() / 1, frame:GetTall() / 1.05)
  Menu_Cump.frame:SetPos(0,0)
  Menu_Cump.frame:SetTitle("")
  Menu_Cump.frame:ShowCloseButton(false)
  Menu_Cump.frame:SetVisible(true)
  Menu_Cump.frame:SetDraggable(false)
  Menu_Cump.frame:MakePopup()
  Menu_Cump.frame.Paint = function(self,w,h)

    surface.SetDrawColor(255,255,255)
    surface.SetMaterial(Mate[17])
    surface.DrawTexturedRect(0, 0, w, h)
    draw.SimpleTextOutlined(Fonction.Texte,"FontPolice5", w / 10.7, h / 13.4, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
    draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("fastacces"),"FontPolice5", w / 30, h / 7.54, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

  end

  Menu_Cump.frame.Think = function(self)
	   self:MoveToFront()
  end

  Menu_Cump.close = vgui.Create("DButton", Menu_Cump.frame)
  Menu_Cump.close:SetSize(Fonction.frame:GetWide() / 33.1, Fonction.frame:GetTall() / 30)
  Menu_Cump.close:SetPos(Fonction.frame:GetWide() - Menu_Cump.close:GetWide(),0)
  Menu_Cump.close:SetText("")
  Menu_Cump.close.Paint = function(self,w,h)

    if self:IsHovered() then

      surface.SetDrawColor(255,255,255)
      surface.SetMaterial(Mate[19])
      surface.DrawTexturedRect(0, 0, w, h)

    else

      surface.SetDrawColor(255,255,255)
      surface.SetMaterial(Mate[20])
      surface.DrawTexturedRect(0, 0, w, h)

    end

  end
  Menu_Cump.close.DoClick = function()

    Menu_Cump.frame:Remove()

  end

  return Menu_Cump.frame

end

function Fonction.OpenComputer()

    local menu_cump = {}
    local tbl = net.ReadTable()

    Fonction.frame = vgui.Create("DFrame")
    Fonction.frame:SetSize(ScrW()/1, ScrH()/1)
    Fonction.frame:SetTitle("")
    Fonction.frame:ShowCloseButton(false)
    Fonction.frame:SetVisible(true)
    Fonction.frame:SetDraggable(false)
    Fonction.frame:MakePopup()
    Fonction.frame:Center()
    Fonction.frame.Paint = function(self,w,h)

      surface.SetDrawColor(255,255,255)
      surface.SetMaterial(Mate[11])
      surface.DrawTexturedRect(0, 0, w, h)

      surface.SetDrawColor(255,255,255)
      surface.SetMaterial(Mate[10])
      surface.DrawTexturedRect(0, h - h/21.6, w, h/21.6)
      draw.SimpleTextOutlined(Fonction.timeToStr(os.time()),"FontPolice5", w / 1.06, h / 1.034, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))
      draw.SimpleTextOutlined(os.date("%d/%m/%Y"),"FontPolice5", w / 1.06, h / 1.013, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

    end

    menu_cump.close = vgui.Create("DButton", Fonction.frame)
    menu_cump.close:SetSize(Fonction.frame:GetWide() / 32, Fonction.frame:GetTall() / 21.6)
    menu_cump.close:SetPos(0,ScrH() - Fonction.frame:GetTall() / 21.6)
    menu_cump.close:SetText("")
    menu_cump.close.Paint = function(self,w,h)

      if self:IsHovered() then

        surface.SetDrawColor(255,255,255)
        surface.SetMaterial(Mate[18])
        surface.DrawTexturedRect(0, 0, w, h)

      end

    end
    menu_cump.close.DoClick = function()

      Fonction.frame:Remove()

    end

    menu_cump.panel3 = vgui.Create("DPanel", Fonction.frame)
    menu_cump.panel3:SetSize(Fonction.frame:GetWide() / 1.07, Fonction.frame:GetTall() / 1.43)
    menu_cump.panel3:Center()
    menu_cump.panel3:CenterVertical(0.4)
    menu_cump.panel3.Paint = function(self, w, h)
    end

    menu_cump.scroll = vgui.Create("DScrollPanel", menu_cump.panel3)
    menu_cump.scroll:Dock(FILL)


    menu_cump.sbar = menu_cump.scroll:GetVBar()
    function menu_cump.sbar:Paint()end
    function menu_cump.sbar.btnUp:Paint() end
    function menu_cump.sbar.btnDown:Paint() end
    function menu_cump.sbar.btnGrip:Paint() end

    menu_cump.layout = vgui.Create("DIconLayout", menu_cump.scroll)
    menu_cump.layout:Dock(FILL)
    menu_cump.layout:SetSpaceY(ScrW()/192)
    menu_cump.layout:SetSpaceX(ScrW()/192)

    menu_cump.PoliceService = vgui.Create("DButton", menu_cump.layout)
    menu_cump.PoliceService:SetSize(ScrW() / 10.60 / 1, ScrH() / 4.6 / 2.4)
    menu_cump.PoliceService:SetText("")
    menu_cump.PoliceService.Paint = function(self,w,h)

      if self:IsHovered() then

        draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

      end

      if self == Fonction.LastBoutton then

        draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 200))

      end

      surface.SetDrawColor(255,255,255,255)
      surface.SetMaterial(Mate[12])
      surface.DrawTexturedRect(w/3.15, 0, w/3.25, h/1.25)

      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("policeman"),"FontPolice5", w / 2, h / 1.12, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

    end
    menu_cump.PoliceService.DoClick = function(self)

      Fonction.LastBoutton = self

    end
    menu_cump.PoliceService.DoDoubleClick = function()

      local frame = Fonction.OpenLitleMenu(Fonction.frame)
      Fonction.Texte = "PC"
      Fonction.PoliceMan(frame)

    end

    menu_cump.Report = vgui.Create("DButton", menu_cump.layout)
    menu_cump.Report:SetSize(ScrW() / 10.60 / 1, ScrH() / 4.6 / 2.4)
    menu_cump.Report:SetText("")
    menu_cump.Report.Paint = function(self,w,h)

      if self:IsHovered() then

        draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

      end

      if self == Fonction.LastBoutton then

        draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 200))

      end

      surface.SetDrawColor(255,255,255,255)
      surface.SetMaterial(Mate[12])
      surface.DrawTexturedRect(w/3.15, 0, w/3.25, h/1.25)

      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("report"),"FontPolice5", w / 2, h / 1.12, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

    end
    menu_cump.Report.DoClick = function(self)

      Fonction.LastBoutton = self

    end
    menu_cump.Report.DoDoubleClick = function()

      local frame = Fonction.OpenLitleMenu(Fonction.frame)
      Fonction.Texte = "PC"
      Fonction.Rapport(tbl,frame)

    end

    menu_cump.Wanted = vgui.Create("DButton", menu_cump.layout)
    menu_cump.Wanted:SetSize(ScrW() / 10.60 / 1, ScrH() / 4.6 / 2.4)
    menu_cump.Wanted:SetText("")
    menu_cump.Wanted.Paint = function(self,w,h)

      if self:IsHovered() then

        draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

      end

      if self == Fonction.LastBoutton then

        draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 200))

      end

      surface.SetDrawColor(255,255,255,255)
      surface.SetMaterial(Mate[25])
      surface.DrawTexturedRect(w/3.15, 0, w/2.8, w/2.8)

      draw.SimpleTextOutlined("DATA Center","FontPolice5", w / 2, h / 1.12, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

    end
    menu_cump.Wanted.DoClick = function(self)

      Fonction.LastBoutton = self

    end
    menu_cump.Wanted.DoDoubleClick = function()

      local frame = Fonction.OpenLitleMenu(Fonction.frame)
      Fonction.Wantedpersonn(frame)

    end

    if not LocalPlayer():IsSuperAdmin() then return end

    menu_cump.parametre = vgui.Create("DButton", menu_cump.layout)
    menu_cump.parametre:SetSize(ScrW() / 10.60 / 1, ScrH() / 4.6 / 2.4)
    menu_cump.parametre:SetText("")
    menu_cump.parametre.Paint = function(self,w,h)

      if self:IsHovered() then

        draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

      end

      if self == Fonction.LastBoutton then

        draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 200))

      end

      surface.SetDrawColor(255,255,255,255)
      surface.SetMaterial(Mate[26])
      surface.DrawTexturedRect(w/3.15, 0, w/2.8, w/2.8)

      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("setting"),"FontPolice5", w / 2, h / 1.12, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

    end
    menu_cump.parametre.DoClick = function(self)

      Fonction.LastBoutton = self

    end
    menu_cump.parametre.DoDoubleClick = function()

      local frame = Fonction.OpenLitleMenu(Fonction.frame)
      configmenu.OpenMenuConfig(frame)

    end

end

net.Receive("Computer::OpenMenu",Fonction.OpenComputer)


function Fonction.PoliceMan(frame)

  local menu_cump = {}

   menu_cump.frame = frame

   menu_cump.panel3 = vgui.Create("DPanel", menu_cump.frame)
   menu_cump.panel3:SetSize(menu_cump.frame:GetWide() / 1.3, menu_cump.frame:GetTall() / 1.43)
   menu_cump.panel3:Center()
   menu_cump.panel3:CenterVertical(0.45)
   menu_cump.panel3.Paint = function(self, w, h)
   end

   menu_cump.scroll = vgui.Create("DScrollPanel", menu_cump.panel3)
   menu_cump.scroll:Dock(FILL)


   menu_cump.sbar = menu_cump.scroll:GetVBar()
   function menu_cump.sbar:Paint()end
   function menu_cump.sbar.btnUp:Paint() end
   function menu_cump.sbar.btnDown:Paint() end
   function menu_cump.sbar.btnGrip:Paint() end

   menu_cump.layout = vgui.Create("DIconLayout", menu_cump.scroll)
   menu_cump.layout:Dock(FILL)
   menu_cump.layout:SetSpaceY(5)
   menu_cump.layout:SetSpaceX(5)

   for _,v in pairs(player.GetAll()) do

     if not table.HasValue(PoliceSysteme.Config.TeamPolice, v:Team()) then continue end

     menu_cump.Player = vgui.Create("DButton", menu_cump.layout)
     menu_cump.Player:SetSize(menu_cump.panel3:GetWide() / 9, menu_cump.panel3:GetWide() / 8)
     menu_cump.Player:SetText("")
     menu_cump.Player.Paint = function(self,w,h)

       if self:IsHovered() then

         draw.RoundedBox(3, 0, 0, w, h, Color(216, 234, 249, 219))

       end

       surface.SetDrawColor(255,255,255,255)
       surface.SetMaterial(Mate[12])
       surface.DrawTexturedRect(w/6, h/15, ScrW()/10.6/1.7, ScrH()/4.6/1.7)

       local str = string.Explode(" ",v:Nick())

       draw.SimpleTextOutlined(str[1],"FontPolice5", w / 2, h / 1.2, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
       draw.SimpleTextOutlined(str[2],"FontPolice5", w / 2, h / 1.1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

     end

      menu_cump.Player.DoDoubleClick = function(self)

        menu_cump.layout:Remove()
        Fonction.Texte = Fonction.Texte .. " > " .. v:Nick()

        menu_cump.layout = vgui.Create("DIconLayout", menu_cump.scroll)
        menu_cump.layout:Dock(FILL)
        menu_cump.layout:SetSpaceY(5)

        menu_cump.Player = vgui.Create("DButton", menu_cump.layout)
        menu_cump.Player:SetSize(menu_cump.panel3:GetWide() / 9, menu_cump.panel3:GetWide() / 8)
        menu_cump.Player:SetText("")
        menu_cump.Player.Paint = function(self,w,h)

          if self:IsHovered() then

            draw.RoundedBox(3, 0, 0, w, h, Color(216, 234, 249, 219))

          end

          surface.SetDrawColor(255,255,255,255)
          surface.SetMaterial(Mate[25])
          surface.DrawTexturedRect(w/6, h/15, ScrW()/10.6/1.7, ScrW()/10.6/1.7)

          local str = string.Explode(" ",v:Nick())

          draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("infomations"),"FontPolice5", w / 2, h / 1.4, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
          draw.SimpleTextOutlined(str[1],"FontPolice5", w / 2, h / 1.2, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
          draw.SimpleTextOutlined(str[2],"FontPolice5", w / 2, h / 1.1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

        end

        menu_cump.Player.DoDoubleClick = function(self)

          Fonction.LookPlayerInfo(v, menu_cump.frame, true)

        end

      end

   end

end

function Fonction.Wantedpersonn(frame)

  local menu_cump = {}

  menu_cump.frame = frame

  menu_cump.frame.Paint = function(self,w,h)

    surface.SetDrawColor(255,255,255)
    surface.SetMaterial(Mate[24])
    surface.DrawTexturedRect(0, 0, w, h)

    draw.RoundedBox(0, 0, h/10, w, h/1.1, Color(25, 145, 236, 255))
    draw.RoundedBox(0, 0, h/1.3, w, h/4, Color(250, 250, 250, 255))

    draw.SimpleTextOutlined("Loading ...","FontPolice5", w / 90, h / 60, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
    draw.SimpleTextOutlined("https://policenational.org/datacenter","FontPolice5", w / 10, h / 16, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

    draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("welcome"),"FontPolice1", w / 2, h / 5, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

  end

  menu_cump.HTML = vgui.Create( "HTML", menu_cump.frame)
  menu_cump.HTML:SetSize(menu_cump.frame:GetWide() / 4, menu_cump.frame:GetWide() / 5)
  menu_cump.HTML:CenterHorizontal(0.5)
  menu_cump.HTML:CenterVertical(0.6)
  menu_cump.HTML:OpenURL("https://digitalsynopsis.com/wp-content/uploads/2016/06/loading-animations-preloader-gifs-ui-ux-effects-24.gif")

  timer.Simple(3,function()

    if not IsValid(menu_cump.frame) then return end

    menu_cump.HTML:Remove()

    menu_cump.frame.Paint = function(self,w,h)

      surface.SetDrawColor(255,255,255)
      surface.SetMaterial(Mate[24])
      surface.DrawTexturedRect(0, 0, w, h)

      draw.RoundedBox(0, 0, h/10, w, h/1.1, Color(25, 145, 236, 255))
      draw.RoundedBox(0, 0, h/1.3, w, h/4, Color(250, 250, 250, 255))

      draw.SimpleTextOutlined("Data Center", "FontPolice5", w / 90, h / 60, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
      draw.SimpleTextOutlined("https://policenational.org/datacenter","FontPolice5", w / 10, h / 16, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      draw.SimpleTextOutlined("DATA CENTER","FontPolice1", w / 2, h / 5, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))
      draw.SimpleTextOutlined( " - " .. PoliceSysteme:GetPhrase("wanted"),"FontPolice1", w / 20, h / 3, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

    end

    menu_cump.panel3 = vgui.Create("DPanel", menu_cump.frame)
    menu_cump.panel3:SetSize(menu_cump.frame:GetWide() / 1.3, menu_cump.frame:GetTall() / 1.7)
    menu_cump.panel3:Center()
    menu_cump.panel3:CenterVertical(0.7)
    menu_cump.panel3.Paint = function(self, w, h)
    end

    menu_cump.scroll = vgui.Create("DScrollPanel", menu_cump.panel3)
    menu_cump.scroll:Dock(FILL)


    menu_cump.sbar = menu_cump.scroll:GetVBar()
    function menu_cump.sbar:Paint()end
    function menu_cump.sbar.btnUp:Paint() end
    function menu_cump.sbar.btnDown:Paint() end
    function menu_cump.sbar.btnGrip:Paint() end

    menu_cump.layout = vgui.Create("DIconLayout", menu_cump.scroll)
    menu_cump.layout:Dock(FILL)
    menu_cump.layout:SetSpaceY(5)
    menu_cump.layout:SetSpaceX(5)

    menu_cump.Rechearche = vgui.Create("DButton", menu_cump.frame)
    menu_cump.Rechearche:SetSize(menu_cump.panel3:GetWide() / 12, menu_cump.panel3:GetWide() / 12)
    menu_cump.Rechearche:SetPos(ScrW() - (ScrW() - menu_cump.Rechearche:GetWide() / 2), 0)
    menu_cump.Rechearche:CenterVertical(0.2)
    menu_cump.Rechearche:SetText("")
    menu_cump.Rechearche.Angle = 0
    menu_cump.Rechearche.OnCursorEntered = function(self)

      surface.PlaySound("UI/buttonrollover.wav")

    end
    menu_cump.Rechearche.Paint = function(self,w,h)

      if self:IsHovered() then

        draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))
        self.Angle = Lerp(FrameTime()*2, menu_cump.Rechearche.Angle, 90)

      else

        self.Angle = Lerp(FrameTime()*2, menu_cump.Rechearche.Angle, 0)

      end

      surface.SetDrawColor(255,255,255,255)
      surface.SetMaterial(Mate[7])
      surface.DrawTexturedRectRotated(w/2, h/2, w, h, self.Angle)

      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("rech"),"FontPolice5", w / 2, h / 1.2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

    end

    menu_cump.Rechearche.DoClick = function(self)

      menu_cump.panel3:Remove()
      self:Remove()

      menu_cump.frame.Paint = function(self,w,h)

        surface.SetDrawColor(255,255,255)
        surface.SetMaterial(Mate[24])
        surface.DrawTexturedRect(0, 0, w, h)

        draw.RoundedBox(0, 0, h/10, w, h/1.1, Color(25, 145, 236, 255))
        draw.RoundedBox(0, 0, h/1.3, w, h/4, Color(250, 250, 250, 255))

        draw.SimpleTextOutlined("Data Center", "FontPolice5", w / 90, h / 60, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
        draw.SimpleTextOutlined("https://policenational.org/datacenter","FontPolice5", w / 10, h / 16, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

        draw.SimpleTextOutlined("DATA CENTER","FontPolice1", w / 2, h / 5, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))
        draw.SimpleTextOutlined( " - " .. PoliceSysteme:GetPhrase("popu"),"FontPolice1", w / 20, h / 3, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

      end

      menu_cump.panel3 = vgui.Create("DPanel", menu_cump.frame)
      menu_cump.panel3:SetSize(menu_cump.frame:GetWide() / 1.3, menu_cump.frame:GetTall() / 1.7)
      menu_cump.panel3:Center()
      menu_cump.panel3:CenterVertical(0.7)
      menu_cump.panel3.Paint = function(self, w, h)
      end

      menu_cump.scroll = vgui.Create("DScrollPanel", menu_cump.panel3)
      menu_cump.scroll:Dock(FILL)


      menu_cump.sbar = menu_cump.scroll:GetVBar()
      function menu_cump.sbar:Paint()end
      function menu_cump.sbar.btnUp:Paint() end
      function menu_cump.sbar.btnDown:Paint() end
      function menu_cump.sbar.btnGrip:Paint() end

      menu_cump.layout = vgui.Create("DIconLayout", menu_cump.scroll)
      menu_cump.layout:Dock(FILL)
      menu_cump.layout:SetSpaceY(5)
      menu_cump.layout:SetSpaceX(5)

      local playerTable = {}

      for k,v in pairs(player.GetAll()) do

        if v:getDarkRPVar("wanted") or table.HasValue(PoliceSysteme.Config.TeamPolice, v:Team()) then continue end

        tbl = {

          player = v,
          name = v:Nick()

        }

        table.insert(playerTable, tbl)

      end

      local sort_func = function(a,b) return a.name < b.name end
      table.sort(playerTable, sort_func)

      for _,v in pairs(playerTable) do

        menu_cump.Player = vgui.Create("DButton", menu_cump.layout)
        menu_cump.Player:SetSize(menu_cump.panel3:GetWide() / 8, menu_cump.panel3:GetWide() / 8)
        menu_cump.Player:SetText("")
        menu_cump.Player.Paint = function(self,w,h)

          if self:IsHovered() then

            draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

          else

            draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 80))

          end

          local str = string.Explode(" ",v.name)

          draw.SimpleTextOutlined(str[1],"FontPolice5", w / 2, h / 1.3, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))
          draw.SimpleTextOutlined(str[2],"FontPolice5", w / 2, h / 1.1, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

        end

        menu_cump.Player.DoClick = function(self)

          surface.PlaySound("UI/buttonclick.wav")
          Fonction.LookPlayerInfo(v.player, frame, false)
          menu_cump.frame:Remove()

        end

        menu_cump.IconSkin = vgui.Create( "DModelPanel", menu_cump.Player )
        menu_cump.IconSkin:SetSize(menu_cump.panel3:GetWide() / 12, menu_cump.panel3:GetWide() / 12)
        menu_cump.IconSkin:Center()
        menu_cump.IconSkin:CenterVertical(0.3)
        menu_cump.IconSkin:SetModel(v.player:GetModel())
        menu_cump.IconSkin:SetCamPos(Vector(40, 0, 90 ))
        function menu_cump.IconSkin:LayoutEntity( Entity ) return end
        function menu_cump.IconSkin.Entity:GetPlayerColor() return Vector ( 0, 0, 0 ) end
        local headpos = menu_cump.IconSkin.Entity:GetBonePosition( menu_cump.IconSkin.Entity:LookupBone( "ValveBiped.Bip01_Head1" ) )
        menu_cump.IconSkin:SetLookAt( headpos )
        menu_cump.IconSkin:SetCamPos( headpos-Vector( -15, 0, 0 ) )

        end

      end

      local playerTable = {}

      for k,v in pairs(player.GetAll()) do

        if not v:getDarkRPVar("wanted") then continue end

        tbl = {

          player = v,
          name = v:Nick()

        }

        table.insert(playerTable, tbl)

      end

      local sort_func = function(a,b) return a.name < b.name end
      table.sort(playerTable, sort_func)

      for _,v in pairs(playerTable) do

        menu_cump.Player = vgui.Create("DButton", menu_cump.layout)
        menu_cump.Player:SetSize(menu_cump.panel3:GetWide() / 8, menu_cump.panel3:GetWide() / 8)
        menu_cump.Player:SetText("")
        menu_cump.Player.Paint = function(self,w,h)

          if self:IsHovered() then

            draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

          else

            draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 80))

          end

          local str = string.Explode(" ",v.name)

          draw.SimpleTextOutlined(str[1],"FontPolice5", w / 2, h / 1.3, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))
          draw.SimpleTextOutlined(str[2],"FontPolice5", w / 2, h / 1.1, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

        end

        menu_cump.Player.DoClick = function(self)

          surface.PlaySound("UI/buttonclick.wav")
          Fonction.LookPlayerInfo(v.player, frame, false)
          menu_cump.frame:Remove()

        end

        menu_cump.IconSkin = vgui.Create( "DModelPanel", menu_cump.Player )
        menu_cump.IconSkin:SetSize(menu_cump.panel3:GetWide() / 12, menu_cump.panel3:GetWide() / 12)
        menu_cump.IconSkin:Center()
        menu_cump.IconSkin:CenterVertical(0.3)
        menu_cump.IconSkin:SetModel(v.player:GetModel())
        menu_cump.IconSkin:SetCamPos(Vector(40, 0, 90 ))
        function menu_cump.IconSkin:LayoutEntity( Entity ) return end
        function menu_cump.IconSkin.Entity:GetPlayerColor() return Vector ( 0, 0, 0 ) end
        local headpos = menu_cump.IconSkin.Entity:GetBonePosition( menu_cump.IconSkin.Entity:LookupBone( "ValveBiped.Bip01_Head1" ) )
        menu_cump.IconSkin:SetLookAt( headpos )
        menu_cump.IconSkin:SetCamPos( headpos-Vector( -15, 0, 0 ) )

      end

   end)

end

function Fonction.LookPlayerInfo(ply, frame, bool)

  local menu_cump = {}

  frame.Think = function(self)
  end

  menu_cump.frame = vgui.Create("DFrame", Fonction.frame)
  menu_cump.frame:SetSize(Fonction.frame:GetWide(), Fonction.frame:GetTall() / 1.05)
  menu_cump.frame:SetPos(0,0)
  menu_cump.frame:SetTitle("")
  menu_cump.frame:ShowCloseButton(false)
  menu_cump.frame:SetVisible(true)
  menu_cump.frame:SetDraggable(false)
  menu_cump.frame:MakePopup()

  menu_cump.frame.Paint = function(self,w,h)

    surface.SetDrawColor(255,255,255)
    surface.SetMaterial(Mate[24])
    surface.DrawTexturedRect(0, 0, w, h)

    draw.RoundedBox(0, 0, h/10, w, h/1.1, Color(25, 145, 236, 255))
    draw.RoundedBox(0, 0, h/1.3, w, h/4, Color(250, 250, 250, 255))

    draw.SimpleTextOutlined("Loading ...","FontPolice5", w / 90, h / 60, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
    draw.SimpleTextOutlined("https://policenational.org/" .. ply:Nick(),"FontPolice5", w / 10, h / 16, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

    draw.SimpleTextOutlined("Loading Data ...","FontPolice1", w / 2, h / 5, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

  end

  menu_cump.HTML = vgui.Create( "HTML", menu_cump.frame )
  menu_cump.HTML:SetSize(menu_cump.frame:GetWide() / 4, menu_cump.frame:GetWide() / 5)
  menu_cump.HTML:CenterHorizontal(0.5)
  menu_cump.HTML:CenterVertical(0.6)
  menu_cump.HTML:OpenURL("https://digitalsynopsis.com/wp-content/uploads/2016/06/loading-animations-preloader-gifs-ui-ux-effects-24.gif")

  timer.Simple(2.7, function()

    menu_cump.HTML:Remove()

    menu_cump.frame.Paint = function(self,w,h)

      surface.SetDrawColor(255,255,255)
      surface.SetMaterial(Mate[24])
      surface.DrawTexturedRect(0, 0, w, h)

      draw.RoundedBox(0, 0, h/10, w, h/1.1, Color(25, 145, 236, 255))
      draw.RoundedBox(0, 0, h/1.3, w, h/4, Color(250, 250, 250, 255))

      draw.SimpleTextOutlined(ply:Nick(),"FontPolice5", w / 90, h / 60, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
      draw.SimpleTextOutlined("https://policenational.org/" .. ply:Nick(),"FontPolice5", w / 10, h / 16, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("infomations"),"FontPolice2", w / 90, h / 5, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("police") .." DATA" ,"FontPolice1", w / 2, h / 5, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))
      draw.SimpleTextOutlined( " - " .. PoliceSysteme:GetPhrase("name") .. " : ".. ply:Nick(),"FontPolice2", w / 20, h / 3.5, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

      if bool then

        draw.SimpleTextOutlined( " - " .. PoliceSysteme:GetPhrase("rank") .. " : " .. ply:PoliceGetTablePlayer().name,"FontPolice2", w / 20, h / 2.65, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

      else

        draw.SimpleTextOutlined( " - " .. PoliceSysteme:GetPhrase("job") .. " : " .. ply:getDarkRPVar("job"),"FontPolice2", w / 20, h / 2.65, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

      end

      local str2

      if ply:getDarkRPVar("HasGunlicense") then

        str2 = PoliceSysteme:GetPhrase("yes")

      else

        str2 = PoliceSysteme:GetPhrase("no")

      end
      draw.SimpleTextOutlined(" - " .. PoliceSysteme:GetPhrase("lisc") .. " : " .. str2,"FontPolice2", w / 20, h / 3, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0,0,0))


    end

    menu_cump.frame.Think = function(self)
       self:MoveToFront()
    end

    menu_cump.close = vgui.Create("DButton", menu_cump.frame)
    menu_cump.close:SetSize(Fonction.frame:GetWide() / 33.1, Fonction.frame:GetTall() / 30)
    menu_cump.close:SetPos(Fonction.frame:GetWide() - menu_cump.close:GetWide(),0)
    menu_cump.close:SetText("")
    menu_cump.close.Paint = function(self,w,h)

      if self:IsHovered() then

        surface.SetDrawColor(255,255,255)
        surface.SetMaterial(Mate[19])
        surface.DrawTexturedRect(0, 0, w, h)

      end

    end
    menu_cump.close.DoClick = function()

      menu_cump.frame:Remove()

      if IsValid(frame) then
        frame.Think = function(self)
          self:MoveToFront()
        end
      end

    end

    menu_cump.icon = vgui.Create("DModelPanel", menu_cump.frame)
    menu_cump.icon:SetSize(menu_cump.frame:GetWide() / 1.2, menu_cump.frame:GetWide() / 2)
    menu_cump.icon:SetPos(menu_cump.frame:GetWide() / 14, menu_cump.frame:GetWide() / menu_cump.frame:GetWide() / 1)
    menu_cump.icon:SetModel(ply:GetModel())
    function menu_cump.icon:LayoutEntity(Entity) return end
    function menu_cump.icon.Entity:GetPlayerColor() return Vector (0, 0, 0) end

    local headpos = menu_cump.icon.Entity:GetBonePosition(menu_cump.icon.Entity:LookupBone("ValveBiped.Bip01_Head1"))
    menu_cump.icon:SetLookAt(headpos + Vector(0,-3,-15))

    menu_cump.icon:SetCamPos(headpos-Vector(-170, 0, 10))

    if bool and LocalPlayer():PoliceGetTablePlayer().canpromote then

      local Menu_Cump = {}

      Menu_Cump.panel3 = vgui.Create("DPanel", menu_cump.frame)
      Menu_Cump.panel3:SetSize(menu_cump.frame:GetWide() / 3, menu_cump.frame:GetTall() / 1.4)
      Menu_Cump.panel3:CenterVertical(0.6)
      Menu_Cump.panel3:CenterHorizontal(0.8)
      Menu_Cump.panel3.Paint = function(self, w, h)
        draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("promote"),"FontPolice2", w / 2, h / 20, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))
      end

      Menu_Cump.scroll = vgui.Create("DScrollPanel", Menu_Cump.panel3)
      Menu_Cump.scroll:Dock(FILL)


      Menu_Cump.sbar = Menu_Cump.scroll:GetVBar()
      function Menu_Cump.sbar:Paint()end
      function Menu_Cump.sbar.btnUp:Paint() end
      function Menu_Cump.sbar.btnDown:Paint() end
      function Menu_Cump.sbar.btnGrip:Paint() end

      Menu_Cump.layout = vgui.Create("DIconLayout", Menu_Cump.scroll)
      Menu_Cump.layout:Dock(FILL)
      Menu_Cump.layout:SetSpaceY(10)
      Menu_Cump.layout:SetSpaceX(5)

      Menu_Cump.Nil = vgui.Create("DLabel", Menu_Cump.layout)
      Menu_Cump.Nil:SetSize(Menu_Cump.panel3:GetWide(), Menu_Cump.panel3:GetWide() / 12)
      Menu_Cump.Nil:SetText("")
      Menu_Cump.Nil.Paint = function(self,w,h)
      end

      for k,v in pairs(PoliceSysteme.Config.Rank) do

        if k >= ply:GetNWInt("Rank::PlayerIDInTbl") and not ply:PoliceGetTablePlayer().canpromoteAll then continue end

        Menu_Cump.Player = vgui.Create("DButton", Menu_Cump.layout)
        Menu_Cump.Player:SetSize(Menu_Cump.panel3:GetWide(), Menu_Cump.panel3:GetWide() / 12)
        Menu_Cump.Player:SetText("")
        Menu_Cump.Player.Paint = function(self,w,h)

          if self:IsHovered() then

            draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

          else

            draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 50))

          end

          draw.SimpleTextOutlined(v.name,"FontPolice3", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

        end

        Menu_Cump.Player.DoClick = function(self)

          menu_cump.HTML = vgui.Create( "HTML", menu_cump.frame )
          menu_cump.HTML:SetSize(menu_cump.frame:GetWide() / 4, menu_cump.frame:GetWide() / 5)
          menu_cump.HTML:CenterHorizontal(0.825)
          menu_cump.HTML:CenterVertical(0.97)
          menu_cump.HTML:OpenURL("http://eyeocr.sourceforge.net/filestore/filestore.php?cmd=serve&file=blob_1005392&contentType=image/gif")

          timer.Simple(2,function()
              menu_cump.HTML:Remove()
          end)

          net.Start("Computer::UpGrade")
          net.WriteFloat(k)
          net.WriteEntity(ply)
          net.SendToServer()

        end

     end

     else

       if not ply:isWanted() then

         menu_cump.Valide = vgui.Create("DButton", menu_cump.frame)
         menu_cump.Valide:SetSize(menu_cump.frame:GetWide() / 5/2, menu_cump.frame:GetWide() / 20/2)
         menu_cump.Valide:SetPos(menu_cump.frame:GetWide() / 2.235, menu_cump.frame:GetTall() / 1.16)
         menu_cump.Valide:SetText("")
         menu_cump.Valide.Paint = function(self,w,h)

           if self:IsHovered() then

             draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

           else

             draw.RoundedBox(3, 0, 0, w, h, Color(0, 120, 225, 255))

           end

           draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("wanted2"),"FontPolice2", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

         end
         menu_cump.Valide.DoClick = function(self)

           if menu_cump.DTextEntry:GetValue() != "" and menu_cump.DTextEntry:GetValue() != nil then

             menu_cump.frame:Remove()
             net.Start("Computer::WantedPersonn")
             net.WriteString(menu_cump.DTextEntry:GetValue())
             net.WriteEntity(ply)
             net.SendToServer()

             local frame = Fonction.OpenLitleMenu(Fonction.frame)
             Fonction.Wantedpersonn(frame)

           end

         end

         menu_cump.DTextEntry = vgui.Create("DTextEntry", menu_cump.frame)
         menu_cump.DTextEntry:SetSize(menu_cump.frame:GetWide() / 3.5/2, menu_cump.frame:GetWide() / 20/2)
         menu_cump.DTextEntry:SetPos(menu_cump.frame:GetWide() / 2.34, menu_cump.frame:GetTall() / 1.24)
         menu_cump.DTextEntry:SetText("")
         menu_cump.DTextEntry.Paint = function(self,w,h)

           draw.RoundedBox(3, 0, 0, w, h, Color(25, 145, 236, 255))

           if self:GetValue() == "" or self:GetValue() == nil then

             draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("reason"),"FontPolice1", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

           else

             draw.SimpleTextOutlined(self:GetValue(),"FontPolice1", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

           end

         end

       else

         menu_cump.Valide = vgui.Create("DButton", menu_cump.frame)
         menu_cump.Valide:SetSize(menu_cump.frame:GetWide() / 5/2, menu_cump.frame:GetWide() / 20/2)
         menu_cump.Valide:SetPos(menu_cump.frame:GetWide() / 2.235, menu_cump.frame:GetTall() / 1.22)
         menu_cump.Valide:SetText("")
         menu_cump.Valide.Paint = function(self,w,h)

           if self:IsHovered() then

             draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

           else

             draw.RoundedBox(3, 0, 0, w, h, Color(0, 120, 225, 255))

           end

           draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("unwanted"),"FontPolice2", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

         end
         menu_cump.Valide.DoClick = function(self)

           menu_cump.frame:Remove()
           net.Start("Computer::UnWantedPersonn")
           net.WriteEntity(ply)
           net.SendToServer()

           local frame = Fonction.OpenLitleMenu(Fonction.frame)
           Fonction.Wantedpersonn(frame)

         end

       end

     end

   end)

end

function Fonction.Rapport(data,frame)

    local menu_cump = {}

    menu_cump.frame = frame

    menu_cump.panel3 = vgui.Create("DPanel", menu_cump.frame)
    menu_cump.panel3:SetSize(menu_cump.frame:GetWide() / 1.3, menu_cump.frame:GetTall() / 1.43)
    menu_cump.panel3:Center()
    menu_cump.panel3:CenterVertical(0.45)
    menu_cump.panel3.Paint = function(self, w, h)
    end

    menu_cump.scroll = vgui.Create("DScrollPanel", menu_cump.panel3)
    menu_cump.scroll:Dock(FILL)


    menu_cump.sbar = menu_cump.scroll:GetVBar()
    function menu_cump.sbar:Paint()end
    function menu_cump.sbar.btnUp:Paint() end
    function menu_cump.sbar.btnDown:Paint() end
    function menu_cump.sbar.btnGrip:Paint() end

    menu_cump.layout = vgui.Create("DIconLayout", menu_cump.scroll)
    menu_cump.layout:Dock(FILL)
    menu_cump.layout:SetSpaceY(5)
    menu_cump.layout:SetSpaceX(5)

    for _,v in pairs(data) do

      menu_cump.Report = vgui.Create("DButton", menu_cump.layout)
      menu_cump.Report:SetSize(menu_cump.panel3:GetWide() / 9, menu_cump.panel3:GetWide() / 8)
      menu_cump.Report:SetText("")
      menu_cump.Report.Paint = function(self,w,h)

        if self:IsHovered() then

          draw.RoundedBox(3, 0, 0, w, h, Color(216, 234, 249, 219))

        end

        surface.SetDrawColor(255,255,255,255)
        surface.SetMaterial(Mate[21])
        surface.DrawTexturedRect(w/20, h/10, ScrW()/14.7, ScrH()/8.64)

        local str = string.Explode(".txt",v)

        draw.SimpleTextOutlined(str[1],"FontPolice5", w / 2, h / 1.2, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      end
      menu_cump.Report.DoDoubleClick = function()

          surface.PlaySound("UI/buttonclick.wav")
          net.Start("Computer::ReadFile")
          net.WriteString(v)
          net.SendToServer()

          timer.Simple(0.01,function()
            menu_cump.frame:Remove()
          end)

      end

      menu_cump.Report.DoRightClick = function()

        if not LocalPlayer():PoliceGetTablePlayer().canDeleteReport then return end

        local menu = DermaMenu()

        menu.Think = function(self)
           self:MoveToFront()
        end

        local Delete = menu:AddOption(PoliceSysteme:GetPhrase("delete"), function()

          net.Start("Computer::DeleteFile")
          net.WriteString(v)
          net.SendToServer()
          surface.PlaySound("UI/buttonclick.wav")
          Fonction.frame:Remove()

        end)

        Delete.Paint = function(self,w,h)

          if self:IsHovered() then

            draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 200))

          else

            draw.RoundedBox(0, 0, 0, w, h, Color(242, 242, 242, 200))

          end

        end

        menu:Open()

      end

    end

    menu_cump.WriteReport = vgui.Create("DButton", menu_cump.layout)
    menu_cump.WriteReport:SetSize(menu_cump.panel3:GetWide() / 9, menu_cump.panel3:GetWide() / 8)
    menu_cump.WriteReport:SetText("")
    menu_cump.WriteReport.Paint = function(self,w,h)

      if self:IsHovered() then

        draw.RoundedBox(3, 0, 0, w, h, Color(216, 234, 249, 219))

      end

      surface.SetDrawColor(255,255,255,255)
      surface.SetMaterial(Mate[21])
      surface.DrawTexturedRect(w/20, h/10, ScrW()/14.7, ScrH()/8.64)

      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("writereport"),"FontPolice5", w / 2, h / 1.2, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

    end

    menu_cump.WriteReport.DoClick = function(self)

      Fonction.WriteReport(frame)

    end

end

function Fonction.ReadRapport()

  local menu_cump = {}
  local str = net.ReadString()

  local menu_cump = {}

  menu_cump.frame = vgui.Create("DFrame", Fonction.frame)
  menu_cump.frame:SetSize(Fonction.frame:GetWide(), Fonction.frame:GetTall() / 1.05)
  menu_cump.frame:SetPos(0,0)
  menu_cump.frame:SetTitle("")
  menu_cump.frame:ShowCloseButton(false)
  menu_cump.frame:SetVisible(true)
  menu_cump.frame:SetDraggable(false)
  menu_cump.frame:MakePopup()
  menu_cump.frame.Paint = function(self,w,h)

    surface.SetDrawColor(255,255,255)
    surface.SetMaterial(Mate[22])
    surface.DrawTexturedRect(0, 0, w, h)

    draw.DrawText(" - " .. PoliceSysteme:GetPhrase("report"), "FontPolice5", w / 70, h / 205.6, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT)

  end

  menu_cump.frame.Think = function(self)
     self:MoveToFront()
  end

  menu_cump.close = vgui.Create("DButton", menu_cump.frame)
  menu_cump.close:SetSize(Fonction.frame:GetWide() / 33.1, Fonction.frame:GetTall() / 30)
  menu_cump.close:SetPos(Fonction.frame:GetWide() - menu_cump.close:GetWide(),0)
  menu_cump.close:SetText("")
  menu_cump.close.Paint = function(self,w,h)

    if self:IsHovered() then

      surface.SetDrawColor(255,255,255)
      surface.SetMaterial(Mate[19])
      surface.DrawTexturedRect(0, 0, w, h)

    else

      surface.SetDrawColor(255,255,255)
      surface.SetMaterial(Mate[20])
      surface.DrawTexturedRect(0, 0, w, h)

    end

  end
  menu_cump.close.DoClick = function()

    menu_cump.frame:Remove()

  end

  menu_cump.panel3 = vgui.Create("DPanel", menu_cump.frame)
  menu_cump.panel3:SetSize(menu_cump.frame:GetWide() / 1, menu_cump.frame:GetTall() / 1.08)
  menu_cump.panel3:Center()
  menu_cump.panel3:CenterVertical(0.52)
  menu_cump.panel3.Paint = function(self, w, h)

    draw.DrawText(str, "FontPolice3", w / 70, h / 50, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT)

  end

end

function Fonction.WriteReport(frame)

    local menu_cump = {}

    frame.Think = function(self)
    end

    menu_cump.frame = vgui.Create("DFrame", Fonction.frame)
    menu_cump.frame:SetSize(Fonction.frame:GetWide(), Fonction.frame:GetTall() / 1.05)
    menu_cump.frame:SetPos(0,0)
    menu_cump.frame:SetTitle("")
    menu_cump.frame:ShowCloseButton(false)
    menu_cump.frame:SetVisible(true)
    menu_cump.frame:SetDraggable(false)
    menu_cump.frame:MakePopup()
    menu_cump.frame.Paint = function(self,w,h)

      surface.SetDrawColor(255,255,255)
      surface.SetMaterial(Mate[22])
      surface.DrawTexturedRect(0, 0, w, h)

      draw.DrawText(" - " .. PoliceSysteme:GetPhrase("report"), "FontPolice5", w / 70, h / 205.6, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT)

    end

    menu_cump.frame.Think = function(self)
       self:MoveToFront()
    end

    menu_cump.close = vgui.Create("DButton", menu_cump.frame)
    menu_cump.close:SetSize(Fonction.frame:GetWide() / 33.1, Fonction.frame:GetTall() / 30)
    menu_cump.close:SetPos(Fonction.frame:GetWide() - menu_cump.close:GetWide(),0)
    menu_cump.close:SetText("")
    menu_cump.close.Paint = function(self,w,h)

      if self:IsHovered() then

        surface.SetDrawColor(255,255,255)
        surface.SetMaterial(Mate[19])
        surface.DrawTexturedRect(0, 0, w, h)

      else

        surface.SetDrawColor(255,255,255)
        surface.SetMaterial(Mate[20])
        surface.DrawTexturedRect(0, 0, w, h)

      end

    end
    menu_cump.close.DoClick = function()

      menu_cump.frame:Remove()

      frame.Think = function(self)
        self:MoveToFront()
      end

    end

    menu_cump.panel3 = vgui.Create("DPanel", menu_cump.frame)
    menu_cump.panel3:SetSize(menu_cump.frame:GetWide() / 1, menu_cump.frame:GetTall() / 1.08)
    menu_cump.panel3:Center()
    menu_cump.panel3:CenterVertical(0.52)
    menu_cump.panel3.Paint = function(self, w, h)

      draw.DrawText(menu_cump.TextFile:GetValue(), "FontPolice3", w / 70, h / 50, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT)

    end

    menu_cump.TextFile = vgui.Create("DTextEntry", menu_cump.panel3)
    menu_cump.TextFile:SetSize(menu_cump.frame:GetWide() / 1, menu_cump.frame:GetTall() / 1.08)
    menu_cump.TextFile:Center()
    menu_cump.TextFile:CenterVertical(0.52)
    menu_cump.TextFile:SetMultiline(true)
    menu_cump.TextFile.Paint = function(self, w, h)
    end

    menu_cump.TextTitle = vgui.Create("DTextEntry", menu_cump.frame)
    menu_cump.TextTitle:SetSize(ScrW() / 15.4, ScrH() / 34.6)
    menu_cump.TextTitle:SetPos(menu_cump.frame:GetWide() / 13,menu_cump.frame:GetTall() / 41.5)
    menu_cump.TextTitle.Paint = function(self, w, h)

      surface.SetDrawColor(230,230,230,255)
      surface.SetMaterial(Mate[23])
      surface.DrawTexturedRect(0, 0, w, h)


      if self:GetValue() == nil or self:GetValue() == "" then

        draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("title"),"FontPolice5", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

      else

        draw.SimpleTextOutlined(self:GetValue(),"FontPolice5", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0,0,0))

      end

    end

    menu_cump.WriteReport = vgui.Create("DButton", menu_cump.frame)
    menu_cump.WriteReport:SetSize(menu_cump.frame:GetWide() / 13, menu_cump.frame:GetTall() / 38)
    menu_cump.WriteReport:SetPos(0,menu_cump.frame:GetTall() / 37)
    menu_cump.WriteReport:SetText("")
    menu_cump.WriteReport.Paint = function(self,w,h)

      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("valid"),"FontPolice3", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

    end
    menu_cump.WriteReport.DoClick = function()

        surface.PlaySound("UI/buttonclick.wav")

        if (menu_cump.TextTitle:GetValue() == "" or menu_cump.TextTitle:GetValue() == nil) and (menu_cump.TextFile:GetValue() == "" or menu_cump.TextFile:GetValue() == nil) then

          chat.AddText(Color(255,0,0), "[NOTIFICATION] : ", Color(255,255,255), PoliceSysteme:GetPhrase("textenter"))

        else

          net.Start("Computer::WriteFile")
          net.WriteString(menu_cump.TextTitle:GetValue())
          net.WriteString(menu_cump.TextFile:GetValue())
          net.SendToServer()
          Fonction.frame:Remove()

        end

    end

end

net.Receive("Computer::ReadFileSend",Fonction.ReadRapport)

net.Receive("PoliceText::NotificationText",function()

  chat.AddText(Color(255,0,0), "[NOTIFICATION] : ", Color(255,255,255), net.ReadString())

end)
