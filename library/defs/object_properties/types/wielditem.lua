---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Definition tables > Object properties

-- --------------- ObjectProperties.wielditem.textures.strict --------------- --

--[[
WIPDOC
]]
---@class core.ObjectProperties.wielditem.textures.strict
--[[
WIPDOC
]]
---@field [1] number

-- ----------------------- ObjectProperties.wielditem ----------------------- --

--[[
WIPDOC
]]
---@class core.ObjectProperties.wielditem.set : _.ObjectProperties.__base.set, _.ObjectProperties.wielditem.set.__partial

--[[
WIPDOC
]]
---@class core.ObjectProperties.wielditem.get : _.ObjectProperties.__base.get, _.ObjectProperties.wielditem.get.__partial

---@class _.ObjectProperties.wielditem.set.__partial
--[[
WIPDOC
]]
---@field visual "wielditem"
--[[
WIPDOC
]]
---@field wield_item string
--[[
WIPDOC

* @deprecated
]]
---@field textures string[]|core.ObjectProperties.wielditem.textures.strict?

---@class _.ObjectProperties.wielditem.get.__partial
--[[
WIPDOC
]]
---@field visual "wielditem"
--[[
WIPDOC
]]
---@field wield_item string
--[[
WIPDOC

* @deprecated
]]
---@field textures string[]|core.ObjectProperties.wielditem.textures.strict

