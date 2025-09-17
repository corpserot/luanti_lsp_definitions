---@meta _
-- DRAFT 1 DONE
-- lua_api.md: 'core' namespace reference > Environment access
-- lua_api.md: Class reference > `Raycast`

-- ------------------------------- constructor ------------------------------ --

--[[
* `core.raycast(pos1, pos2, objects, liquids, pointabilities)`: returns `Raycast`
    * Creates a `Raycast` object.
    * `pos1`: start of the ray
    * `pos2`: end of the ray
    * `objects`: if false, only nodes will be returned. Default is `true`.
    * `liquids`: if false, liquid nodes (`liquidtype ~= "none"`) won't be
                 returned. Default is `false`.
    * `pointabilities`: Allows overriding the `pointable` property of
      nodes and objects. Uses the same format as the `pointabilities` property
      of item definitions. Default is `nil`.
]]
---@nodiscard
---@param pos1 vector
---@param pos2 vector
---@param objects boolean?
---@param liquids boolean?
---@param pointabilities core.ItemDef.pointabilities?
---@return function core.Raycast
function Raycast(pos1, pos2, objects, liquids, pointabilities) end


--[[
* `core.raycast(pos1, pos2, objects, liquids, pointabilities)`: returns `Raycast`
    * Creates a `Raycast` object.
    * `pos1`: start of the ray
    * `pos2`: end of the ray
    * `objects`: if false, only nodes will be returned. Default is `true`.
    * `liquids`: if false, liquid nodes (`liquidtype ~= "none"`) won't be
                 returned. Default is `false`.
    * `pointabilities`: Allows overriding the `pointable` property of
      nodes and objects. Uses the same format as the `pointabilities` property
      of item definitions. Default is `nil`.
]]
---@nodiscard
---@param pos1 vector
---@param pos2 vector
---@param objects boolean?
---@param liquids boolean?
---@param pointabilities core.ItemDef.pointabilities?
---@return function core.Raycast
function core.raycast(pos1, pos2, objects, liquids, pointabilities) end

-- --------------------------------- Raycast -------------------------------- --

--[[
WIPDOC
]]
---@class core.Raycast
local Raycast = {}

--[[
WIPDOC
]]
---@return core.PointedThing?
function Raycast:next() end