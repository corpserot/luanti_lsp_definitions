---@meta _
-- DRAFT 1 DONE
-- luanti/doc/lua_api.md: Groups

-- ------------------------------- Groups.item ------------------------------ --

--[[
WIPDOC
]]
---@class core.Groups.item : {[string]:integer}
--[[
WIPDOC
]]
---@field not_in_creative_inventory integer?

-- ------------------------------- Groups.node ------------------------------ --

---@alias _.Groups.special.attached_node
--- | 0
--- | 1
--- | 2
--- | 3
--- | 4

--[[
WIPDOC
]]
---@alias core.Groups.special.attached_node integer | _.Groups.special.attached_node

--[[
WIPDOC
]]
---@alias _.Groups.special.dig_immediate
--- | 0
--- | 1
--- | 2
--- | 3
---@alias core.Groups.special.dig_immediate integer | _.Groups.special.dig_immediate

---@alias _.Groups.special.disable_jump
--- | 0
--- | 1

--[[
WIPDOC
]]
---@alias core.Groups.special.disable_jump integer | _.Groups.special.disable_jump

---@alias _.Groups.special.disable_descend
--- | 0
--- | 1

--[[
WIPDOC
]]
---@alias core.Groups.special.disable_descend integer | _.Groups.special.disable_descend

---@alias _.Groups.special.falling_node
--- | 0
--- | 1

--[[
WIPDOC
]]
---@alias core.Groups.special.falling_node integer | _.Groups.special.falling_node

---@alias _.Groups.special.float
--- | 0
--- | 1

--[[
WIPDOC
]]
---@alias core.Groups.special.float integer | _.Groups.special.float

--[[
WIPDOC
]]
---@class core.Groups.node : core.Groups.item
--[[
WIPDOC
]]
---@field attached_node core.Groups.special.attached_node?
--[[
WIPDOC
]]
---@field bouncy integer?
--[[
WIPDOC
]]
---@field connect_to_raillike integer?
--[[
WIPDOC
]]
---@field dig_immediate core.Groups.special.dig_immediate?
--[[
WIPDOC
]]
---@field disable_jump core.Groups.special.disable_jump?
--[[
WIPDOC
]]
---@field disable_descend core.Groups.special.disable_descend?
--[[
WIPDOC
]]
---@field fall_damage_add_percent integer?
--[[
WIPDOC
]]
---@field falling_node core.Groups.special.falling_node?
--[[
WIPDOC
]]
---@field float core.Groups.special.float?
--[[
WIPDOC
]]
---@field level integer?
--[[
WIPDOC
]]
---@field slippery integer?

-- ------------------------------- Groups.tool ------------------------------ --

---@alias _.Groups.special.disable_repair
--- | 0
--- | 1

--[[
WIPDOC
]]
---@alias core.Groups.special.disable_repair integer | _.Groups.special.disable_repair

--[[
WIPDOC
]]
---@class core.Groups.tool : core.Groups.item
--[[
WIPDOC
]]
---@field disable_repair core.Groups.special.disable_repair?

-- ------------------------------ Groups.armor ------------------------------ --

---@alias _.Groups.special.immortal
--- | 0
--- | 1

--[[
WIPDOC
]]
---@alias core.Groups.special.immortal integer | _.Groups.special.immortal

---@alias _.Groups.special.punch_operable
--- | 0
--- | 1

--[[
WIPDOC
]]
---@alias core.Groups.special.punch_operable integer | _.Groups.special.punch_operable

--[[
WIPDOC
]]
---@class core.Groups.armor : {[string]:integer}
--[[
WIPDOC
]]
---@field immortal core.Groups.special.immortal?
--[[
WIPDOC
]]
---@field fall_damage_add_percent integer?
--[[
WIPDOC
]]
---@field punch_operable core.Groups.special.punch_operable?