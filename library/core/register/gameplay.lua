---@meta _
-- DRAFT 1 DONE
-- lua_api.md: 'core' namespace reference > Registration functions

--[[
WIPDOC
]]
---@param craft_recipe core.CraftingRecipeDef
function core.register_craft(craft_recipe) end

--[[
WIPDOC
]]
---@param recipe table?
function core.clear_craft(recipe) end

--[[
WIPDOC
]]
---@param name string
---@param chatcommand_def core.ChatCommandDef
function core.register_chatcommand(name, chatcommand_def) end

--[[
WIPDOC
]]
---@param name string
---@param redef table sorry no types
function core.override_chatcommand(name, redef) end

--[[
WIPDOC
]]
---@param name string
function core.unregister_chatcommand(name) end

--[[
WIPDOC
]]
---@param def core.PrivilegeDef
---@param name string
function core.register_privilege(name, def) end

--[[
* Registers an auth handler that overrides the builtin one.
* This function can be called by a single mod once only.
]]
---@param auth_handler_def table you know what you are doing, i am sorry but no types
function core.register_authentication_handler(auth_handler_def) end