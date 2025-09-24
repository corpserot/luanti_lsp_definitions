---@meta _
-- DRAFT 1 DONE
-- lua_api.md: 'core' namespace reference > Inventory

--[[
WIPDOC
]]
---@class core.InventoryLocation
---@field type "node"|"player"|"detached"
---@field name string?
---@field pos vector?

-- `core.get_inventory(location)`: returns an `InvRef`
--
-- * `location` = e.g.
--     * `{type="player", name="celeron55"}`
--     * `{type="node", pos={x=, y=, z=}}`
--     * `{type="detached", name="creative"}`
---@param location inventory_location
---@return InvRef
function core.get_inventory(location) end

---@nodiscard
---@param name string
---@param callbacks nil
---@param player_name string?
---@return InvRef
function core.create_detached_inventory(name, callbacks, player_name) end

---@param name string
---@return boolean
function core.remove_detached_inventory(name) end