
-- DO NOT MODIFY THIS UNLESS YOU KNOW WHAT YOU'RE DOING
local protocol = "RMOD"

local serverAPI = require("serverAPI")

local RMOD_path = "RMOD"
--RMOD modules are saved as "<RMOD_path>/<module_name>/<version>.lua"
local module_path = fs.combine(RMOD_path, "%s/%d.lua")
--RMOD metadata files are saved as "<RMOD_path>/<module_name>/meta.txt"
local metadata_path = fs.combine(RMOD_path, "%s/meta.txt")


--Utility
local function removeFileExtension(p) return p:match("(.*)%..+") end

local function getMeta(module)
    local path = metadata_path:format(module)
    
    local fh = fs.open(path, "r")
    local meta = textutils.unserialize(fh.readAll())
    fh.close()
    
    return meta
end

local function getLatestVersion(module) return getMeta(module).latest_version end


local function msgHandler(_, msg, _)
    local module = msg.module
    local version = msg.version or getLatestVersion(module)

    local path = module_path:format(module, version)

    local data = nil
    if fs.exists(path) then
        local fh = fs.open(path, "r")
        data = fh.readAll()
        fh.close()
    else data = false end

    return data
end


--Setup function - RUN BEFORE ANYTHING ELSE
local function setup()
    local modems = { peripheral.find("modem") }
    if #modems==0 then printError("No modem found"); return nil end
    for _, m in ipairs(modems) do
        rednet.open( peripheral.getName(m) )
    end
    print("All modems open")
end

setup()

return {
    setup = function(hostname) serverAPI.setup(msgHandler, "rmod."..hostname, protocol) end,
    start = serverAPI.start,
}
