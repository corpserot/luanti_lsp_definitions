---@meta
--- Covers the CraftRecipe class, alongside functions that use it

---@param craft_recipe CraftRecipe
function core.register_craft(craft_recipe) end

--[[
### Shaped

This is the default recipe type (when no `type` is specified).

A shaped recipe takes one or multiple items as input and has
a single item stack as output. The input items must be specified
in a 2-dimensional matrix (see parameters below) to specify the
exact arrangement (the "shape") in which the player must place them
in the crafting grid.

For example, for a 3x3 recipe, the `recipes` table must have
3 rows and 3 columns.

In order to craft the recipe, the players' crafting grid must
have equal or larger dimensions (both width and height).

Empty slots outside of the recipe's extents are ignored, e.g. a 3x3
recipe where only the bottom right 2x2 slots are filled is the same
as the corresponding 2x2 recipe without the empty slots.\
]]
---@class CraftRecipeShaped
--[[
* `type = "shaped"`: (optional) specifies recipe type as shaped
]]
---@field type? "shaped"
--[[
* `output`: Itemstring of output itemstack (item counts >= 1 are allowed)
]]
---@field output string
--[[
* `recipe`: A 2-dimensional matrix of items, with a width *w* and height *h*.
    * *w* and *h* are chosen by you, they don't have to be equal but must be at least 1
    * The matrix is specified as a table containing tables containing itemnames
    * The inner tables are the rows. There must be *h* tables, specified from the top to the bottom row
    * Values inside of the inner table are the columns.
      Each inner table must contain a list of *w* items, specified from left to right
    * Empty slots *must* be filled with the empty string
]]
---@field recipe string[][]
--[[
* `replacements`: (optional) Allows you to replace input items with some other items
      when something is crafted
    * Provided as a list of item pairs of the form `{ old_item, new_item }` where
      `old_item` is the input item to replace (same syntax as for a regular input
      slot; groups are allowed) and `new_item` is an itemstring for the item stack
      it will become
    * When the output is crafted, Luanti iterates through the list
      of input items if the crafting grid. For each input item stack, it checks if
      it matches with an `old_item` in the item pair list.
        * If it matches, the item will be replaced. Also, this item pair
          will *not* be applied again for the remaining items
        * If it does not match, the item is consumed (reduced by 1) normally
    * The `new_item` will appear in one of 3 places:
        * Crafting grid, if the input stack size was exactly 1
        * Player inventory, if input stack size was larger
        * Drops as item entity, if it fits neither in craft grid or inventory
]]
---@field replacements? {[1]:string, [2]:string}[]

--[[
### Shapeless

Takes a list of input items (at least 1). The order or arrangement
of input items does not matter.

In order to craft the recipe, the players' crafting grid must have matching or
larger *count* of slots. The grid dimensions do not matter.
]]
---@class CraftRecipeShapeless
--[[
* `type = "shapeless"`: Mandatory
]]
---@field type "shapeless"
--[[
* `output`: Itemstring of output itemstack (item counts >= 1 are allowed)
]]
---@field output string
--[[
* `recipe`: List of item names
]]
---@field recipe string[]
--[[
* `replacements`: (optional) Allows you to replace input items with some other items
      when something is crafted
    * Provided as a list of item pairs of the form `{ old_item, new_item }` where
      `old_item` is the input item to replace (same syntax as for a regular input
      slot; groups are allowed) and `new_item` is an itemstring for the item stack
      it will become
    * When the output is crafted, Luanti iterates through the list
      of input items if the crafting grid. For each input item stack, it checks if
      it matches with an `old_item` in the item pair list.
        * If it matches, the item will be replaced. Also, this item pair
          will *not* be applied again for the remaining items
        * If it does not match, the item is consumed (reduced by 1) normally
    * The `new_item` will appear in one of 3 places:
        * Crafting grid, if the input stack size was exactly 1
        * Player inventory, if input stack size was larger
        * Drops as item entity, if it fits neither in craft grid or inventory
]]
---@field replacements? {[1]:string, [2]:string}[]

--[[
### Tool repair

Syntax:

    {
        type = "toolrepair",
        additional_wear = -0.02, -- multiplier of 65536
    }

Adds a shapeless recipe for *every* tool that doesn't have the `disable_repair=1`
group. If this recipe is used, repairing is possible with any crafting grid
with at least 2 slots.
The player can put 2 equal tools in the craft grid to get one "repaired" tool
back.
The wear of the output is determined by the wear of both tools, plus a
'repair bonus' given by `additional_wear`. To reduce the wear (i.e. 'repair'),
you want `additional_wear` to be negative.

The formula used to calculate the resulting wear is:

    65536 * (1 - ( (1 - tool_1_wear) + (1 - tool_2_wear) + additional_wear))

The result is rounded and can't be lower than 0. If the result is 65536 or higher,
no crafting is possible.
]]
---@class CraftRecipeToolrepair
--[[
* `type = "toolrepair"`: Mandatory
]]
---@field type "toolrepair"
--[[
**AMENDMENT**
* `additional_wear`: multiplier of 65536. When repairing by getting a
  repaired tool from 2 same tools in the craft grid, the resulting wear is a
  combination of the 2 tools and a repair bonus from `additional_wear`. More
  precisely, the pseudocode determining the result is:

```lua
result = 65536 * (1 - ( (1 - tool_1_wear) + (1 - tool_2_wear) + additional_wear ) )
result = max(0, round(result)) -- rounded and can't be lower than 0
if result >= 65536 then
    -- craft made not possible
end
```
]]
---@field additional_wear number

--[[
### Cooking

A cooking recipe has a single input item, a single output item stack
and a cooking time. It represents cooking/baking/smelting/etc. items in
an oven, furnace, or something similar; the exact meaning is up for games
to decide, if they choose to use cooking at all.

The engine does not implement anything specific to cooking recipes, but
the recipes can be retrieved later using `core.get_craft_result` to
have a consistent interface across different games/mods.

]]
---@class CraftRecipeCooking
--[[
* `type = "cooking"`: Mandatory
]]
---@field type "cooking"
--[[
* `output`: Itemstring of output itemstack (item counts >= 1 are allowed)
]]
---@field output string
--[[
* `recipe`: An itemname of the single input item
]]
---@field recipe string
--[[
* `cooktime`: (optional) Time it takes to cook this item, in seconds.
              A floating-point number. (default: 3.0)
Note: Games and mods are free to re-interpret the cooktime in special
cases, e.g. for a super furnace that cooks items twice as fast.
]]
---@field cooktime number
--[[
* `replacements`: (optional) Allows you to replace input items with some other items
      when something is crafted
    * Provided as a list of item pairs of the form `{ old_item, new_item }` where
      `old_item` is the input item to replace (same syntax as for a regular input
      slot; groups are allowed) and `new_item` is an itemstring for the item stack
      it will become
    * When the output is crafted, Luanti iterates through the list
      of input items if the crafting grid. For each input item stack, it checks if
      it matches with an `old_item` in the item pair list.
        * If it matches, the item will be replaced. Also, this item pair
          will *not* be applied again for the remaining items
        * If it does not match, the item is consumed (reduced by 1) normally
    * The `new_item` will appear in one of 3 places:
        * Crafting grid, if the input stack size was exactly 1
        * Player inventory, if input stack size was larger
        * Drops as item entity, if it fits neither in craft grid or inventory

Mods that utilize cooking recipes (e.g. for adding a furnace node) need to implement
replacements on their own
]]
---@field replacements? {[1]:string, [2]:string}[]

--[[
### Fuel

A fuel recipe is an item associated with a "burning time" and an optional
item replacement. There is no output. This is usually used as fuel for
furnaces, ovens, stoves, etc.

Like with cooking recipes, the engine does not do anything specific with
fuel recipes and it's up to games and mods to use them by retrieving
them via `core.get_craft_result`.
]]
---@class CraftRecipeFuel
--[[
* `type = "fuel"`: Mandatory
]]
---@field type "fuel"
--[[
* `recipe`: Itemname of the item to be used as fuel
]]
---@field recipe string
--[[
* `burntime`: (optional) Burning time this item provides, in seconds.
              A floating-point number. (default: 1.0)
Note: Games and mods are free to re-interpret the burntime in special
cases, e.g. for an efficient furnace in which fuels burn twice as
long.
]]
---@field burntime number
--[[
* `replacements`: (optional) Allows you to replace input items with some other items
      when something is crafted
    * Provided as a list of item pairs of the form `{ old_item, new_item }` where
      `old_item` is the input item to replace (same syntax as for a regular input
      slot; groups are allowed) and `new_item` is an itemstring for the item stack
      it will become
    * When the output is crafted, Luanti iterates through the list
      of input items if the crafting grid. For each input item stack, it checks if
      it matches with an `old_item` in the item pair list.
        * If it matches, the item will be replaced. Also, this item pair
          will *not* be applied again for the remaining items
        * If it does not match, the item is consumed (reduced by 1) normally
    * The `new_item` will appear in one of 3 places:
        * Crafting grid, if the input stack size was exactly 1
        * Player inventory, if input stack size was larger
        * Drops as item entity, if it fits neither in craft grid or inventory

Mods that utilize fuels need to implement replacements on their own
]]
---@field replacements? {[1]:string, [2]:string}[]

--[[
Crafting recipes
----------------

Crafting converts one or more inputs to one output itemstack of arbitrary
count (except for fuels, which don't have an output). The conversion reduces
each input ItemStack by 1.

Craft recipes are registered by `core.register_craft` and use a
table format. The accepted parameters are listed below.

Recipe input items can either be specified by item name (item count = 1)
or by group (see "Groups in crafting recipes" for details).
Only the item name (and groups) matter for matching a recipe, i.e. meta and count
are ignored.

If multiple recipes match the input of a craft grid, one of them is chosen by the
following priority rules:

* Shaped recipes are preferred over shapeless recipes, which in turn are preferred
  over tool repair.
* Otherwise, recipes without groups are preferred over recipes with groups.
* Otherwise, earlier registered recipes are preferred.
]]
---@alias CraftRecipe
--- | CraftRecipeShaped
--- | CraftRecipeShapeless
--- | CraftRecipeToolrepair
--- | CraftRecipeCooking
--- | CraftRecipeFuel
