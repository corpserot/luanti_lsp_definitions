---@meta _
-- DRAFT 1 DONE
-- lua_api.md: 'core' namespace reference > Utilities

-- ------------------------- engine and client info ------------------------- --

--[[
Returns currently loading mod's name WHEN LOADING A MOD
]]
---@return string
---@nodiscard
function core.get_current_modname() end

--[[
WIPDOC
]]
---@nodiscard
---@param modname string
---@return string
function core.get_modpath(modname) end

--[[
WIPDOC
]]
---@return string[]
---@nodiscard
function core.get_modnames() end

--[[
Unofficial: Path is the root directory of the game, useful if you are looking for it
]]
---@return {id:string, title:string, author:string, path:string}
function core.get_game_info() end

--[[
WIPDOC
]]
---@return string
---@nodiscard
function core.get_worldpath() end

--[[
WIPDOC
]]
---@return boolean
function core.is_singleplayer() end

--[[ core.features split off into ./features.lua  ]]--

--[[
WIPDOC
]]
---@nodiscard
---@param arg string[]|string
---@return boolean, table<string, boolean> missing_features
function core.has_feature(arg) end

--[[ core.get_player_information() split off into ./player_information.lua ]]--

--[[ core.protocol_versions.lua() split off into ./protocol_versions.lua ]]--

--[[ core.get_player_window_information() split off into ./player_information.lua ]]--

-- ------------------------------- filesystem ------------------------------- --

--[[
WIPDOC
]]
---@nodiscard
---@param path string
---@return boolean success
function core.mkdir(path) end

--[[
WIPDOC
]]
---@nodiscard
---@param path string
---@param recursive boolean?
---@return boolean success
function core.rmdir(path, recursive) end

--[[
WIPDOC
]]
---@nodiscard
---@param source string
---@param destination string
---@return boolean success
function core.cpdir(source, destination) end

--[[
WIPDOC
]]
---@nodiscard
---@param source string
---@param destination string
---@return boolean success
function core.mvdir(source, destination) end

--[[
* `core.get_dir_list(path, [is_dir])`: returns list of entry names
    * is_dir is one of:
        * nil: return all entries,
        * true: return only subdirectory names, or
        * false: return only file names.
]]
---@nodiscard
---@param path string
---@param is_dir nil|true|false
function core.get_dir_list(path, is_dir) end

--[[
* `core.safe_file_write(path, content)`: returns boolean indicating success
    * Replaces contents of file at path with new contents in a safe (atomic)
      way. Use this instead of below code when writing e.g. database files:
      `local f = io.open(path, "wb"); f:write(content); f:close()`
]]
---@nodiscard
---@param path string
---@param content string
---@return boolean success
function core.safe_file_write(path, content) end

-- ----------------------------- engine version ----------------------------- --

--[[
Use this for informational purposes only. The information in the returned
  table does not represent the capabilities of the engine, nor is it
  reliable or verifiable. Compatible forks will have a different name and
  version entirely. To check for the presence of engine features, test
  whether the functions exported by the wanted features exist. For example:
  `if core.check_for_falling then ... end`.
]]
---@class core.EngineVersion
local version = {}

--[[
Name of the project, eg, "Luanti"
]]
---@type  "Luanti"
version.project = nil

--[[
Simple version, eg, "1.2.3-dev"
]]
---@type  string
version.string = nil

--[[
The minimum supported protocol version
]]
---@type  number
version.proto_min = nil

--[[
The maximum supported protocol version
]]
---@type  number
version.proto_max = nil

--[[
Full git version (only set if available), eg, "1.2.3-dev-01234567-dirty".
]]
---@type  string
version.hash = nil

--[[
Boolean value indicating whether it's a development build
]]
---@type  boolean
version.is_dev = nil

--[[
WIPDOC
]]
---@return core.EngineVersion
function core.get_version() end

-- ---------------------------------- hash ---------------------------------- --

--[[
WIPDOC
]]
---@nodiscard
---@param data string
---@param raw boolean? raw bytes instead of hex digits, default: false
---@return string
function core.sha1(data, raw) end

--[[
WIPDOC
]]
---@nodiscard
---@param data string
---@param raw boolean? raw bytes instead of hex digits, default: false
---@return string
function core.sha256(data, raw) end

-- --------------------------------- colors --------------------------------- --

--[[
Colorspec to hex basically
]]
---@param colorspec core.ColorSpec
---@return core.ColorString
function core.colorspec_to_colorstring(colorspec) end

--[[
Layout: RGBA
]]
---@return string
---@param colorspec core.ColorSpec
function core.colorspec_to_bytes(colorspec) end

--[[
WIPDOC
]]
---@param colorspec core.ColorSpec
---@return {r:number,g:number,b:number,a:number}
function core.colorspec_to_table(colorspec) end

-- ---------------------------------- misc ---------------------------------- --

--[[
WIPDOC
]]
---@param time_of_day string
---@return number
function core.time_to_day_night_ratio(time_of_day) end

--[[
Unofficial note: shhh.... but you can do this in `core.handle_async` instead, get like a really good Promise library
Unofficial note: shh... but you can also use it real-time and it's real cool
Unofficial note: you can do "[png:"..core.encode_base64(core.encode_png(...)) to have a png
Unofficial note: Can we do jpeg XL next?
* `core.encode_png(width, height, data, [compression])`: Encode a PNG
  image and return it in string form.
    * `width`: Width of the image
    * `height`: Height of the image
    * `data`: Image data, one of:
        * array table of ColorSpec, length must be width*height
        * string with raw RGBA pixels, length must be width*height*4
    * `compression`: Optional zlib compression level, number in range 0 to 9.
  The data is one-dimensional, starting in the upper left corner of the image
  and laid out in scanlines going from left to right, then top to bottom.
  You can use `colorspec_to_bytes` to generate raw RGBA values.
  Palettes are not supported at the moment.
  You may use this to procedurally generate textures during server init.
]]
---@nodiscard
---@param width integer
---@param height integer
---@param data string | core.ColorSpec[]
---@param compression integer?
---@return string
function core.encode_png(width, height, data, compression) end

--[[
* `core.urlencode(str)`: Encodes reserved URI characters by a
  percent sign followed by two hex digits. See
  [RFC 3986, section 2.3](https://datatracker.ietf.org/doc/html/rfc3986#section-2.3).
]]
---@param str string
---@return string
function core.urlencode(str) end