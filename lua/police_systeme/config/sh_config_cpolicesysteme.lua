if not istable(PoliceSysteme) then
//////////////////////Don't Touch -- Ne pas toucher /////////////////////
  PoliceSysteme = PoliceSysteme or {}

  PoliceSysteme.Config = PoliceSysteme.Config or {}

  PoliceSysteme.Config.Wanted = {}
  PoliceSysteme.Config.RankTime = {}

  PoliceSysteme.Config.Model = PoliceSysteme.Config.Model or {}

  ////////////////////// Config /////////////////////// !/! YOU CAN CONFIG IN GAME WITH THE COMMANDE : ConfigCPS !\!

  PoliceSysteme.Config.Model.Computer = "models/props/cs_office/computer.mdl"  -- Model Of Computer -- Model de l'Ordinateur
  PoliceSysteme.Config.Model.Armory = "models/items/ammocrate_smg1.mdl" -- Model of Armory -- Model de l'armurie

  --PoliceSysteme.Config.Model.MaterialWanter = Material("materials/police_systeme/police.png")

  PoliceSysteme.Config.TimeWanted = 200
  PoliceSysteme.Config.TimeArrest = 200

  PoliceSysteme.Config.Language = "fr"  -- Language french (fr) or english(en)  -- Langue française(fr) ou anglaise(en)
  PoliceSysteme.Config.TeamPolice = {TEAM_POLICE, TEAM_RAID}
  PoliceSysteme.Config.CanUpWithTime = true    -- Turn false, if you don't want the player rankup with a time -- Mettez false si vous voulez que les joueurs ne rankup pas avec le temps


  ////////// Text 2d3d /////////////////
  PoliceSysteme.Config.RankAndNick = true -- Draw a text on all player in a team of PoliceSysteme.Config.TeamPolice with his rank and his nick  -- Dessine le nom et le grade de tous les joueurs qui sont dans les team de PoliceSysteme.Config.TeamPolice
  PoliceSysteme.Config.ColorTextNick = Color(255,255,255)  -- Color nick ext -- Couleur du texte du nom
  PoliceSysteme.Config.ColorStrokeNick = Color(0,0,0)  -- Color of nick stroke  -- Couleur du contour du nom
  PoliceSysteme.Config.ColorTextRank = Color(0,0,255)  -- Color rank text -- Couleur du texte du grade
  PoliceSysteme.Config.ColorStrokeRank = Color(100,100,100)  -- Color of rank stroke  -- Couleur du contour du grade
  PoliceSysteme.Config.DistanceMaxSee = 2000000  -- Max Distance where you can see the text  -- La distance maximal ou vous pouvez voir le texte



  ///////// EmergencyCall /////////////////
  PoliceSysteme.Config.ActiveCommandeHelp = true -- The EmergencyCall commande -- Le EmergencyCall commande
  PoliceSysteme.Config.Commande = "!policehelp" -- The commande -- La commande
  PoliceSysteme.Config.ColorChange = true -- The text blinking -- Le clignotement du texte
  PoliceSysteme.Config.Color1 = Color(255,0,0) -- The First Color of the text -- La 1er couleur du texte
  PoliceSysteme.Config.Color2 = Color(0,0,255) -- The second color of the text -- La 2eme couleur du texte
  PoliceSysteme.Config.DrawIconDanger = true  -- Draw an attention sign above the player -- Dessine un panneau attention au dessus du joueur
  --PoliceSysteme.Config.Model.MaterialDanger = Material("materials/police_systeme/danger.png")  -- Material of the attention sign above the player -- Le materiau du panneau attention
  ///// Ping //////////////////////////////
  PoliceSysteme.Config.ActivePing = true

  PoliceSysteme.Config.CanGetDownPeople = true


  //////////Armory ///////////////////////
  PoliceSysteme.Config.TimeWaitForCanWeap = 2   --  The time that the player need wait to can take an other weapon (Second) -- Le temps que le joueur doit attendre pour renprendre une nouvelle arme dans l'armurie
  PoliceSysteme.Config.Ammogive = 120
  ////////Rank////////////////////////////
  PoliceSysteme.Config.Rank = {}

  PoliceSysteme.Config.Rank[1] = {  -- Default Rank   -- Le Grade Par Defaut

    name = "Recrue", -- Name Of Rank  -- Nom du grade
    time = 0,  -- Time on minute -- Temps en minutes -- Time a player need to up in this rank
    canpromote = true,  -- Can Promote all rank before him  -- Peut promouvoir tous les grades avant le sien
    canpromoteAll = true,-- Can Promote all rank  --  Peut promouvoir tous les grades
    canDeleteReport = true, -- Can Delete report  -- Peut supprimer des rapports
    weapons = {    -- Weapons given in a Armory  -- Les armes donné dans l'armurie
      ["weapon_mp52"] = true,
    },
  }

  PoliceSysteme.Config.Rank[2] = {

    name = "Commandant",
    time = 15,
    canpromote = true,
    canpromoteAll = true,
    canDeleteReport = true,
    weapons = {
      ["weapon_mp52"] = true,
    },
  }

end


//////////////////////Don't Touch -- Ne pas toucher /////////////////////

for k,v in pairs(PoliceSysteme.Config.Rank) do

  PoliceSysteme.Config.RankTime[v.time] = k

end
