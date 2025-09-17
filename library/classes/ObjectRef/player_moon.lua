---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Class reference > `ObjectRef`

-- -------------------------- PlayerMoonParameters -------------------------- --

--[[
WIPDOC
]]
---@class core.PlayerMoonParameters.set
--[[
WIPDOC
]]
---@field visible boolean?
--[[
WIPDOC
]]
---@field texture string?
--[[
WIPDOC
]]
---@field tonemap string?
--[[
WIPDOC
]]
---@field scale number?

--[[
WIPDOC
]]
---@class core.PlayerMoonParameters.get
--[[
WIPDOC
]]
---@field visible boolean
--[[
WIPDOC
]]
---@field texture string
--[[
WIPDOC
]]
---@field tonemap string
--[[
WIPDOC
]]
---@field scale number

-- ---------------------------- PlayerRef methods --------------------------- --

---@class core.PlayerRef
local PlayerRef

--[[
WIPDOC
]]
---@param moon_parameters core.PlayerMoonParameters.set
function PlayerRef:set_moon(moon_parameters) end

--[[
* `get_moon()`: returns a table with the current moon parameters as in
    `set_moon`.
]]
---@return core.PlayerMoonParameters.get
function PlayerRef:get_moon() end