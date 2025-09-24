---@meta _
-- DRAFT 1 WIP
-- lua_api.md: ?
-- lua_api.md: 'core' namespace reference > Environment access

-- TODO this is temporarily moved here to assess this gen_notify stuff

--[[
Returns a table. You need to announce your interest in a specific
field by calling `core.set_gen_notify()` *before* map generation happens.

* key = string: generation notification type
* value = list of positions (usually)
   * Exceptions are denoted in the listing below.

Available generation notification types:

* `dungeon`: bottom center position of dungeon rooms
* `temple`: as above but for desert temples (mgv6 only)
* `cave_begin`
* `cave_end`
* `large_cave_begin`
* `large_cave_end`
* `custom`: data originating from [Mapgen environment](#mapgen-environment) (Lua API)
   * This is a table.
   * key = user-defined ID (string)
   * value = arbitrary Lua value
* `decoration#id`: decorations
  * (see below)

Decorations have a key in the format of `"decoration#id"`, where `id` is the
numeric unique decoration ID as returned by `core.get_decoration_id()`.
For example, `decoration#123`.

The returned positions are the ground surface 'place_on' nodes,
not the decorations themselves. A 'simple' type decoration is often 1
node above the returned position and possibly displaced by 'place_offset_y'.
]]
---@class core.gen_notify
---@field dungeon vector?
---@field temple vector?
---@field cave_begin vector?
---@field cave_end vector?
---@field large_cave_begin vector?
---@field large_cave_end vector?
---@field custom table<string, any>
---@field [string] vector?

---@class core.gen_notify_flags.tablefmt
---@field dungeon boolean?
---@field temple boolean?
---@field cave_begin boolean?
---@field cave_end boolean?
---@field large_cave_begin boolean?
---@field large_cave_end boolean?
---@field decoration boolean?
---@field custom boolean?

---@alias core.gen_notify_flags string|core.gen_notify_flags.tablefmt

--[[
* `core.set_gen_notify(flags, [deco_ids], [custom_ids])`
    * Set the types of on-generate notifications that should be collected.
    * `flags`: flag field, see [`gennotify`] for available generation notification types.
    * The following parameters are optional:
    * `deco_ids` is a list of IDs of decorations which notification
      is requested for.
    * `custom_ids` is a list of user-defined IDs (strings) which are
      requested. By convention these should be the mod name with an optional
      colon and specifier added, e.g. `"default"` or `"default:dungeon_loot"`
]]
---@param flags core.gen_notify_flags.tablefmt
---@param deco_ids integer[]?
---@param custom_ids string[]?
function core.set_gen_notify(flags, deco_ids, custom_ids) end

--[[
* `core.get_gen_notify()`
    * Returns a flagstring, a table with the `deco_id`s and a table with
      user-defined IDs.
]]
---@return string, integer[], string[]
function core.get_gen_notify() end