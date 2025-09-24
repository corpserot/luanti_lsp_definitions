---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Helper functions

--[[
WIPDOC
]]
---@param str string
---@param limit integer
---@param as_table boolean?
---@return string
function core.wrap_text(str, limit, as_table) end

--[[
WIPDOC
]]
---@param pos vector
---@param decimal_places number?
---@return string
function core.pos_to_string(pos, decimal_places) end

--[[
WIPDOC
]]
---@param string string
---@return vector
function core.string_to_pos(string) end

--[[
returns two positions
Converts a string representing an area box into two positions
X1, Y1, ... Z2 are coordinates
relative_to: Optional. If set to a position, each coordinate can use the tilde notation for relative positions
"~": Relative coordinate
"~<number>": Relative coordinate plus <number>
Example: core.string_to_area("(1,2,3) (~5,~-5,~)", {x=10,y=10,z=10}) returns {x=1,y=2,z=3}, {x=15,y=5,z=10}
]]
---@param str string (X1, Y1, Z1) (X2, Y2, Z2)
---@param relative_to vector?
---@return vector?, vector?
function core.string_to_area(str, relative_to) end

--[[
escapes the characters "[", "]", "", "," and ";", which cannot be used in formspecs.
]]
---@param string string
---@return string
function core.formspec_escape(string) end

--[[
WIPDOC
]]
---@param arg any
---@return boolean
function core.is_yes(arg) end

--[[
WIPDOC
]]
---@param arg any
---@return boolean
function core.is_nan(arg) end

--[[
returns time with microsecond precision. May not return wall time.
Unofficial note: I think you should use os.clock() for benchmarking instead
]]
---@return number
function core.get_us_time() end

--[[ after table.* intermission ]]--

--[[
WIPDOC
]]
---@param placer PlayerRef
---@param pointed_thing core.PointedThing
---@return vector
function core.pointed_thing_to_face_pos(placer, pointed_thing) end

--[[
WIPDOC
]]
---@param uses integer
---@param initial_wear integer?
---@return integer
function core.get_tool_wear_after_use(uses, initial_wear) end

--[[
WIPDOC
]]
---@nodiscard
---@param groups table<string, integer>
---@param tool_capabilities tool_capabilities
---@param wear integer?
---@return table
function core.get_dig_params(groups, tool_capabilities, wear) end

--[[
WIPDOC
]]
---@nodiscard
---@param groups table<string, integer>
---@param wear integer?
---@param tool_capabilities tool_capabilities?
---@param time_from_last_punch number?
---@return table
function core.get_hit_params(groups, tool_capabilities, time_from_last_punch, wear) end