---@meta _
-- DRAFT 1 DONE
-- lua_api.md: 'core' namespace reference > Utilities

-- --------------------------- player information --------------------------- --

--[[
WIPDOC
]]
---@class core.PlayerInfo
local player_info = {}

--[[
IP address of client
]]
---@type  string
player_info.address = nil

--[[
IPv4 / IPv6
]]
---@type  number
player_info.ip_version = nil

--[[
seconds since client connected
]]
---@type  number
player_info.connection_uptime = nil

--[[
protocol version used by client
]]
---@type  number
player_info.protocol_version = nil

--[[
supported formspec version
]]
---@type  number
player_info.formspec_version = nil

--[[
Language code used for translation
]]
---@type  string
player_info.lang_code = nil

--[[
minimum round trip time
]]
---@type  number?
player_info.min_rtt = nil

--[[
maximum round trip time
]]
---@type  number?
player_info.max_rtt = nil

--[[
average round trip time
]]
---@type  number?
player_info.avg_rtt = nil

--[[
minimum packet time jitter
]]
---@type  number?
player_info.min_jitter = nil

--[[
maximum packet time jitter
]]
---@type  number?
player_info.max_jitter = nil

--[[
average packet time jitter
]]
---@type  number?
player_info.avg_jitter = nil

--[[
The version information is provided by the client and may be spoofed
or inconsistent in engine forks. You must not use this for checking
feature availability of clients. Instead, do use the fields
`protocol_version` and `formspec_version` where it matters.
Use `core.protocol_versions` to map Luanti versions to protocol versions.
This version string is only suitable for analysis purposes.
full version string
]]
---@type  string
player_info.version_string = nil

---@param player_name string
---@return core.PlayerInfo
function core.get_player_information(player_name) end

-- ------------------------ player window information ----------------------- --

--[[
Unofficial note: You can compute the pixel size from this, if you are crazy you can make a library based on this or something
Will only be present if the client sent this information (requires v5.7+)

Note that none of these things are constant, they are likely to change during a client
connection as the player resizes the window and moves it between monitors

real_gui_scaling and real_hud_scaling can be used instead of DPI.
OSes don't necessarily give the physical DPI, as they may allow user configuration.
real_*_scaling is just OS DPI / 96 but with another level of user configuration.
]]
---@class core.PlayerWindowInfo
local player_window_info = {}

--[[
Current size of the in-game render target (pixels).

This is usually the window size, but may be smaller in certain situations,
such as side-by-side mode.
]]
---@type  {x:integer,  y:integer}
player_window_info.size = nil

--[[
Estimated maximum formspec size before Luanti will start shrinking the
formspec to fit. For a fullscreen formspec, use the size returned by
this table  and `padding[0,0]`. `bgcolor[;true]` is also recommended.
]]
---@type  {x: number, y:number}
player_window_info.max_formspec_size = nil

--[[
GUI Scaling multiplier
Equal to the setting `gui_scaling` multiplied by `dpi / 96`
]]
---@type  number
player_window_info.real_gui_scaling = nil

--[[
HUD Scaling multiplier
Equal to the setting `hud_scaling` multiplied by `dpi / 96`
]]
---@type  number
player_window_info.real_hud_scaling = nil

--[[
Whether the touchscreen controls are enabled.
Usually (but not always) `true` on Android.
Requires at least version 5.9.0 on the client. For older clients, it
is always set to `false`.
]]
---@type  boolean
player_window_info.touch_controls = nil

--[[
WIPDOC
]]
---@param player_name string
---@return core.PlayerWindowInfo? Client must have version 5.7+
function core.get_player_window_information(player_name) end