# Guidelines
You should try to get new information merged into the following places first. These are considered *primary sources*. e.g. You want to clarify that object rotations are actually right-handed. You should make a PR to these repos first.
- <https://github.com/luanti-org/luanti/>, usually something within `doc` directory.
- <https://github.com/luanti-org/docs.luanti.org/>

This project represents yet another place to document the API through annotation. It is expected that this project will have some extra information not suitable for inclusion in the primary sources.

Contributors should get familiar with [LuaCATS, the annotation & type system](https://luals.github.io/wiki/annotations) used in this project. Also, please read the [**maintenance**](#maintenance) section before beginning your work \:D

## LuaCATS extra terminology
Because of the very "hacky" way some LuaCATS features are used, it gets hard to describe some techniques without just showing the related annotation. To ease the process, the following terms are used to describe some techniques used:
- Supertypes and subtypes: Supertype is a type composed from "simpler" type(s) using `@alias` to unify them as one. Subtypes are simpler types used to form supertypes.\
  e.g. `CraftingRecipe` is the supertype in the relationship to `CraftingRecipe.shaped`, `CraftingRecipe.shapeless`, `CraftingRecipe.toolrepair`, and others.
- Variant types and base types: Similar to the above, but in an inverted way. Variant types are types composed from a base type using `@class` inheritance to derive new types. Base types are simpler types with shared fields & methods of all variant types.\
  e.g. `core.Schematic.MapNode0` is the base type to the variants `core.Schematic.MapNode1` and `core.Schematic.MapNode2`.
- Plain table type refer to using `@class` to create plain table types. This is comparable to interfaces in Typescript.\
  e.g. `NodeDef` and `core.SoundParams`
- Flags (sub)type refer to the flag specifier format defined for various data. See the relevant chapter in `doc/lua_api.md`.\
  e.g. `DecorationDef.schematic.flags` is essentially either a string or a plain table type.

## LuaCATS Conventions
When annotating, please follow the conventions below. Additionally deduce conventions from the surrounding and related definitions.
- Mark deprecated or discouraged practices with `@deprecated`.\
  e.g. using `minetest` namespace.

- Implementation details can be intentionally opaque or hidden where useful.\
  e.g. the `number` handle returned by `core.sound_play(...)` is instead annotated as `core.SoundHandle`.

- It's *preferred* to maintain the primary sources text verbatim by *appending extra information* instead of modifying it.
  - Nonetheless, it's expected some divergence occurs where it's more useful.\
    e.g. The documentation for `core.GenNotification` is too long to describe its main ideas, so a *revision* is used to shrink down unnecessary text.
  - Extra information appended will have **`LIBDEF AMENDMENT`** label.
  - Modified primary source text will have **`LIBDEF REVISION`** label.

- Naming conventions:
  - Your custom symbol names should be under the `core.*` namespace if it's not a real lua symbol recognised in the primary sources. Derive a suitable name from built-in Lua code, engine C++ code or your own intuition.\
  - (Super)Types follow `PascalCase`, while their subtypes follow `camelCase`.\
  - Base types and variant types are *preferred* to have meaningful names, but `0`, `1`, `2` works just as well.
  - Plain table types in `Definition Tables` chapter from `doc/lua_api.md` doesn't need to be namespaced under `core.*` and a `def` somewhere in its name is *required*.\
    e.g. `NodeDef`, `LBMDef` and `EntityDef`.
  - Classes in `Class reference` chapter from `doc/lua_api.md` doesn't need to be namespaced under `core.*`
    e.g. `ItemStack`, `MetaDataRef` and `ObjectRef`.
  - Supertype data may have a plain table format subtype. In such cases, a `tablefmt` somewhere in its name is *required*.\
    e.g. `core.Schematic` has a plain table subtype `core.Schematic.tablefmt`.
  - Opaque data are (usually) primitives not suitable for operating on it. In such cases, a `handle` or `ID` somewhere in its name is *required*.\
    e.g. `core.ContentID` and `HTTP_async_handle` are opaque and not suitable to operate on.

- Certain limitations of LuaCATS means that some annotations cannot be expressed. In such cases, a list is appended either at the top or the end.

  **EXAMPLE**

  ```lua
  --[[
  - **@default**: `"opaque"`

  -----

  Specifies how the texture's alpha channel will be used for rendering.
  --- >8 snipped 8< ---
    Only use this when correct rendering among semitransparent nodes is necessary.
  ]]
  ---@field use_texture_alpha? "opaque"|"clip"|"blend"
  ```

  - **@deprecated** (top): This field is deprecated.
  - **@default** (top): The given Lua value/expression by default when unspecified. If it's "empty" (`nil`, empty table, empty string) it's safe to not specify this.
  - **@see** (any): URL containing related information. e.g. formats of frequently used URLs
    - `[Hand on docs.luanti.org](https://docs.luanti.org/for-creators/hand/)`
    - `[Value Noise on wikipedia.org](https://wikipedia.org/wiki/Value_noise)`
    - `[OBJ File Format on scratchapixel.com](https://www.scratchapixel.com/lessons/3d-basic-rendering/obj-file-format/obj-file-format.html)`

- Do not include long examples in annotations if it is too long (>5 lines).\
  e.g. `core.LSystem` has a 15 line example, thusly it is excluded.

- Do not annotate implicit typecasting as valid practice.\
  e.g. `number` to `string` automatic casting for `MetaDataRef:set_string(...)` simply because it uses `luaL_checklstring(...)`

- Do not discard useful return values. Annotate `@nodiscard` to discourage this practice:
  - `success`/`ok` booleans indicating operation success/failure.
  - Instantiation or instances from Constructors
  - Getter functions.

- Do not annotate any internal `builtin/*.lua` APIs. These APIs shouldn't be exposed in this project as it is out of scope.

## LuaCATS Limitations
### Why are there no diagnostics for some deprecated symbol?
The `@deprecated` annotation works only on defined Lua symbols. Not types, class fields or class methods. See discussion in [LuaLS#1313](https://github.com/LuaLS/lua-language-server/issues/1313).

### Why does aliased types suck?
Type aliases are "weak types", meaning they resolve to its defined contents and does not preserve much information about itself. This results in a multitude of issues:
- [LuaLS#2284](https://github.com/LuaLS/lua-language-server/issues/2284)
- [LuaLS#2436](https://github.com/LuaLS/lua-language-server/issues/2436), [LuaLS#2378](https://github.com/LuaLS/lua-language-server/issues/2376)
- [LuaLS@2885](https://github.com/LuaLS/lua-language-server/issues/2885)

### Why can't more type information be defined?
Compared to more expressive dynamic language type systems like in Typescript or Python type hinting, LuaCATS is a lot simpler. In many cases, we can't express more complicated cases resulting in lost type information. See discussion in [LuaLS#2817](https://github.com/LuaLS/lua-language-server/issues/2817)


# Maintenance
To facilitate faster "catching up" for newcomers and future forgetful maintainers, it is recommended to document information related to maintaining this project.

## Update checklist
Every time the definition files are updated please check through this list:
1. [Check and test](#checking-and-testing) your modifications.
2. Run through the [`cspell` checker](#spell-checking).
3. Update the commit hash at the top of the `README.md`.
4. Luanti stable release update? grep for the last release version and update wherever necessary.

## Checking and testing
After updating or adding more complicated symbols, you should test if your annotation appears correctly. Make a temporary Lua file and play around with related symbols, you don't need to run it in Luanti. You may need to restart LuaLS.

**EXAMPLE** Let's say you're finished modifying the annotation for the `CraftRecipe` spec. You can try the following and see how autocompletion and hover information appears.
  ```lua
  ---@param o CraftRecipe # hover over the type
  function fn(o) -- hover over the param
    print(o.ou) -- check its fields
    return o
  end

  fn({
    type = "fuel",
    burnti
  } --[[@as CraftRecipeFuel]]) -- check its subtype instantiation
  ```

**EXAMPLE** Another way of checking whether your annotation is correct is to try it out with existing mods and games. This is a bit advanced since you're expected to know how to create your own `.luarc.json` file for that project if it doesn't have one (very common). Perhaps even make a custom definition file for that project due to meddling with engine APIs.

## Looking up the implementation and use of a symbol
Sometimes, the primary sources does not really document the API very well leading to confusion, or that you felt that the primary sources missed something. You will need to search through Luanti's source code for mentions of that symbol. You may use `find`, `grep`, `fzf`, your built-in editor project-wide search, LSP symbols search, etc to ease the work. You'll become more familiar with the codebase as you do this more often, so don't get discouraged!

**EXAMPLE** Let's say you vaguely remember seeing shaped craft recipes passed to `core.register_craft(recipe)` accepting `ItemStack`s. Here are some important searches you could try to check its implementation:
- `^// *register_craft` regex in C++ source code files
- `"registered_craft"` regex in C++ source code files
- `register_craft *= *` regex in Lua files under `builtin/*`
- `function +register_craft` regex in Lua files under `builtin/*`
- `registered_craft` regex in Lua files under `builtin/*`
- Or any other more specific searches. Reading the code surrounding the results will usually lead you to a better understanding and clarify details.

## Tracking new Luanti changes
For lazier maintenance, you can check Luanti's `doc` directory git history when tracking down new changes. You should also use the commit from that directory's git history when accounting for *last Luanti commit* instead of the repository as a whole.

- Though unlikely, there could be API and implementation details outside of `doc` important to annotate. Feel free to defer that work to whoever spots that mistake.
- For VSCode users, you may use git extensions such as [Git Graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph) and [Git History](https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory)
- For Neovim users, you may use git plugins such as [neogit](https://github.com/NeogitOrg/neogit) or [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)

## Spell Checking
For spell checking, [`cspell`](https://cspell.org/) is used. You are encouraged to set it up for your editor or use it as-is.

- With npm, you can run it simply like so `npx cspell path/to/repo`
- For VSCode users, you can use [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
- For Neovim users, you can use [cspell.nvim](https://github.com/davidmh/cspell.nvim). It depend on null-ls/none-ls however.