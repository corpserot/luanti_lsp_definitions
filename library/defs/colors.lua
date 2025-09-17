---@meta
-- STAGE 1 DONE
-- lua_api.md: Colors

--[[
WIPDOC
]]
---@class core.ColorSpec.tablefmt
--[[
WIPDOC
]]
---@field a integer?
--[[
WIPDOC
]]
---@field r integer?
--[[
WIPDOC
]]
---@field g integer?
--[[
WIPDOC
]]
---@field b integer?

--[[
`#RGB` defines a color in hexadecimal format.

`#RGBA` defines a color in hexadecimal format and alpha channel.

`#RRGGBB` defines a color in hexadecimal format.

`#RRGGBBAA` defines a color in hexadecimal format and alpha channel.

Named colors are also supported and are equivalent to
[CSS Color Module Level 4](https://www.w3.org/TR/css-color-4/#named-color).
To specify the value of the alpha channel, append `#A` or `#AA` to the end of
the color name (e.g. `colorname#08`).
]]
---@class core.ColorString : string

--[[
WIPDOC
]]
---@class core.ColorSpec.numberfmt : integer

--[[
WIPDOC
]]
---@alias core.ColorSpec
--- | core.ColorSpec.tablefmt
--- | core.ColorString
--- | core.ColorSpec.numberfmt