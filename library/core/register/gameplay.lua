---@meta _
-- Registrations for built-in gameplay features
-- luanti/doc/lua_api.md: 'core' namespace reference > Registration functions > Gameplay

--[[
Registers a crafting recipe.

* @see [`core.CraftingRecipeDef`](lua://core.CraftingRecipeDef)
* @see [luanti/doc/lua_api.md > 'core' namespace reference > Registration functions > Gameplay](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#gameplay)
* @see [luanti/src/script/lua_api/l_craft.cpp](https://github.com/luanti-org/luanti/blob/5.13.0/src/script/lua_api/l_craft.cpp)
]]
---@param craft_recipe core.CraftingRecipeDef
function core.register_craft(craft_recipe) end

--[[
Erases crafting recipes based on the recipe/inputs or the outputs. When both the
recipe/input and output is given, the output is used for lookup. Using output as
lookup additionally ignores the `.type` field in crafting recipes.

Returns `false` if candidates could not be found. Otherwise, returns `true`.

* @see [`core.CraftingRecipeDef.clear`](lua://core.CraftingRecipeDef.clear)
* @see [luanti/doc/lua_api.md > 'core' namespace reference > Registration functions > Gameplay](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#gameplay)
* @see [luanti/src/script/lua_api/l_craft.cpp](https://github.com/luanti-org/luanti/blob/5.13.0/src/script/lua_api/l_craft.cpp)
]]
---@param recipe core.CraftingRecipeDef.clear?
---@return boolean success
function core.clear_craft(recipe) end

--[[
Registers a `name` chatcommand.

* @see [`core.ChatCommandDef`](lua://core.ChatCommandDef)
* @see [luanti/doc/lua_api.md > 'core' namespace reference > Registration functions > Gameplay](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#gameplay)
* @see [luanti/builtin/common/chatcommands.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/chatcommands.lua)
]]
---@param name string
---@param chatcommand_def core.ChatCommandDef
function core.register_chatcommand(name, chatcommand_def) end

--[[
Overrides fields of the given registered `name` chatcommand.

* @see [`core.ChatCommandDef.override`](lua://core.ChatCommandDef.override)
* @see [luanti/doc/lua_api.md > 'core' namespace reference > Registration functions > Gameplay](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#gameplay)
* @see [luanti/builtin/common/chatcommands.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/chatcommands.lua)
]]
---@param name string
---@param redef core.ChatCommandDef.override
function core.override_chatcommand(name, redef) end

--[[
Unregisters `name` chatcommand.

* @see [`core.ChatCommandDef.override`](lua://core.ChatCommandDef.override)
* @see [luanti/doc/lua_api.md > 'core' namespace reference > Registration functions > Gameplay](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#gameplay)
* @see [luanti/builtin/common/chatcommands.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/common/chatcommands.lua)
]]
---@param name string
function core.unregister_chatcommand(name) end

--[[
Registers a `name` privilege.

If `def` is a description, it is granted as defaults to the players
*singleplayer* and admin. Admin is determined by the `name` setting in
`minetest.conf`.

* @see [`core.PrivilegeDef`](lua://core.PrivilegeDef)
* @see [luanti/doc/lua_api.md > 'core' namespace reference > Registration functions > Gameplay](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#gameplay)
* @see [luanti/builtin/game/privileges.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/game/privileges.lua)
]]
---@param name string
---@param def string|core.PrivilegeDef Description or definition
function core.register_privilege(name, def) end

--[[
Registers an authentication handler, overriding the builtin handler. Only one
mod can register a handler.

* @see [`core.AuthenticationHandlerDef`](lua://core.AuthenticationHandlerDef)
* @see [luanti/doc/lua_api.md > 'core' namespace reference > Registration functions > Gameplay](https://github.com/luanti-org/luanti/blob/5.13.0/doc/lua_api.md#gameplay)
* @see [luanti/builtin/game/auth.lua](https://github.com/luanti-org/luanti/blob/5.13.0/builtin/game/auth.lua)
]]
---@param auth_handler_def core.AuthenticationHandlerDef
function core.register_authentication_handler(auth_handler_def) end