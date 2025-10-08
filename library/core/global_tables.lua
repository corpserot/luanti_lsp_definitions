---@meta _
-- DRAFT 1 DONE
-- luanti/doc/lua_api.md: 'core' namespace reference > Global tables
--[=[
NOTE: manually searched from output log of below in a minimal game:
core.log(dump2(core, 'core'))
]=]

--[[
WIPDOC
]]
---@type (fun())[]
core.registered_on_mods_loaded = {}

--[[
WIPDOC
]]
---@type (fun())[]
core.registered_on_shutdown = {}

--[[
WIPDOC
]]
---@type (fun(minp:ivec, maxp:ivec, blockseed:integer))[]
core.registered_on_generateds = {}

--[[
WIPDOC
]]
---@type (fun(ObjectRef:core.PlayerRef))[]
core.registered_on_newplayers = {}

--[[
WIPDOC
]]
---@type (fun(ObjectRef:core.PlayerRef, reason: core.PlayerHPChangeReason))[]
core.registered_on_dieplayers = {}

--[[
WIPDOC
]]
---@type (fun(ObjectRef:core.PlayerRef):boolean?)[]
core.registered_on_respawnplayers = {}

--[[
WIPDOC
]]
---@type (fun(name:string, ip:string):string?)[]
core.registered_on_prejoinplayers = {}

--[[
WIPDOC
]]
---@type (fun(ObjectRef:core.PlayerRef, last_login:integer))[]
core.registered_on_joinplayers = {}

--[[
WIPDOC
]]
---@type (fun(ObjectRef:core.PlayerRef, timed_out:boolean))[]
core.registered_on_leaveplayers = {}

--[[
WIPDOC
]]
---@type (fun(player:core.PlayerRef, formname:string, fields:core.FormspecFields):boolean?)[]
core.registered_on_player_receive_fields = {}

--[[
WIPDOC
]]
---@type (fun(ObjectRef:core.PlayerRef, cheat:core.Cheat))[]
core.registered_on_cheats = {}

--[[
WIPDOC
]]
---@type (fun(pos:ivec, name:string))[]
core.registered_on_protection_violation = {}

--[[
WIPDOC
]]
---@type (fun(player:core.PlayerRef, hitter:core.PlayerRef?, time_from_last_punch:number?, tool_capabilities:core.ToolCapabilities?, dir:vec, damage: integer):boolean?)[]
core.registered_on_punchplayers = {}

--[[
WIPDOC
]]
---@type (fun(name:string, granter:core.PlayerRef?, priv:core.PrivilegeSet.keys))[]
core.registered_on_priv_grant = {}

--[[
WIPDOC
]]
---@type (fun(name:string, revoker:core.PlayerRef?, priv:core.PrivilegeSet.keys))[]
core.registered_on_priv_revoke = {}

--[[
WIPDOC
]]
---@type (fun(name:string, ip:string, is_success:boolean))[]
core.registered_on_authplayers = {}

--[[
WIPDOC
]]
---@type (fun(name:string, ip:string):boolean?)[]
core.registered_can_bypass_userlimit = {}

--[[
WIPDOC
]]
---@type (fun(channel_name:string, sender:string, message:string))[]
core.registered_on_modchannel_message = {}

--[[
WIPDOC
]]
---@type (fun(player:core.PlayerRef, action:core.InventoryInfo.actions, inventory:core.InvRef, inventory_info:core.InventoryInfo))[]
core.registered_on_player_inventory_actions = {}

--[[
WIPDOC
]]
---@type (fun(player:core.PlayerRef, action:core.InventoryInfo.actions, inventory:core.InvRef, inventory_info:core.InventoryInfo):integer)[]
core.registered_allow_player_inventory_actions = {}

--[[
WIPDOC
]]
---@type (fun(player:core.PlayerRef, clicker:core.PlayerRef))[]
core.registered_on_rightclickplayers = {}

--[[
WIPDOC
]]
---@type (fun(pos_list: ivec[], node_list: core.Node.get[]))[]
core.registered_on_liquid_transformed = {}

--[[
WIPDOC
]]
---@type (fun(modified_blocks:table<core.PosHash,true>, modified_block_count:integer))[]
core.registered_on_mapblocks_changed = {}

--[[
WIPDOC
]]
---@type table<core.PrivilegeSet.keys, core.PrivilegeDef>
core.registered_privileges = {}

--[[
WIPDOC
]]
---@type table<core.ChatCommandDef.keys, core.ChatCommandDef>
core.registered_chatcommands = {}

--[[
WIPDOC
]]
---@type table<core.Node.name, core.NodeDef>
core.registered_nodes = {}

--[[
WIPDOC
]]
---@type (fun(itemstack:core.ItemStack, player:core.PlayerRef, old_crafting_grid:core.Item.name[][], craft_inv:core.InvRef):core.ItemStack?)[]
core.registered_on_crafts = {}

--[[
WIPDOC
]]
---@type (fun(itemstack:core.ItemStack, player:core.PlayerRef, old_crafting_grid:core.Item.name[][], craft_inv:core.InvRef):core.ItemStack?)[]
core.registered_craft_predicts = {}

--[[
WIPDOC
]]
---@type (fun(itemstack:core.ItemStack, picker:core.PlayerRef?, pointed_thing:core.PointedThing?, time_from_last_punch:number?, direction:vec?, damage:integer?):core.ItemStack?)[]
core.registered_on_item_pickups = {}

--[[
WIPDOC
]]
---@type (fun(hp_change:integer, replace_with_item:core.ItemStack?, itemstack:core.ItemStack, user:core.PlayerRef, pointed_thing:core.PointedThing):core.ItemStack?)[]
core.registered_on_item_eats = {}

--[[
WIPDOC
]]
---@type (fun(pos:ivec, oldnode:core.Node.get, digger:core.ObjectRef?))[]
core.registered_on_dignodes = {}

--[[
WIPDOC
]]
---@type (fun(pos:ivec, newnode:core.Node.get, placer:core.ObjectRef?, oldnode:core.Node.get, itemstack:core.ItemStack, pointed_thing:core.PointedThing):boolean?)[]
core.registered_on_placenodes = {}

--[[
WIPDOC
]]
---@type (fun(pos:ivec, node:core.Node.get, puncher:core.ObjectRef?, pointed_thing:core.PointedThing))[]
core.registered_on_punchnodes = {}

--[[
WIPDOC
]]
---@type table<string, core.ObjectRef>
core.objects_by_guid = {}

--[[
WIPDOC
]]
---@deprecated
---@type table<integer, core.ObjectRef>
core.object_refs = {}

--[[
WIPDOC
]]
---@type table<integer, core.Entity>
core.luaentities = {}

--[[
WIPDOC
]]
---@type table<core.Alias, core.Item.name>
core.registered_aliases = {}

--[[
WIPDOC
]]
---@type table<core.Tool.name, core.ToolDef>
core.registered_tools = {}

--[[
WIPDOC
]]
---@type table<core.Item.name, core.ItemDef>
core.registered_craftitems = {}

--[[
WIPDOC
]]
---@type table<core.Item.name, core.ItemDef>
core.registered_items = {}

--[[
WIPDOC
]]
---@type table<string, core.EntityDef>
core.registered_entities = {}

--[[
WIPDOC
]]
---@type core.LBMDef[]
core.registered_lbms = {}

--[[
WIPDOC
]]
---@type core.ABMDef[]
core.registered_abms = {}

--[[
WIPDOC
]]
---@class core.reg.on_player_hpchanges
core.registered_on_player_hpchanges = {}

--[[
WIPDOC
]]
---@type (fun(player:core.PlayerRef, hp_change:integer, reason:core.PlayerHPChangeReason):integer, boolean?)[]
core.registered_on_player_hpchanges.modifiers = {}

--[[
WIPDOC
]]
---@type (fun(player:core.PlayerRef, hp_change:integer, reason:core.PlayerHPChangeReason))[]
core.registered_on_player_hpchanges.loggers = {}

--[[
WIPDOC
]]
---@type table<string|core.BiomeID, core.BiomeDef>
core.registered_biomes = {}

--[[
WIPDOC
]]
---@type table<string|core.OreID, core.OreDef>
core.registered_ores = {}

--[[
WIPDOC
]]
---@type table<string|core.DecorationID, core.DecorationDef>
core.registered_decorations = {}

--[[
WIPDOC
]]
---@type (fun(name:string, message:string):boolean?)[]
core.registered_on_chat_messages = {}

--[[
WIPDOC
]]
---@type (fun(name:string, command:string, params:string))[]
core.registered_on_chatcommands = {}

--[[
WIPDOC
]]
---@type (fun(dtime:number))[]
core.registered_globalsteps = {}

--[[
WIPDOC
]]
---@type (fun(player:core.PlayerRef, event:core.PlayerEvent))[]
core.registered_playerevents = {}

--[[
WIPDOC
]]
---@type table<string, core.DetachedInventoryCallbacks>
core.detached_inventories = {}