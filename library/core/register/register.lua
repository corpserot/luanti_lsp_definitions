---@meta _
-- DRAFT 1 WIP
-- luanti src/?.cpp: ?
-- luanti builtin/?.lua: ?

-- -------------------------------------------------------------------------- --
---@type table<string, ItemDef?>
core.registered_items = core.registered_items
---@type table<string, NodeDef?>
core.registered_nodes = core.registered_nodes
---@type table<string, ItemDef?>
core.registered_craftitems = core.registered_craftitems
---@type table<string, ItemDef?>
core.registered_tools = core.registered_tools
---@type table<string, EntityDef?>
core.registered_entities = core.registered_entities
---@type table<integer, ObjectRef>
core.object_refs = core.object_refs
---@type table<integer, luaentity>
core.luaentities = core.luaentities
---@type ABMDef[]
core.registered_abms = core.registered_abms
---@type LBMDef[]
core.registered_lbms = core.registered_lbms
---@type table<string, string>
core.registered_aliases = core.registered_aliases
---@type table<string|integer, OreDef?>
core.registered_ores = core.registered_ores
---@type table<string|integer, BiomeDef?>
core.registered_biomes = core.registered_biomes
---@type table<string|integer, DecorationDef?>
core.registered_decorations = core.registered_decorations
---@type table<string, ChatCommandDef?>
core.registered_chatcommands = core.registered_chatcommands
---@type table<string, PrivDef?>
core.registered_privileges = core.registered_privileges

--- I got lazy, sowwy :<

---@type function[]
core.registered_on_chat_messages = core.registered_on_chat_messages
---@type function[]
core.registered_on_chatcommands = core.registered_on_chatcommands
---@type function[]
core.registered_globalsteps = core.registered_globalsteps
---@type function[]
core.registered_on_punchnodes = core.registered_on_punchnodes
---@type function[]
core.registered_on_placenodes = core.registered_on_placenodes
---@type function[]
core.registered_on_dignodes = core.registered_on_dignodes
---@type function[]
core.registered_on_generateds = core.registered_on_generateds
---@type function[]
core.registered_on_newplayers = core.registered_on_newplayers
---@type function[]
core.registered_on_dieplayers = core.registered_on_dieplayers
---@type function[]
core.registered_on_respawnplayers = core.registered_on_respawnplayers
---@type function[]
core.registered_on_prejoinplayers = core.registered_on_prejoinplayers
---@type function[]
core.registered_on_joinplayers = core.registered_on_joinplayers
---@type function[]
core.registered_on_leaveplayers = core.registered_on_leaveplayers
---@type function[]
core.registered_on_player_receive_fields = core.registered_on_player_receive_fields
---@type function[]
core.registered_on_cheats = core.registered_on_cheats
---@type function[]
core.registered_on_crafts = core.registered_on_crafts
---@type function[]
core.registered_craft_predicts = core.registered_craft_predicts
---@type function[]
core.registered_on_item_eats = core.registered_on_item_eats
---@type function[]
core.registered_on_item_pickups = core.registered_on_item_pickups
---@type function[]
core.registered_on_punchplayers = core.registered_on_punchplayers
---@type function[]
core.registered_on_authplayers = core.registered_on_authplayers
---@type function[]
core.registered_on_player_inventory_actions = core.registered_on_player_inventory_actions
---@type function[]
core.registered_allow_player_inventory_actions = core.registered_allow_player_inventory_actions
---@type function[]
core.registered_on_rightclickplayers = core.registered_on_rightclickplayers
---@type function[]
core.registered_on_mods_loaded = core.registered_on_mods_loaded
---@type function[]
core.registered_on_shutdown = core.registered_on_shutdown
---@type function[]
core.registered_on_protection_violation = core.registered_on_protection_violation
---@type function[]
core.registered_on_priv_grant = core.registered_on_priv_grant
---@type function[]
core.registered_on_priv_revoke = core.registered_on_priv_revoke
---@type function[]
core.registered_can_bypass_userlimit = core.registered_can_bypass_userlimit
---@type function[]
core.registered_on_modchannel_message = core.registered_on_modchannel_message
---@type function[]
core.registered_on_liquid_transformed = core.registered_on_liquid_transformed
---@type function[]
core.registered_on_mapblocks_changed = core.registered_on_mapblocks_changed




