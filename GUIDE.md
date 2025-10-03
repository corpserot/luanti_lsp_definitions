This file contains information specifically related to annotations both for this library definition and in general. It is similar to [docs.luanti.org](https://docs.luanti.org) but much smaller in scope.

# A quick brief on annotations in Lua
Lua annotations are special comments used to provide metadata, type hints, or documentation for code without affecting execution. Before popularity of language servers, annotations merely supplement as comments for the programmer, documentation generators and a few linters.

Nowadays, language servers like [LuaLS](https://luals.github.io/) and [EmmyLua](https://github.com/EmmyLuaLs/emmylua-analyzer-rust) have developed their own respective annotation flavours to enhance their IDE-like features.

If you're familiar with Typescript and JSDoc then you'll see that both language servers aligns with JSDoc's approach compared to Typescript. If you would like to examine the equivalence of Typescript in Lua, you can check [Nattlua](https://github.com/CapsAdmin/NattLua) or [Luau](https://luau.org/) or even [Typescript to Lua](https://typescripttolua.github.io/).

In any case, the aim is to shift Lua from a dynamically weak type system into a [gradual type system](https://web.archive.org/web/20250524002852/https://jsiek.github.io/home/WhatIsGradualTyping.html) to allow for more meaningful semantic analysis.

The annotation flavours available are:
1. LuaCATS: currently the most popular annotation flavour. Product of the LuaLS project.
2. EmmyLua: renewed annotation flavour now fully supporting LuaCATS. Product of the EmmyLua project.

For compatibility with both great projects, the subset of both is used which currently means that annotations are written in LuaCATS. In the future, this may change as EmmyLua development may outpace LuaLS or break LuaCATS compatibility.

# Extra annotations
There are "extra" annotations that are used to encode specific information in the hover text without affecting the diagnostics. Some existing annotation keywords are re-used in the same way.

- Ranges: Any kind of ranges are *italicized* and lua expressions except bare numbers are formatted as `code`. It can apply to non-numbers like vectors. Some examples:
  - *[-1,1]* is an inclusive range from -1 to 1. If this is associated with an `integer`, then the only values are -1, 0, 1.
  - *[0,`#list`)* is a range beginning from 0 to `#list` (exclusive/non-inclusive).
  - *>=0* is a range with a lower bound 0. It implies zero and all positive numbers.
  - *`min` < `max` and `min` > (0,0,0)* asserts that `min` must be smaller than `max` and that any range of vectors above the lower bound (0,0,0) is accepted. When vectors are compared, all components must satisfy the range.
  - *`.y` > 1* asserts that the y component of a vector must be higher than the lower bound 1.
- Extra annotation info: Extra annotations are placed inside the documentation text as a list at the end.
- `@param` and `@return` for `fun()` types:
  - Since types are already specified inside the `fun()` type, the type is excluded. Everything else works exactly the same. An example can be seen below.
- Inline keywords: Some keywords has an inline variant e.g. `@default()` which are used on the same line as the relevant symbol.
  - `@default()`: Indicates the default value. Currently the only inline keyword.

All extra annotations and existing ones used in ways not affecting diagnostics are listed below.

```lua
--[[
These are extra annotations available to all.

* @added 5.1.0 This indicates the stable luanti version that added this feature
* @deprecated 5.2.0 This indicates the stable luanti version that deprecated this feature
* @breaking 5.3.0 This indicates the stable luanti version that broke the compatibility of this feature or removed it
* @internal This indicates that it's an undocumented internal implementation and subject to change
* @see path/to/doc.md > Section #This indicates a section within a markdown document
* @see https://web.site This indicates an online resource
]]
---@type integer
MY_CONSTANT = nil

--[[
These are extra annotations unique to fun().

* @param a This is a simple param.
* @param b @default(`"default value"`) This is a param with a default value
* @param ... This is a variadic param.
* @return @default(*list of words from `b`*) This indicates what it returns.
]]
---@alias MyFunction fun(a:integer, b:string?, ...:boolean): string[]
```

# Aliases
LuaCATS `@alias`es are used in many ways in this library definition. It's *not recommended* to configure your language server to expand aliases. Common techniques are listed below:

- Special values or alias enums will be suggested by the language server. This is utilized to its fullest extent.

- Used to annotate [nominal types](#nominal-types).

- Used to create non-table enums/alias enums/special values. This is very common in Luanti API. In comparison, table `@enum`s annotated are very rare, if it exists at all.\
  Sometimes indicated by `*.special`

- Used to create table key enums. In absence of `keyof` like in Typescript, this is implemented by the error-prone approach of just writing it like a non-table enum.\
  Sometimes indicated by `*.keys`

# Nominal types
Some types derived from primitive types have no differences whatsoever in the annotation type system. In some cases however, it is useful to give these types names even if it's not possible to express its true restrictions and rules. We call them *nominal types*

To qualify as a *Nominal type*, it must have special restrictions, rules or contents that is not expressible through the annotation type system. This rule is to prevent flooding the library definition with too many useless types. You can open an issue to justify why something *should* or *should not* be a nominal type. The following lists specifics about this rule:
- Alias enums satisfies this rule. A different interpretation is that a nominal type is needed for alias enums.
  - e.g. Item names violates some subrules below. However, it has special values `"air"`, `"ignore"` and others. So, it is granted a `string` nominal type `core.Item.name`.
- Name syntax/specification does not satisfy this rule.
  - e.g. LBM names (should) have a special syntax `<mod>:<name>`. But, it isn't granted a `string` nominal type `core.LBMDef.name`
- General integer/number range limitations does not satisfy this rule.
  - e.g. world units in nodes are limited to within *[-31000,31000]*. But, it isn't granted a `number` or `integer` nominal type `core.WorldUnit`
  - e.g. Node params has special meanings and conversion rules, not just a [0,255] range. So, it is granted an `integer` nominal type `core.Param2`
- Simple units do not satisfy this rule.
  - e.g. `ObjectRef` health does not use a unit, or could be interpreted as a very simple unit. So, it isn't granted an `integer` nominal type `core.ObjectRef.hp`
  - e.g. Tool wear uses a unit unique to Luanti with some special rules in how to interpret it. So, it is granted an `integer` nominal type `core.Tool.wear`

# Other practices
Practices that don't need a section to explain it.

- Implementation details can be intentionally opaque or hidden where useful.\
  e.g. the `integer` handle returned by `core.sound_play(...)` is instead annotated as `core.SoundID`.

- For the name in types immediately after its namespace, it must be in `PascalCase` while the rest are in `snake_case`\
    e.g. `core.ParticleSpawner.tween.float_range`

- Mark deprecated or discouraged practices with `@deprecated`.\
  e.g. using `minetest` namespace.

- Do not set project-wide diagnostics in your game/mod. Instead use file-scoped or line diagnostics directives.\
    e.g `---@diagnostic disable-next-line: lowercase-global`

# Dependencies
Dependencies matter for annotations. If code is annotated, you'll have to fetch the code. If it has a library definition, you'll have to fetch the library definition instead.

There are two approaches to dependency depending on what you're developing:

- Game developers should just include their dependencies inside their game (preferrably through git submodules or a dependency manager).

- Mod developers... a good solution has yet to exist. You would have to manually fetch all of your dependencies for development. It gets complicated when trying to support many games...

# Annotating games or mods
When annotating a game or mod, you have two approaches:
1. (*Simple, recommended for general needs*) Annotate the code.
2. (*Complicated, satisfies specific needs*) Annotate a separate library definition. This is the approach used by this library definition for Luanti API.

There are benefits to either or both approaches, however the usual approach is to annotate the code.

Published games in active development should consider approach #2 (separate library definition). It helps you decide which part of your API is stable enough for modders to use. It also draws a line for parts internal to your game or simply not ready for use in modding.

# Type namespaces
Types need names and names can clash. That's why library definitions choose to namespace their types. This library definition chooses the following namespaces. Avoid using these namespaces for your own types.

- `_.*` internal/hidden types. Used to reduce clutter for autocompletion.
- `core.*` main namespace
- `corelib.*` environment namespaces.

Furthermore, this library definition reserves the following types. Avoid trampling them:
- Any of the vector types e.g. `vector` and `ivec`. They're meant to be "primitives"
- `OneOrMany`
- `SparseList`

Your game or mod should namespace your types too following this format: `<namespace>.MyType`.

# Extending the library definition
It is *highly recommended* that you at least skim through the definition of the types before you decide to extend it. As a reminder, you should be aware that language servers have no concept of hierarchy when reading these annotations. It doesn't read your dependencies or this library definition first, it reads in an unspecified order.

The "extension" model is for games and mods to simply provide types that can be used to "patch" into this library definition. It's not much different from the techniques used in this project. Please read further for examples.

TODO implement the proposed patch system, see [issue#25](https://github.com/corpserot/luanti_lsp_definitions/issues/25). it would make patching a lot easier and more manageable

## Extending classes
This is trivial:
```lua
-- everything is defined within the mod by the developer

---@class core.ItemDef
---@field _rarity integer #adds this field to item definitions

--- Sometimes, you'll have to work with internal classes
---@class _.ObjectProperties.__base
---@field _power integer #adds this field to object properties
```

## Extending aliases
The game or mod developer can instruct the user to patch the relevant type with their extension:

```lua
-- `core.Node.name` extension defined within the mod by the developer
---@alias morewoods.Node.name
--- | "morewoods:chengal_log"
--- | "morewoods:meranti_log"
--- | "morewoods:merbau_log"
--- | ...

-- developer instruct users to patch `core.Node.name`
---@alias core.Node.name
--- | morewoods.Node.name #this is the line the user added
--- | "unknown"
--- | "air"
--- | "ignore"
--- | string
```

## Extending functions
There are two cases when it comes to functions: regular functions and `fun()` types. Regular functions can be extended very easily so it is trivial:

```lua
---@param name string|core.PlayerRef #additionally accepts PlayerRef
---@param text string
---@param notify boolean? #whether to ping the player
---@return boolean? #Whether it goes into the player's inbox (offline) or not (online)
function core.chat_send_player(name, text, notify) end
```

When it comes to `fun()` types however, a approach similar to `@alias` is required. A few fields and parameters may not get an alias. You can make an issue or PR about it, along with justification why it should get an alias type.

```lua
-- `core.fn.on_chatcommand` extension defined within the mod by the developer
---@alias modalcmds.fn.on_chatcommand fun(name:string, command:string, params:string, mode:modalcmds.Modes)

-- developer instruct users to patch `core.fn.on_chatcommand`
---@alias core.fn.on_chatcommand
--- | modalcmds.fn.on_chatcommand
--- | fun(name:string, command:string, params:string)
```

## Extending fields
There are a couple of techniques available, all with certain benefits and caveats:

1. Add to the field's type instead of the field itself (see above). This only works if the type is an alias. If the type is not an alias, you can make an issue or PR about it, along with justification why the field should get an alias type.

2. Create a subclass of the field's class by changing the library definition:
   ```lua
   -- defined within the mod
   ---@class smart_liquids.NodeDef.__partial
   --- if given a function, that function is evaluated
   --- to determine if the node should flood at `pos`
   ---@field liquid_renewable boolean|fun(pos:vec):boolean

   -- instruct developers to redefine `core.NodeDef` in this library definition
   ---@class _.NodeDef.__original
   -- ...the original definition of core.NodeDef as in this library definition...

   -- order is important here, the first parent overrides the later ones!
   ---@class core.NodeDef : smart_liquids.NodeDef.__partial, _.NodeDef.__original
   ```