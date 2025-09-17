---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Definition tables > Authentication handler definition

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
---@class core.AuthenticationHandlerDef
--[[
WIPDOC
]]
---@field get_auth fun(name:string?): core.AuthenticationData
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
---@field reload fun(): boolean
--[[
WIPDOC
]]
---@field record_login fun(name:string)

-- NOTE: cannot express the following as @field

---@class core.AuthenticationHandlerDef
local AuthenticationHandlerDef = {}
--[[
WIPDOC
]]
---@generic IteratorState
---@return fun(state:`IteratorState`, player_name:string): string player_name, any ...
---@return IteratorState state
---@return string player_name
function AuthenticationHandlerDef.iterate() end