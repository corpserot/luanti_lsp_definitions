# File Structure
- `.luarc.json` is the default LuaLS project configuration. You're expected to override it with your editor's personal project configuration.
- (NYI) `.emmyrc.json` is the default EmmyLua project configuration. You're expected to override it with your editor's personal project configuration.
- `config.json` is the addon configuration file. The `"settings"` portion should be minimal to encourage the developer to decide their own language server configurations.
- `GUIDE.md` is the guide for users.
- `MAINTAINENCE.md` is the guide for maintaining this project. Please read it if you would like to contribute.
- `library/` has definition files related to engine API. There is a short description at the top of each file. The contents are arranged following `lua_api.md`
  - `library/classes/` has definition files related to classes.
  - `library/core/` has definition files related to the `core` namespace.
  - `library/vector` has definition files related to vectors
  - `library/defs/` has definition files catching the rest of the `lua_api.md` contents.

# Guidelines
Contributors are expected to be able to write [LuaCATS, the annotation & type system](https://luals.github.io/wiki/annotations) used in this project. I expect that you know how to read the annotations as written in [`GUIDE.md`](https://github.com/corpserot/luanti_lsp_definitions/blob/master/GUIDE.md). I would appreciate if you skim through this document at least once.

## Updating information
You should try to get new information merged into the following places first. These are considered *primary sources*. e.g. You want to clarify that `ObjectRef` rotations are actually right-handed. You should make a PR to these repos first:
- <https://github.com/luanti-org/luanti/>, usually something within `doc` directory.
- <https://github.com/luanti-org/docs.luanti.org/>

This project represents yet another place to document Luanti API. This time, through annotation. It is expected that this project will include/exclude information compared to the primary sources above.

## Annotation conventions
### `@class` and inheritance
LuaCATS' `@class` allows us to create plain table types, or perhaps better known in Luanti as *definition tables*.

Inheritance are used for plain table types to mix them together. The following lists some naming conventions used:

- `*.__base`: Designates the main base type, usually acting as the sub-`@class` to a multitude of variant types.

- `*.__partial`: Designates a sub-`@class` with extra fields and functions unique to a subset of variant types

- `*.<name>`: Usually designates a variant of some sort.

### Extra annotations
Read about [extra annotations in `GUIDE.md`](https://github.com/corpserot/luanti_lsp_definitions/blob/master/GUIDE.md#extra-annotations). The following further describes how they are written.

- Extra annotation list uses `*` to force a new list (in commonmark) as the `-` is used for regular documentation text above it. Each item must be a single line, just like `@param` and `@field`
- `@see` format:
  - Aside from URL, absolute and relative paths, there is also scoped paths. It's simply just the name of the relevant project as the first part of the path.\
  e.g. `@see [luanti/builtin/common/misc_helpers.lua](luanti git repo link...) this points to a file within Luanti's source code.`\
  e.g. `@see [my_mod/init.lua](mod repo link...) this points to a luanti mod`
  - Sections inside markdown files are referenced with `>` following the heading hierarchy. The hierarchy can be skipped with `>>`.\
  e.g. `@see [luanti/doc/lua_api.md > Helper functions](luanti git repo link...) This points to a section within lua_api.md`\
  e.g. `@see [luanti/doc/lua_api.md > mods >> glTF](luanti git repo link...) This skips some parent headings of glTF`
- Inline keywords require parenthesis around its *italicized* contents and separated by space. A hash `#` can be used to avoid confusing the language server.
  - Exception: inline `@default()` contents is *italicized* except if it only has lua expressions.\
  e.g. @default(`math.huge`)\
  e.g. @default(*`math.random()` seeded with `os.clock()`*)

### Other conventions
Read [Other practices in
`GUIDE.md`](https://github.com/corpserot/luanti_lsp_definitions/blob/master/GUIDE.md#extra-annotations). The following further describes additional conventions used when writing annotations.

- Use `--[[ ... ]]` comment blocks to indicate the documentation text.
  - Requirements below are loose, but consider using `@see` to defer information to the primary sources.
  - It may be up to 32 lines long and at most 80 characters long, not including the brackets.
  - Do not include examples in annotations if it is too long (>8 lines). Use `@see`\
    e.g. `core.LSystemTreeDef` has a 15 line example, thusly it is excluded.
  - You can decide to either copy paste from the primary sources or derives a more concise wording. This library definition is intended to be helpful for experienced developers.
    - Don't be overtly spoonfeeding or hand-holding.
    - You should write things that would be important to consider.

- If a name is not explicitly provided in the primary sources, please derive a sensible name.

- Do not annotate implicit typecasting as valid practice.\
  e.g. (*Rejected*) `number` to `string` automatic casting for `MetaDataRef:set_string(...)` because it uses `luaL_checklstring(...)`

- Do not discard useful return values by annotating `@nodiscard`

- Do not annotate undocumented internal APIs. These APIs shouldn't be exposed in this project as it is out of scope.
  - Exception: Common practices spotted in (usually older) mods and games.
  - Exception: Useful internal APIs. They are tagged with the extra annotation `@internal`.

# Maintenance
## Update checklist
Every time the definition files are updated please check through this list:
1. [Check and test](#checking-and-testing) your modifications.
2. Run through the [`cspell` checker](#spell-checking).
3. Update the commit hash at the top of the `README.md`.
4. Is there a Luanti stable release update? grep for the last release version and update wherever necessary.

## Checking and testing
After updating or adding more complicated symbols, you should test if your annotation appears correctly. Make a temporary Lua project outside of the library definition and play around with related symbols, you don't need to run it in Luanti. You may need to restart LuaLS as you modify annotations.

Another way of checking whether your annotation is correct is to try it out with existing mods and games. This is a bit advanced since you're expected to know how to create your own `.luarc.json` file for that project if it doesn't have one (very common). Perhaps even make a custom definition file for that project due to meddling with engine APIs.

## Looking up the implementation and use of a symbol
Sometimes, the primary sources does not really document the API very well leading to confusion, or that you felt that the primary sources missed something. You will need to search through Luanti's source code for mentions of that symbol. You may use `find`, `grep`, `fzf`, your built-in editor project-wide search, LSP symbols search, etc to ease the work. You'll become more familiar with the codebase as you do this more often, so don't get discouraged!

**EXAMPLE** Let's say you vaguely remember seeing shaped craft recipes passed to `core.register_craft(recipe)` accepting `core.ItemStack`s. Here are some searches you could try to check its implementation:
- `^//.*register_craft` regex in C++ source code files
- `"registered_craft"` regex in C++ source code files
- `function.*register_craft` regex in Lua files under `builtin/*`
- `registered_craft` regex in Lua files under `builtin/*`
- Or any other more specific searches. Reading the code surrounding the results will lead you to a better understanding of the codebase.

## Tracking new Luanti changes
For lazier maintenance, you can check Luanti's `doc` directory git history when tracking down new changes. You should also use the commit from that directory's git history when accounting for *last Luanti commit* instead of the repository as a whole.

Sometimes, there could be API and implementation details outside of `doc` important to annotate. Feel free to defer that work to whoever spots that mistake.

It's recommended that you get familiar with Git, or have tools to help you.

## Spell Checking
For spell checking, [`cspell`](https://cspell.org/) is used. You are encouraged to set it up for your editor or use it as-is.

- With npm, you can run it simply like so `npx cspell path/to/repo`
- For VSCode users, you can use [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
- For Neovim users, you can use [cspell.nvim](https://github.com/davidmh/cspell.nvim). It depend on null-ls/none-ls however.