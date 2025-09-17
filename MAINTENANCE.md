# Guidelines
You should try to get new information merged into the following places first. These are considered *primary sources*. e.g. You want to clarify that object rotations are actually right-handed. You should make a PR to these repos first.
- <https://github.com/luanti-org/luanti/>, usually something within `doc` directory.
- <https://github.com/luanti-org/docs.luanti.org/>

This project represents yet another place to document the API through annotation. It is expected that this project will have some extra information not suitable for inclusion in the primary sources.

Contributors should get familiar with [LuaCATS, the annotation & type system](https://luals.github.io/wiki/annotations) used in this project. Also, please read the [**maintenance**](#maintenance) section before beginning your work \:D

## Annotation conventions
### Annotation flavours
These are the main annotation flavours used by other Lua library definition projects:
1. LuaCATS: currently the most popular annotation flavour. Product of the [LuaLS project](https://luals.github.io/)
2. EmmyLua: renewed annotation flavour now fully supporting LuaCATS. Product of the [EmmyLua project](https://github.com/EmmyLuaLs/emmylua-analyzer-rust)

For compatibility with both great projects, the subset of both is used which currently means that annotations are written in LuaCATS. In the future, this may change as EmmyLua development speed continues to trend, being faster than LuaLS.

The following are exceptions to LuaCATS:
- EmmyLua `@see` is much more powerful and versatile, and the preferred flavour used.

### `@class` and inheritance
LuaCATS's `@class` allows us to create plain table types, or perhaps better known in Luanti as *definition tables*.

Next, inheritance refers to how these `@class` types can mix together into one. This is useful to split up fields and methods to reduce duplication. The following describes the conventions used in this library definition:

- `*.__base`: Designates the main base type, usually acting as the sub-`@class` to a multitude of variant types.

- `*.__partial`: Designates a sub-`@class` with extra fields and functions unique to a subset of variant types

- `*.<Primitive type>fmt`: Designates a sub-type in the format of that `<Primitive type>`
  - `Tablefmt` is the most common sub-type format, followed by `Stringfmt`

### Field limitations
Many annotation keywords just don't work with fields, so it's placed inside the documentation text.

```lua
--[[
This is my field

* @default `false` for players, `true` for entities
* @deprecated 5.12 Consider doing Y instead
* @see [lua_api.md > 'core' namespace reference > section](https://api.luanti.org/core-namespace-reference/#section) > `core.function`
]]
---@field my_field boolean?
```

Not supported:
- `@default`
- `@deprecated`
- `@see`

### Other conventions

- Use `--[[ ... ]]` comment blocks to indicate the documentation text.
  - Requirements below are loose, but consider using `@see` to defer information to the primary sources.
  - It may be up to 32 lines long and at most 80 characters long, not including the brackets.
  - Do not include examples in annotations if it is too long (>5 lines). Use `@see`\
    e.g. `core.LSystem` has a 15 line example, thusly it is excluded.

- Mark deprecated or discouraged practices with `@deprecated`.\
  e.g. using `minetest` namespace.

- Implementation details can be intentionally opaque or hidden where useful.\
  e.g. the `number` handle returned by `core.sound_play(...)` is instead annotated as `core.SoundHandle`.

- While it is *preferred* to maintain the primary sources text verbatim, it's usually too lengthy to be included as-is or would create a confusing amalgamation. As such, it is more accurate to consider all documentation text diverging from primary sources.

- Naming conventions:
  - All type names must be under the `core.*` namespace. The immediate name must be in `PascalCase` while the rest are in `snake_case`\
    e.g. `core.ParticleSpawner.tween.float_range`
    - The only exceptions are the `vector` types which are considered to be a "primitive".
  - If a name is not explicitly provided in the primary sources, please derive a sensible name

- Do not annotate implicit typecasting as valid practice.\
  e.g. `number` to `string` automatic casting for `MetaDataRef:set_string(...)` simply because it uses `luaL_checklstring(...)`

- Do not discard useful return values. Annotate `@nodiscard` to discourage this practice:
  - `success`/`ok` booleans indicating operation success/failure.
  - Instantiation or instances from constructors
  - Getter functions and methods.

- Do not annotate undocumented `builtin/*.lua` APIs. These APIs shouldn't be exposed in this project as it is out of scope.
  - There's exceptions for common builtins spotted in (usually older) mods and games. It's expected that this would shrink as more builtin becomes documented behaviour in `lua_api.md`

## LuaCATS Limitations
Some of these may apply to EmmyLua, but we are not targetting that annotation flavour so it's not very relevant.


# Maintenance
To facilitate faster "catching up" for newcomers and future forgetful maintainers, it is recommended to document information related to maintaining this project.

## Update checklist
Every time the definition files are updated please check through this list:
1. [Check and test](#checking-and-testing) your modifications.
2. Run through the [`cspell` checker](#spell-checking).
3. Update the commit hash at the top of the `README.md`.
4. Luanti stable release update? grep for the last release version and update wherever necessary.

## Checking and testing
After updating or adding more complicated symbols, you should test if your annotation appears correctly. Make a temporary Lua project outside of the library definition and play around with related symbols, you don't need to run it in Luanti. You may need to restart LuaLS.

Another way of checking whether your annotation is correct is to try it out with existing mods and games. This is a bit advanced since you're expected to know how to create your own `.luarc.json` file for that project if it doesn't have one (very common). Perhaps even make a custom definition file for that project due to meddling with engine APIs.

## Looking up the implementation and use of a symbol
Sometimes, the primary sources does not really document the API very well leading to confusion, or that you felt that the primary sources missed something. You will need to search through Luanti's source code for mentions of that symbol. You may use `find`, `grep`, `fzf`, your built-in editor project-wide search, LSP symbols search, etc to ease the work. You'll become more familiar with the codebase as you do this more often, so don't get discouraged!

**EXAMPLE** Let's say you vaguely remember seeing shaped craft recipes passed to `core.register_craft(recipe)` accepting `core.ItemStack`s. Here are some searches you could try to check its implementation:
- `^//.*register_craft` regex in C++ source code files
- `"registered_craft"` regex in C++ source code files
- `function.*register_craft` regex in Lua files under `builtin/*`
- `registered_craft` regex in Lua files under `builtin/*`
- Or any other more specific searches. Reading the code surrounding the results will usually lead you to a better understanding and clarify details.

## Tracking new Luanti changes
For lazier maintenance, you can check Luanti's `doc` directory git history when tracking down new changes. You should also use the commit from that directory's git history when accounting for *last Luanti commit* instead of the repository as a whole.

Though unlikely, there could be API and implementation details outside of `doc` important to annotate. Feel free to defer that work to whoever spots that mistake.

It's recommended that you are either famililar with Git, or have tools that make this work easy

## Spell Checking
For spell checking, [`cspell`](https://cspell.org/) is used. You are encouraged to set it up for your editor or use it as-is.

- With npm, you can run it simply like so `npx cspell path/to/repo`
- For VSCode users, you can use [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
- For Neovim users, you can use [cspell.nvim](https://github.com/davidmh/cspell.nvim). It depend on null-ls/none-ls however.