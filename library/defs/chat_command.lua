---@meta _
-- DRAFT 1 DONE
-- lua_api.md: Definition tables > Chat command definition

--[[
WIPDOC
]]
---@class core.ChatCommandDef
--[[
Note that in params, the conventional use of symbols is as follows:

* `<>` signifies a placeholder to be replaced when the command is used. For
  example, when a player name is needed: `<name>`
* `[]` signifies param is optional and not required when the command is used.
  For example, if you require param1 but param2 is optional:
  `<param1> [<param2>]`
* `|` signifies exclusive or. The command requires one param from the options
  provided. For example: `<param1> | <param2>`
* `()` signifies grouping. For example, when param1 and param2 are both
  required, or only param3 is required: `(<param1> <param2>) | <param3>`
]]
---@field params string?
--[[
WIPDOC
]]
---@field description string?
--[[
WIPDOC
]]
---@field privs table<string, boolean>?
--[[
WIPDOC
]]
---@field func fun(name:string, param:string): boolean?, string?
