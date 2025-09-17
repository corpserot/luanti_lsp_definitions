---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Registered entities
-- lua_api.md: Definition tables > Entity definition

-- -------------------------------- EntityDef ------------------------------- --

--[[
WIPDOC
]]
---@class core.EntityDef
--[[
WIPDOC
]]
---@field initial_properties core.ObjectProperties.set
--[[
WIPDOC
]]
---@field on_activate? fun(self:core.Entity, staticdata:string, dtime_s:number)
--[[
WIPDOC
]]
---@field on_deactivate? fun(self:core.Entity, removal:boolean)
--[[
WIPDOC
]]
---@field on_step? fun(self:core.Entity, dtime:number, moveresult:core.Entity.moveresult?)
--[[
WIPDOC
]]
---@field on_punch? fun(self:core.Entity, puncher:core.EntityRef?, ime_from_last_punch:number?, tool_capabilities:core.ToolCapabilities?, dir:vector, damage:number):boolean
--[[
WIPDOC
]]
---@field on_death? fun(self:core.Entity, killer:core.EntityRef?)
--[[
WIPDOC
]]
---@field on_rightclick? fun(self:core.Entity, clicker:core.EntityRef)
--[[
WIPDOC
]]
---@field on_attach_child? fun(self:core.Entity, child:core.EntityRef)
--[[
WIPDOC
]]
---@field on_detach_child? fun(self:core.Entity, child:core.EntityRef)
--[[
WIPDOC
]]
---@field on_detach? fun(self:core.Entity, parent:core.EntityRef)
--[[
WIPDOC
]]
---@field get_staticdata? fun(self:core.Entity):string

-- --------------------------------- Entity --------------------------------- --

--[[
Functions receive a "luaentity" table as `self`:

* It has the member `name`, which is the registered name `("mod:thing")`
* It has the member `object`, which is an `core.EntityRef` pointing to the object
* The original prototype is visible directly via a metatable
]]
---@class core.Entity : core.EntityDef
--[[
WIPDOC
]]
---@field initial_properties core.ObjectProperties.set
--[[
WIPDOC
]]
---@field  name string
--[[
WIPDOC
]]
---@field  object core.EntityRef
