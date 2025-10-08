---@meta _
-- DRAFT 1 DONE
-- luanti/doc/lua_api.md: Definition tables > Authentication handler definition

-- --------------------------- AuthenticationData --------------------------- --

--[[
WIPDOC
]]
---@class core.AuthenticationData
--[[
WIPDOC
]]
---@field password string
--[[
WIPDOC
]]
---@field privileges core.PrivilegeSet
--[[
WIPDOC
]]
---@field last_login number?

-- ------------------------ AuthenticationHandlerDef ------------------------ --

--[[
WIPDOC
]]
---@alias core.AuthenticationHandlerDef.get_auth fun(name:string?):core.AuthenticationData

--[[
WIPDOC
]]
---@alias core.AuthenticationHandlerDef.create_auth fun(name:string, password:string)

--[[
WIPDOC
]]
---@alias core.AuthenticationHandlerDef.delete_auth fun(name:string): boolean

--[[
WIPDOC
]]
---@alias core.AuthenticationHandlerDef.set_password fun(name:string, password:string)

--[[
WIPDOC
]]
---@alias core.AuthenticationHandlerDef.set_privileges fun(name:string?, privileges:core.PrivilegeSet?)

--[[
WIPDOC
]]
---@alias core.AuthenticationHandlerDef.reload fun():boolean

--[[
WIPDOC
]]
---@alias core.AuthenticationHandlerDef.record_login fun(name:string)

--[[
WIPDOC
]]
---@alias _.AuthenticationHandlerDef.iterate fun():string?

--[[
WIPDOC
]]
---@alias core.AuthenticationHandlerDef.iterate fun():_.AuthenticationHandlerDef.iterate

--[[
WIPDOC
]]
---@class core.AuthenticationHandlerDef
--[[
WIPDOC
]]
---@field get_auth fun(name:string?):core.AuthenticationData
--[[
WIPDOC
]]
---@field create_auth fun(name:string, password:string)
--[[
WIPDOC
]]
---@field delete_auth fun(name:string): boolean
--[[
WIPDOC
]]
---@field set_password fun(name:string, password:string)
--[[
WIPDOC
]]
---@field set_privileges fun(name:string?, privileges:core.PrivilegeSet?)
--[[
WIPDOC
]]
---@field reload fun():boolean
--[[
WIPDOC
]]
---@field record_login fun(name:string)
--[[
WIPDOC
]]
---@field iterate fun(): (fun():string?)