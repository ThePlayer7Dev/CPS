

surface.CreateFont("FontPolice2Config", {
    font = "selawksl",
    size = ScrW() / 50,
    weight = ScrW() / 1.95,
})

surface.CreateFont("FontPolice2ConfigSurline", {
    font = "selawksl",
    size = ScrW() / 50,
    weight = ScrW() / 3.3,
    underline = false,
})

surface.CreateFont("FontPolice3Config", {
    font = "selawksl",
    size = ScrW() / 80,
    weight = ScrW() / 1.366,
})

surface.CreateFont("FontPolice5Config", {
    font = "selawksl",
    size = ScrW() / 100,
    weight = ScrW() / 3,
})

surface.CreateFont("FontPolice6Config", {
    font = "selawksl",
    size = ScrW() / 70,
    weight = ScrW() / 10,
})

surface.CreateFont("FontPolice7Config", {
    font = "selawksl",
    size = ScrW() / 70,
    weight = ScrW() / 10,
})


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
  [16] = Material("materials/police_systeme/parametre.png"),
  [17] = Material("materials/police_systeme/check.png"),
  [18] = Material("materials/police_systeme/new.png"),
  [19] = Material("materials/police_systeme/reset.png"),
}

local Ranktable = {}

function Fonction.OpenMenuConfig(frame)

  if not LocalPlayer():IsSuperAdmin() then return end

  local menu_cump = {}

  str = ""

  if #Ranktable == 0 then
    Ranktable = PoliceSysteme.Config.Rank
  end


  menu_cump.frame = frame

  menu_cump.frame.Paint = function(self,w,h)

    surface.SetDrawColor(255,255,255)
    surface.SetMaterial(Mate[16])
    surface.DrawTexturedRect(0, 0, w, h)
    draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("question"),"FontPolice6Config", w / 1.2, h / 7, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
    draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("setting"),"FontPolice5Config", w / 30, h * 1.03 - h, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

  end

  menu_cump.panel3 = vgui.Create("DPanel", menu_cump.frame)
  menu_cump.panel3:SetSize(menu_cump.frame:GetWide() / 1.3, menu_cump.frame:GetTall() / 1.43)
  menu_cump.panel3:CenterHorizontal(0.6)
  menu_cump.panel3:CenterVertical(0.5)
  menu_cump.panel3.Paint = function(self, w, h)
  end

  menu_cump.scroll = vgui.Create("DScrollPanel", menu_cump.panel3)
  menu_cump.scroll:Dock(FILL)


  menu_cump.sbar = menu_cump.scroll:GetVBar()
  function menu_cump.sbar:Paint() end
  function menu_cump.sbar.btnUp:Paint() end
  function menu_cump.sbar.btnDown:Paint() end
  function menu_cump.sbar.btnGrip:Paint(w,h)
    draw.RoundedBox(3, 0, 0, w/3, h, Color(120, 120, 120, 255))
  end

  menu_cump.layout = vgui.Create("DIconLayout", menu_cump.scroll)
  menu_cump.layout:Dock(FILL)
  menu_cump.layout:SetSpaceY(5)
  menu_cump.layout:SetSpaceX(5)

  menu_cump.panel4 = vgui.Create("DPanel", menu_cump.frame)
  menu_cump.panel4:SetSize(menu_cump.frame:GetWide() / 4.82, menu_cump.frame:GetTall() / 1.43)
  menu_cump.panel4:SetPos(0,0)
  menu_cump.panel4:CenterVertical(0.5)
  menu_cump.panel4.Paint = function(self, w, h)
  end

  menu_cump.scroll2 = vgui.Create("DScrollPanel", menu_cump.panel4)
  menu_cump.scroll2:Dock(FILL)


  menu_cump.sbar2 = menu_cump.scroll2:GetVBar()
  function menu_cump.sbar2:Paint() end
  function menu_cump.sbar2.btnUp:Paint() end
  function menu_cump.sbar2.btnDown:Paint() end
  function menu_cump.sbar2.btnGrip:Paint(w,h)
    draw.RoundedBox(3, 0, 0, w/3, h, Color(120, 120, 120, 255))
  end

  menu_cump.layout2 = vgui.Create("DIconLayout", menu_cump.scroll2)
  menu_cump.layout2:Dock(FILL)
  menu_cump.layout2:SetSpaceY(ScrW()/192)
  menu_cump.layout2:SetSpaceX(ScrW()/192)


  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"Texte","","Global")
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"Slider","TimeWanted",PoliceSysteme:GetPhrase("timewanted"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"Slider","TimeWaitForCanWeap",PoliceSysteme:GetPhrase("timearmur"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"Slider","TimeArrest",PoliceSysteme:GetPhrase("timearmur"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"check","CanUpWithTime",PoliceSysteme:GetPhrase("timeup"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"check","ActivePing",PoliceSysteme:GetPhrase("activeping"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"check","CanGetDownPeople",PoliceSysteme:GetPhrase("activeputdown"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"TexteEntry","Language",PoliceSysteme:GetPhrase("fr/en"))

  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"Texte","","2D3D Text")
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"Choice","TeamPolice",PoliceSysteme:GetPhrase("whoispolice"), RPExtraTeams)
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"check","RankAndNick",PoliceSysteme:GetPhrase("textuphead"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"color","ColorTextNick",PoliceSysteme:GetPhrase("colortextname"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"color","ColorStrokeNick",PoliceSysteme:GetPhrase("colorstrokename"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"color","ColorTextRank",PoliceSysteme:GetPhrase("colortextrank"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"color","ColorStrokeRank",PoliceSysteme:GetPhrase("colorstrokerank"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"Slider","DistanceMaxSee",PoliceSysteme:GetPhrase("maxdist"))

  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"Texte","","EmergencyCall")
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"check","ActiveCommandeHelp",PoliceSysteme:GetPhrase("commandehelp"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"check","ColorChange",PoliceSysteme:GetPhrase("clign"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"color","Color1",PoliceSysteme:GetPhrase("color1"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"color","Color2",PoliceSysteme:GetPhrase("color2"))
  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"check","DrawIconDanger",PoliceSysteme:GetPhrase("danger"))

  Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"Texte","",PoliceSysteme:GetPhrase("rank") .. "")

  for k,v in pairs(Ranktable) do

    Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"Rank",k)

  end

  menu_cump.Help = vgui.Create("DButton", menu_cump.frame)
  menu_cump.Help:SetSize(menu_cump.frame:GetWide() / 5, menu_cump.frame:GetTall() / 30)
  menu_cump.Help:SetPos(menu_cump.frame:GetWide() / 1.363, menu_cump.frame:GetTall() / 6)
  menu_cump.Help:SetText("")
  menu_cump.Help.Paint = function(self,w,h)

    if self:IsHovered() then

      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("questionhelp"),"FontPolice6Config", w / 2, h / 4, Color(0,120,215), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

    else

      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("questionhelp"),"FontPolice6Config", w / 2, h / 4, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

    end

  end

  menu_cump.Help.DoClick = function()

    gui.OpenURL("https://mtxserv.com/forums")
    menu_cump.frame:Remove()

  end

  menu_cump.Valide = vgui.Create("DButton", menu_cump.layout2)
  menu_cump.Valide:SetSize(menu_cump.panel4:GetWide(), menu_cump.frame:GetTall() / 17)
  menu_cump.Valide:SetText("")
  menu_cump.Valide.Paint = function(self,w,h)

    if self:IsHovered() then

      draw.RoundedBox(1, 0, 0, w, h, Color(180, 180, 180, 255))
      draw.RoundedBox(1, 0, h-h/1.35, w/100, h/2, Color(0, 120, 215, 255))

    end

    surface.SetDrawColor(255,255,255)
    surface.SetMaterial(Mate[17])
    surface.DrawTexturedRect(w/20, h-h/1.4, w/15, w/15)

    draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("validforall"),"FontPolice7Config", w / 7, h / 2, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

  end

  menu_cump.Valide.DoClick = function()

    net.Start("PoliceSysteme::ConfigStart")
    net.WriteTable(PoliceSysteme.Config)
    net.WriteTable(Ranktable)
    net.SendToServer()

    surface.PlaySound("UI/buttonclick.wav")
    menu_cump.frame:Remove()

  end


  menu_cump.Reset = vgui.Create("DButton", menu_cump.layout2)
  menu_cump.Reset:SetSize(menu_cump.panel4:GetWide(), menu_cump.frame:GetTall() / 17)
  menu_cump.Reset:SetText("")
  menu_cump.Reset.Paint = function(self,w,h)

    if self:IsHovered() then

      draw.RoundedBox(1, 0, 0, w, h, Color(180, 180, 180, 255))
      draw.RoundedBox(1, 0, h-h/1.35, w/100, h/2, Color(0, 120, 215, 255))

    end

    surface.SetDrawColor(255,255,255)
    surface.SetMaterial(Mate[19])
    surface.DrawTexturedRect(w/20, h-h/1.4, w/15, w/15)

    draw.SimpleTextOutlined("Reset","FontPolice7Config", w / 7, h / 2, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

  end

  menu_cump.Reset.DoClick = function()

    net.Start("PoliceSysteme::PlayerResetConfig")
    net.SendToServer()

    surface.PlaySound("UI/buttonclick.wav")
    menu_cump.frame:Remove()

  end

  menu_cump.NewRank = vgui.Create("DButton", menu_cump.layout2)
  menu_cump.NewRank:SetSize(menu_cump.panel4:GetWide(), menu_cump.frame:GetTall() / 17)
  menu_cump.NewRank:SetText("")
  menu_cump.NewRank.Paint = function(self,w,h)

    if self:IsHovered() then

      draw.RoundedBox(1, 0, 0, w, h, Color(180, 180, 180, 255))
      draw.RoundedBox(1, 0, h-h/1.35, w/100, h/2, Color(0, 120, 215, 255))

    end

    surface.SetDrawColor(255,255,255)
    surface.SetMaterial(Mate[18])
    surface.DrawTexturedRect(w/20, h-h/1.4, w/15, w/15)


    draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("newrank"),"FontPolice7Config", w / 7, h / 2, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

  end

  menu_cump.NewRank.DoClick = function(self)

    surface.PlaySound("UI/buttonclick.wav")

    Ranktable[#Ranktable+1] = {

      name = "NEWWW",
      time = 0,
      weapons = {},
      canpromote = false,
      canpromoteAll = false,
      canDeleteReport = false,

    }

    Fonction.AddChoice(menu_cump.layout,menu_cump.panel3,"Rank",#Ranktable)

  end

end

local ColorPanel = Color(255,255,255)
local ColorButton = Color(25,145,236,255)


function Fonction.AddChoice(layout,panel,types,id,txt,tabl)

  local menu_cump = {}

  if types == "Texte" then

    menu_cump.PanelPrincipi = vgui.Create("DPanel", layout)
    menu_cump.PanelPrincipi:SetSize(panel:GetWide(), panel:GetTall() / 10)
    menu_cump.PanelPrincipi:Center()
    menu_cump.PanelPrincipi.Paint = function(self, w, h)
      surface.SetDrawColor(ColorPanel)
      surface.DrawRect(0, 0, w, h)
      draw.RoundedBox(3, 0, h/30, w, h/30, Color(230, 230, 230, 255))
      draw.RoundedBox(3, 0, h-h/20, w, h/30, Color(230, 230, 230, 255))
      draw.SimpleTextOutlined(txt,"FontPolice2ConfigSurline", w / 50, h / 2, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
    end

  elseif types == "TexteEntry" then

    menu_cump.PanelPrincipi = vgui.Create("DPanel", layout)
    menu_cump.PanelPrincipi:SetSize(panel:GetWide(), panel:GetTall() / 7)
    menu_cump.PanelPrincipi:Center()
    menu_cump.PanelPrincipi.Paint = function(self, w, h)
      surface.SetDrawColor(ColorPanel)
      surface.DrawRect(0, 0, w, h)
      draw.SimpleTextOutlined(txt,"FontPolice6Config", w / 50, h / 10, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
    end

    menu_cump.TextEntry = vgui.Create("DTextEntry", menu_cump.PanelPrincipi)
    menu_cump.TextEntry:SetSize(menu_cump.PanelPrincipi:GetWide() / 5, menu_cump.PanelPrincipi:GetTall() / 3)
    menu_cump.TextEntry:Center()
    menu_cump.TextEntry:CenterHorizontal(0.12)
    menu_cump.TextEntry:SetText("")
    menu_cump.TextEntry:SetValue(PoliceSysteme.Config[id])
    menu_cump.TextEntry.Paint = function(self,w,h)

      draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 255))
      draw.RoundedBox(0, w/100, h/15, w/1.013, h/1.1, Color(255, 255, 255, 255))

      if self:GetValue() != "" then

        draw.SimpleTextOutlined(self:GetValue(),"FontPolice6Config", w / 2, h / 2, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      end

    end


    menu_cump.Valide = vgui.Create("DButton", menu_cump.PanelPrincipi)
    menu_cump.Valide:SetSize(menu_cump.PanelPrincipi:GetWide() / 10, menu_cump.PanelPrincipi:GetTall() / 3)
    menu_cump.Valide:CenterHorizontal(0.3)
    menu_cump.Valide:CenterVertical(0.5)
    menu_cump.Valide:SetText("")
    menu_cump.Valide.Paint = function(self,w,h)

      if self:IsHovered() then

        draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("valid"),"FontPolice6Config", w / 2, h / 2, Color(145,145,145), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      else

        draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("valid"),"FontPolice6Config", w / 2, h / 2, Color(0,120,215), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      end

    end

    menu_cump.Valide.DoClick = function()

      PoliceSysteme.Config[id] = menu_cump.TextEntry:GetValue()
      surface.PlaySound("UI/buttonclick.wav")

    end


  elseif types == "Rank" then

    menu_cump.PanelPrincipi = vgui.Create("DPanel", layout)
    menu_cump.PanelPrincipi:SetSize(panel:GetWide(), panel:GetTall() / 2.3)
    menu_cump.PanelPrincipi:Center()
    menu_cump.PanelPrincipi.Paint = function(self, w, h)
      surface.SetDrawColor(ColorPanel)
      surface.DrawRect(0, 0, w, h)
      draw.RoundedBox(3, 0, h-h/150, w, h/150, Color(230, 230, 230, 255))
      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("canpromote"),"FontPolice7Config", w / 1.12, h / 1.25, Color(0,0,0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("canpromoteall"),"FontPolice7Config", w / 1.12, h / 2.02, Color(0,0,0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("candeletereport"),"FontPolice7Config", w / 1.12, h / 5, Color(0,0,0), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
      draw.SimpleTextOutlined("- " .. PoliceSysteme:GetPhrase("name"),"FontPolice7Config", w / 3.8, h / 5, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
      draw.SimpleTextOutlined("- " .. PoliceSysteme:GetPhrase("time"),"FontPolice7Config", w / 3.8, h / 2.3, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
      draw.SimpleTextOutlined("- " .. PoliceSysteme:GetPhrase("weap"),"FontPolice7Config", w / 1.8, h / 1.5, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
    end

    menu_cump.TextEntry = vgui.Create("DTextEntry", menu_cump.PanelPrincipi)
    menu_cump.TextEntry:SetSize(menu_cump.PanelPrincipi:GetWide() / 5, menu_cump.PanelPrincipi:GetTall() / 5)
    menu_cump.TextEntry:SetPos(menu_cump.PanelPrincipi:GetWide() / 20, menu_cump.PanelPrincipi:GetTall() / 10)
    menu_cump.TextEntry:SetText("")
    menu_cump.TextEntry:SetValue(Ranktable[id].name)
    menu_cump.TextEntry.Paint = function(self,w,h)

      draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 255))
      draw.RoundedBox(0, w/100, h/30, w/1.013, h/1.06, Color(255, 255, 255, 255))

      if self:GetValue() != "" then

        draw.SimpleTextOutlined(self:GetValue(),"FontPolice6Config", w / 2, h / 2, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      end

    end

    menu_cump.TextEntry2 = vgui.Create("DTextEntry", menu_cump.PanelPrincipi)
    menu_cump.TextEntry2:SetSize(menu_cump.PanelPrincipi:GetWide() / 5, menu_cump.PanelPrincipi:GetTall() / 5)
    menu_cump.TextEntry2:SetPos(menu_cump.PanelPrincipi:GetWide() / 20, menu_cump.PanelPrincipi:GetTall() / 3)
    menu_cump.TextEntry2:SetText("")
    menu_cump.TextEntry2:SetNumeric(true)
    menu_cump.TextEntry2:SetValue(Ranktable[id].time)
    menu_cump.TextEntry2.Paint = function(self,w,h)

      draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 255))
      draw.RoundedBox(0, w/100, h/30, w/1.013, h/1.06, Color(255, 255, 255, 255))

      if self:GetValue() != "" then

        draw.SimpleTextOutlined(self:GetValue(),"FontPolice6Config", w / 2, h / 2, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      end

    end

    menu_cump.TextEntry3 = vgui.Create("DTextEntry", menu_cump.PanelPrincipi)
    menu_cump.TextEntry3:SetSize(menu_cump.PanelPrincipi:GetWide() / 2, menu_cump.PanelPrincipi:GetTall() / 5)
    menu_cump.TextEntry3:SetPos(menu_cump.PanelPrincipi:GetWide() / 20, menu_cump.PanelPrincipi:GetTall() / 1.75)
    menu_cump.TextEntry3:SetText("")
    menu_cump.TextEntry3:SetNumeric(false)

    local strin = ""
    for k,v in pairs(Ranktable[id].weapons) do

      strin = strin .. k .. ","

    end

    menu_cump.TextEntry3:SetValue(strin)
    menu_cump.TextEntry3.Paint = function(self,w,h)

      draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 255))
      draw.RoundedBox(0, w/300, h/30, w/1.005, h/1.06, Color(255, 255, 255, 255))

      if self:GetValue() != "" then

        draw.SimpleTextOutlined(self:GetValue(),"FontPolice6Config", w / 2, h / 2, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      end

    end

    menu_cump.DermaCheckbox1 = vgui.Create("DCheckBox", menu_cump.PanelPrincipi)
    menu_cump.DermaCheckbox1:SetSize(panel:GetWide() / 17,panel:GetWide() / 45)
    menu_cump.DermaCheckbox1:CenterVertical(0.8)
    menu_cump.DermaCheckbox1:CenterHorizontal(0.93)
    menu_cump.DermaCheckbox1:SetValue(Ranktable[id].canpromote)
    if Ranktable[id].canpromote then
      menu_cump.DermaCheckbox1.Position = menu_cump.DermaCheckbox1:GetWide() / 1.6
    else
      menu_cump.DermaCheckbox1.Position = menu_cump.DermaCheckbox1:GetWide() / 10
    end
    menu_cump.DermaCheckbox1.Paint = function(self,w,h)

      if self:GetChecked() then

        self.Position = Lerp(FrameTime() * 10,self.Position,w/1.6)

        if self:IsHovered() then
          draw.RoundedBox(ScrW()/112.9, 0, 0, w, h, Color(77,161,227))
        else
          draw.RoundedBox(ScrW()/112.9, 0, 0, w, h, Color(0,120,225))
        end
          draw.RoundedBox(ScrW()/64, self.Position, h/6.5, h/1.5, h/1.5, Color(255,255,255))

      else

        self.Position = Lerp(FrameTime() * 10,self.Position,w/10)

          draw.RoundedBox(ScrW()/112.9, 0, 0, w, h, Color(0,0,0))
          draw.RoundedBox(ScrW()/112.9, w/35, h/25, w/1.05, h/1.1, Color(255,255,255))

          draw.RoundedBox(ScrW()/64, self.Position, h/6.5, h/1.5, h/1.5, Color(0,0,0))

      end

    end

    menu_cump.DermaCheckbox2 = vgui.Create("DCheckBox", menu_cump.PanelPrincipi)
    menu_cump.DermaCheckbox2:SetSize(panel:GetWide() / 17,panel:GetWide() / 45)
    menu_cump.DermaCheckbox2:CenterVertical(0.50)
    menu_cump.DermaCheckbox2:CenterHorizontal(0.93)
    menu_cump.DermaCheckbox2:SetValue(Ranktable[id].canpromoteAll)
    if Ranktable[id].canpromoteAll then
      menu_cump.DermaCheckbox2.Position = menu_cump.DermaCheckbox2:GetWide() / 1.6
    else
      menu_cump.DermaCheckbox2.Position = menu_cump.DermaCheckbox2:GetWide() / 10
    end
    menu_cump.DermaCheckbox2.Paint = function(self,w,h)

      if self:GetChecked() then

        self.Position = Lerp(FrameTime() * 10,self.Position,w/1.6)

        if self:IsHovered() then
          draw.RoundedBox(ScrW()/112.9, 0, 0, w, h, Color(77,161,227))
        else
          draw.RoundedBox(ScrW()/112.9, 0, 0, w, h, Color(0,120,225))
        end
          draw.RoundedBox(ScrW()/64, self.Position, h/6.5, h/1.5, h/1.5, Color(255,255,255))

      else

        self.Position = Lerp(FrameTime() * 10,self.Position,w/10)

          draw.RoundedBox(ScrW()/112.9, 0, 0, w, h, Color(0,0,0))
          draw.RoundedBox(ScrW()/112.9, w/35, h/25, w/1.05, h/1.1, Color(255,255,255))

          draw.RoundedBox(ScrW()/64, self.Position, h/6.5, h/1.5, h/1.5, Color(0,0,0))

      end

    end

    menu_cump.DermaCheckbox3 = vgui.Create("DCheckBox", menu_cump.PanelPrincipi)
    menu_cump.DermaCheckbox3:SetSize(panel:GetWide() / 17,panel:GetWide() / 45)
    menu_cump.DermaCheckbox3:CenterVertical(0.2)
    menu_cump.DermaCheckbox3:CenterHorizontal(0.93)
    menu_cump.DermaCheckbox3:SetValue(Ranktable[id].canDeleteReport)
    if Ranktable[id].canDeleteReport then
      menu_cump.DermaCheckbox3.Position = menu_cump.DermaCheckbox3:GetWide() / 1.6
    else
      menu_cump.DermaCheckbox3.Position = menu_cump.DermaCheckbox3:GetWide() / 10
    end
    menu_cump.DermaCheckbox3.Paint = function(self,w,h)

      if self:GetChecked() then

        self.Position = Lerp(FrameTime() * 10,self.Position,w/1.6)

        if self:IsHovered() then
          draw.RoundedBox(ScrW()/112.9, 0, 0, w, h, Color(77,161,227))
        else
          draw.RoundedBox(ScrW()/112.9, 0, 0, w, h, Color(0,120,225))
        end
          draw.RoundedBox(ScrW()/64, self.Position, h/6.5, h/1.5, h/1.5, Color(255,255,255))

      else

        self.Position = Lerp(FrameTime() * 10,self.Position,w/10)

          draw.RoundedBox(ScrW()/112.9, 0, 0, w, h, Color(0,0,0))
          draw.RoundedBox(ScrW()/112.9, w/35, h/25, w/1.05, h/1.1, Color(255,255,255))

          draw.RoundedBox(ScrW()/64, self.Position, h/6.5, h/1.5, h/1.5, Color(0,0,0))

      end

    end

    menu_cump.Valide = vgui.Create("DButton", menu_cump.PanelPrincipi)
    menu_cump.Valide:SetSize(menu_cump.PanelPrincipi:GetWide() / 10, menu_cump.PanelPrincipi:GetTall() / 8)
    menu_cump.Valide:CenterHorizontal(0.5)
    menu_cump.Valide:CenterVertical(0.9)
    menu_cump.Valide:SetText("")
    menu_cump.Valide.Paint = function(self,w,h)

      if self:IsHovered() then

        draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("valid"),"FontPolice6Config", w / 2, h / 2, Color(145,145,145), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      else

        draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("valid"),"FontPolice6Config", w / 2, h / 2, Color(0,120,215), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      end

    end

    menu_cump.Valide.DoClick = function()

      local weapontbl = {}

      for _,v in pairs(string.Explode(",", menu_cump.TextEntry3:GetValue())) do

        if v == "" then continue end
        weapontbl[v] = true

      end

      Ranktable[id] = {

        name = menu_cump.TextEntry:GetValue(),
        time = menu_cump.TextEntry2:GetValue(),
        canpromote = menu_cump.DermaCheckbox1:GetChecked(),
        canpromoteAll = menu_cump.DermaCheckbox2:GetChecked(),
        canDeleteReport = menu_cump.DermaCheckbox3:GetChecked(),
        weapons = weapontbl,

      }

      surface.PlaySound("UI/buttonclick.wav")

      str = PoliceSysteme:GetPhrase("succes")

      if IsValid(Fonction.frame2) then
        Fonction.frame2.BtnColor = 255
      end

    end

    if #Ranktable > 1 then

      menu_cump.Delete = vgui.Create("DButton", menu_cump.PanelPrincipi)
      menu_cump.Delete:SetSize(menu_cump.PanelPrincipi:GetWide() / 10, menu_cump.PanelPrincipi:GetTall() / 8)
      menu_cump.Delete:CenterHorizontal(0.3)
      menu_cump.Delete:CenterVertical(0.9)
      menu_cump.Delete:SetText("")
      menu_cump.Delete.Paint = function(self,w,h)

        if self:IsHovered() then

          draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

        else

          draw.RoundedBox(3, 0, 0, w, h, Color(0, 120, 225, 255))

        end

        draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("delete"),"FontPolice2Config", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      end

      menu_cump.Delete.DoClick = function(self)

        local Organ = {}

        Ranktable[id] = nil

        for _,v in pairs(Ranktable) do

          table.insert(Organ,v)

        end

        Ranktable = Organ

        surface.PlaySound("UI/buttonclick.wav")

        self:GetParent():Remove()

      end

    end

  elseif types == "Slider" then

    menu_cump.PanelPrincipi = vgui.Create("DPanel", layout)
    menu_cump.PanelPrincipi:SetSize(panel:GetWide(), panel:GetTall() / 7)
    menu_cump.PanelPrincipi:Center()
    menu_cump.PanelPrincipi.Paint = function(self, w, h)
      surface.SetDrawColor(ColorPanel)
      surface.DrawRect(0, 0, w, h)
      draw.SimpleTextOutlined(txt,"FontPolice6Config", w / 50, h / 10, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
    end

    menu_cump.Slider = vgui.Create("DNumSlider", menu_cump.PanelPrincipi)
    menu_cump.Slider:Center()
    menu_cump.Slider:SetSize(menu_cump.PanelPrincipi:GetWide() / 3, menu_cump.PanelPrincipi:GetTall() / 5)
    menu_cump.Slider:CenterHorizontal(0.05)
    menu_cump.Slider:SetText("")
    menu_cump.Slider:SetMin(0)
    menu_cump.Slider:SetMax(100000)
    menu_cump.Slider:SetDecimals(0)
    menu_cump.Slider.Idtable = id
    menu_cump.Slider:SetValue(PoliceSysteme.Config[id])
    menu_cump.Slider.OnValueChanged = function(self)

      PoliceSysteme.Config[id] = self:GetValue()

    end
--[[    menu_cump.Slider.Paint = function(self,w,h)

      surface.SetDrawColor(Color(0,0,0))
      surface.DrawRect(w-w/1.75, h/2, (w/2.13), h/4)

      surface.SetDrawColor(Color(0,120,215))
      surface.DrawRect(w-w/1.75, h/2, ((w/2.13) * (self:GetValue()/self:GetMax())), h/4)

      draw.RoundedBox(25, ((w/2.13) * (self:GetValue()/self:GetMax())) + w/2.35, h/2, w/100, h, Color(0,120,215))

    end
]]
  elseif types == "color" then

    menu_cump.PanelPrincipi = vgui.Create("DPanel", layout)
    menu_cump.PanelPrincipi:SetSize(panel:GetWide(), panel:GetTall() / 4)
    menu_cump.PanelPrincipi:Center()
    menu_cump.PanelPrincipi.Paint = function(self, w, h)
      surface.SetDrawColor(ColorPanel)
      surface.DrawRect(0, 0, w, h)
      draw.SimpleTextOutlined(txt,"FontPolice6Config", w / 50, h / 10, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
    end

    menu_cump.Valide = vgui.Create("DButton", menu_cump.PanelPrincipi)
    menu_cump.Valide:SetSize(menu_cump.PanelPrincipi:GetWide() / 10, menu_cump.PanelPrincipi:GetTall() / 4)
    menu_cump.Valide:CenterHorizontal(0.2)
    menu_cump.Valide:CenterVertical(0.46)
    menu_cump.Valide:SetText("")
    menu_cump.Valide.Paint = function(self,w,h)

      if self:IsHovered() then

        surface.SetDrawColor(Color(116,116,116))
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(Color(194,194,194))
        surface.DrawRect((h-h/1.1) - (h-h/1.1)/2, (h-h/1.1) - (h-h/1.1)/2, w-(h-h/1.1), h/1.1)

      else

        surface.SetDrawColor(Color(194,194,194))
        surface.DrawRect(0, 0, w, h)

      end
      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("colormor"),"FontPolice6Config", w / 2, h / 2, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

    end

    menu_cump.Valide.DoClick = function(self)

      self:Remove()

      menu_cump.panelConfig = vgui.Create("DPanel", menu_cump.PanelPrincipi)
      menu_cump.panelConfig:SetSize(menu_cump.PanelPrincipi:GetTall()*1.5, menu_cump.PanelPrincipi:GetTall())
      menu_cump.panelConfig:CenterHorizontal(0.5)
      menu_cump.panelConfig.Paint = function(self, w, h)
      end

      menu_cump.Mixer = vgui.Create("DColorMixer", menu_cump.panelConfig)
      menu_cump.Mixer:Dock(FILL)
      menu_cump.Mixer:SetPalette(true)
      menu_cump.Mixer:SetAlphaBar(true)
      menu_cump.Mixer:SetWangs(true)
      menu_cump.Mixer:SetColor(PoliceSysteme.Config[id])
      menu_cump.Mixer.OnValueChanged = function(self,color)
        menu_cump.DColorButton:SetColor(color)
        PoliceSysteme.Config[id] = color
      end


    end

    menu_cump.DColorButton = vgui.Create("DColorButton", menu_cump.PanelPrincipi)
    menu_cump.DColorButton:SetSize(menu_cump.PanelPrincipi:GetWide()/25, menu_cump.PanelPrincipi:GetWide()/25)
    menu_cump.DColorButton:SetPos(0,menu_cump.PanelPrincipi:GetTall() / 3.5)
    menu_cump.DColorButton:CenterHorizontal(0.12)
    menu_cump.DColorButton:SetColor(PoliceSysteme.Config[id])

  elseif types == "check" then

    menu_cump.PanelPrincipi = vgui.Create("DPanel", layout)
    menu_cump.PanelPrincipi:SetSize(panel:GetWide(), panel:GetTall() / 7)
    menu_cump.PanelPrincipi:Center()
    menu_cump.PanelPrincipi.Paint = function(self, w, h)
      surface.SetDrawColor(ColorPanel)
      surface.DrawRect(0, 0, w, h)
      draw.SimpleTextOutlined(txt,"FontPolice6Config", w / 50, h / 10, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))
    end

    menu_cump.DermaCheckbox = vgui.Create("DCheckBox", menu_cump.PanelPrincipi)
    menu_cump.DermaCheckbox:SetSize(panel:GetWide() / 17,panel:GetWide() / 45)
    menu_cump.DermaCheckbox:Center()
    menu_cump.DermaCheckbox:CenterHorizontal(0.05)
    menu_cump.DermaCheckbox:CenterVertical(0.5)
    menu_cump.DermaCheckbox:SetValue(PoliceSysteme.Config[id])
    if PoliceSysteme.Config[id] then
      menu_cump.DermaCheckbox.Position = menu_cump.DermaCheckbox:GetWide() / 1.6
    else
      menu_cump.DermaCheckbox.Position = menu_cump.DermaCheckbox:GetWide() / 10
    end
    menu_cump.DermaCheckbox.Paint = function(self,w,h)

      if self:GetChecked() then

        self.Position = Lerp(FrameTime() * 10,menu_cump.DermaCheckbox.Position,w/1.6)

        if self:IsHovered() then
          draw.RoundedBox(ScrW()/112.9, 0, 0, w, h, Color(77,161,227))
        else
          draw.RoundedBox(ScrW()/112.9, 0, 0, w, h, Color(0,120,225))
        end
          draw.RoundedBox(ScrW()/64, self.Position, h/6.5, h/1.5, h/1.5, Color(255,255,255))

      else

        self.Position = Lerp(FrameTime() * 10,menu_cump.DermaCheckbox.Position,w/10)

          draw.RoundedBox(ScrW()/112.9, 0, 0, w, h, Color(0,0,0))
          draw.RoundedBox(ScrW()/112.9, w/35, h/25, w/1.05, h/1.1, Color(255,255,255))

          draw.RoundedBox(ScrW()/64, self.Position, h/6.5, h/1.5, h/1.5, Color(0,0,0))

      end

    end

    menu_cump.DermaCheckbox.OnChange = function(self)

      PoliceSysteme.Config[id] = self:GetChecked()

    end

  elseif types == "Choice" then

    local tbl = {}

    menu_cump.PanelPrincipi = vgui.Create("DPanel", layout)
    menu_cump.PanelPrincipi:SetSize(panel:GetWide(), panel:GetTall() / 7)
    menu_cump.PanelPrincipi:Center()
    menu_cump.PanelPrincipi.Paint = function(self, w, h)
      surface.SetDrawColor(ColorPanel)
      surface.DrawRect(0, 0, w, h)
      draw.SimpleTextOutlined(txt,"FontPolice6Config", w / 50, h / 10, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      draw.SimpleTextOutlined(":","FontPolice6Config", w / 8, h / 2, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      if #tbl == 0 then

        for k,v in pairs(PoliceSysteme.Config.TeamPolice) do

          if k == #PoliceSysteme.Config.TeamPolice then

            draw.SimpleTextOutlined(v,"FontPolice2Config", w / 8 + k*50, h / 2, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

          else

            draw.SimpleTextOutlined(v .. " - ","FontPolice2Config", w / 8 + k*50, h / 2, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

          end

        end

      else

        for k,v in pairs(tbl) do

          if k == #tbl then

            draw.SimpleTextOutlined(v,"FontPolice2Config", w / 8 + k*50, h / 2, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

          else

            draw.SimpleTextOutlined(v .. " - ","FontPolice2Config", w / 8 + k*50, h / 2, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

          end

        end

      end

    end

    menu_cump.DermaMenu = vgui.Create("DButton", menu_cump.PanelPrincipi)
    menu_cump.DermaMenu:SetSize(menu_cump.PanelPrincipi:GetWide() / 10, menu_cump.PanelPrincipi:GetTall() / 3)
    menu_cump.DermaMenu:CenterHorizontal(0.07)
    menu_cump.DermaMenu:CenterVertical(0.5)
    menu_cump.DermaMenu:SetText("")
    menu_cump.DermaMenu.Paint = function(self,w,h)

      if self:IsHovered() then

        draw.RoundedBox(3, 0, 0, w, h, Color(43, 69, 92, 150))

      else

        draw.RoundedBox(3, 0, 0, w, h, Color(0, 120, 225, 255))

      end

      draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("job"),"FontPolice6Config", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

    end

    menu_cump.DermaMenu.DoClick = function()

      surface.PlaySound("UI/buttonclick.wav")

      local menu = DermaMenu()

      menu.Think = function(self)
        self:MoveToFront()
      end

      for k,v in pairs(tabl) do

        menu:AddOption(k .. " : " .. v.name, function()

          surface.PlaySound("UI/buttonclick.wav")
          table.insert(tbl,k)

        end)

      end

      menu:Open()

    end

    menu_cump.Valide = vgui.Create("DButton", menu_cump.PanelPrincipi)
    menu_cump.Valide:SetSize(menu_cump.PanelPrincipi:GetWide() / 10, menu_cump.PanelPrincipi:GetTall() / 3)
    menu_cump.Valide:CenterHorizontal(0.5)
    menu_cump.Valide:CenterVertical(0.5)
    menu_cump.Valide:SetText("")
    menu_cump.Valide.Paint = function(self,w,h)

      if self:IsHovered() then

        draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("valid"),"FontPolice6Config", w / 2, h / 2, Color(145,145,145), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      else

        draw.SimpleTextOutlined(PoliceSysteme:GetPhrase("valid"),"FontPolice6Config", w / 2, h / 2, Color(0,120,215), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(0,0,0))

      end

    end

    menu_cump.Valide.DoClick = function()

      surface.PlaySound("UI/buttonclick.wav")
      PoliceSysteme.Config[id] = tbl

    end

  end

end

net.Receive("PoliceSysteme::PlayerResetConfigSend",function()

  PoliceSysteme.Config = net.ReadTable()
  Ranktable = {}

end)

return Fonction
