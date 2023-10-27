repeat task.wait() until game:IsLoaded()
local RequestFunctions = {
    ["synapse"] = (syn and syn.request),
    ["unc1"] = (http and http.request),
    ["unc2"] = http_request,
    ["unc3"] = request
}
local Executor = nil
if RequestFunctions["synapase"] and not RequestFunctions["unc1"] and not RequestFunctions["unc2"] and
    not RequestFunctions["unc3"] then
    Executor = "Synapse X"
elseif RequestFunctions["unc1"] and not RequestFunctions["unc2"] and not RequestFunctions["unc3"] then
    Executor = "Script-Ware"
elseif RequestFunctions["unc1"] or RequestFunctions["unc2"] or RequestFunctions["unc3"] then
    Executor = "UWP Executor"
end
local ExecutorName, ExecutorVersion = identifyexecutor()
if not ExecutorVersion or ExecutorVersion == ExecutorName then
    ExecutorVersion = 0
end
assert(Executor, "Unsupported executor?: Missing / Mismatching Request Function(s)")
warn("executor:", Executor)
local Yuuki = game.PlaceId
if Yuuki == 0088 then -- test placeid
    fAz6NJGD = true
    elseif Yuuki == 0022 then -- test placeid
        cv8m4R8T = true
            elseif Yuuki == 10819569010 then -- del
                DcZcGjr2 = true
                    elseif Yuuki == 12790732092 then -- del
                        uBM4zEqT = true
                        elseif Yuuki == 6873104649 then
                            a8a6vJimh = true
                            elseif Yuuki == 662417684 then
                                llbb = true
                                elseif Yuuki == 5780309044 then
                                    TCaU = true
                            else
                                local LoaderReal = 'https://github.com/Aqsyn/workspace/main/'
                                loadstring(game:HttpGet(LoaderReal .. 'wrong2.lua'))()
                                print("loadstring done",Yuuki)
                                --[[
                                game.Players.LocalPlayer:Kick("Game Not Support")
                                wait(.1)
                                game:GetService("TeleportService"):Teleport(Yuuki, game:GetService("Players").LocalPlayer)
                                --]]
                            end
                            warn("PlaceId",Yuuki)
                            local LoaderReal = 'https://github.com/Aqsyn/workspace/main/'
                            if DcZcGjr2 then
                                loadstring(game:HttpGet(LoaderReal .. 'Fall.lua'))()
                            end
                            if a8a6vJimh then
                                loadstring(game:HttpGet(LoaderReal .. 'dth.lua'))()
                            end
                            if llbb then
                                loadstring(game:HttpGet(LoaderReal .. 'lbb'))()
                            end
                            if TCaU then
                                loadstring(game:HttpGet(LoaderReal .. 'TcanU'))()
                            end
