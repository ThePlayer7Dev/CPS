hook.Add("InitPostEntity","InitPostEntityLoadFile",function()

  if file.Exists("policedata/config.txt","DATA") then

    PoliceSysteme = util.JSONToTable(file.Read("policedata/config.txt","DATA"))

  end

  if SERVER then

    MsgC(Color(255, 255, 255), "-- [Police-Systeme] Server Start...\n")

    if not file.Exists("policedata","DATA") then

      file.CreateDir("policedata")
      file.CreateDir("policedata/time")
      file.CreateDir("policedata/rank")
      file.CreateDir("policedata/rapport")

    end

    local files = file.Find("police_systeme/config/*.lua","LUA")

    for _, file in ipairs( files ) do

        AddCSLuaFile("police_systeme/config/" .. file)
        include("police_systeme/config/" .. file)

    end

    local files = file.Find("police_systeme/shared/*.lua","LUA")

    for _, file in ipairs( files ) do

        AddCSLuaFile("police_systeme/shared/" .. file)
        include("police_systeme/shared/" .. file)

    end

    local files = file.Find("police_systeme/server/*.lua","LUA")

    for _, file in ipairs( files ) do

      include("police_systeme/server/" .. file)

    end

    local files = file.Find("police_systeme/client/*.lua","LUA")

    for _, file in ipairs( files ) do

      AddCSLuaFile("police_systeme/client/" .. file)

    end

    MsgC(Color(255, 255, 255), "-- [Police-Systeme] Server Finish...\n")

  end

  if CLIENT then

    local files = file.Find("police_systeme/client/*.lua","LUA")

    for _, file in ipairs( files ) do

      include("police_systeme/client/" .. file)

    end

    local files = file.Find("police_systeme/config/*.lua","LUA")

    for _, file in ipairs( files ) do

      include("police_systeme/config/" .. file)

    end

    local files = file.Find("police_systeme/shared/*.lua","LUA")

    for _, file in ipairs( files ) do

      include("police_systeme/shared/" .. file)

    end

  end

end)
