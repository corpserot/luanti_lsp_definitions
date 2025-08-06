# Luanti LuaLS Definitions
- **Status:** A bit incomplete for Luanti `5.13` and may have mistakes.
- **Last Luanti commit accounted for:** `5ab66da6` (`5.13.X`)

<!-- cspell:ignore emmylua fgaz luarc nvim burnti -->

# How to use
- Install [Lua Language Server, LuaLS](https://luals.github.io/) for your favourite text editor. Make sure it works first! ^.^
  - For VSCode developers, you get first-class support with extra features enabled. So, please visit that site.
  - For Neovim developers, you may prefer to use [lazydev.nvim](https://github.com/folke/lazydev.nvim) for easier addon/definitions management.
- For manual setup (preferred):
  - Git clone this repository.
  - In your LuaLS config, add entries below. Optionally, manually inject whatever is inside `"settings.Lua"` of this addon's `config.json` into your LuaLS config. That entry contains recommended settings for Luanti game and mod development.
    ```json
    {
      "workspace.library": ["/path/to/luanti-lsp-definitions/library"],
      // e.g. selecting this specifically from "settings.Lua" entry in config.json:
      "diagnostics.disable": [
        "lowercase-global"
      ],
    }
    ```
## Using this as a Luanti game developer
After following the above instructions, you are probably done! You may want to provide your own project-wide LuaLS configs in `.luarc.json`. It is encouraged that you too eventually annotate your own game!

## Using this as a Luanti mod developer
After following the above instructions, you should consider making a directory ignored by git where you can fetch all dependencies including games. LuaLS will treat all files as part of the same global context. If the game provides definitions files, use that instead as you would have better completions! You may want to provide your own project-wide LuaLS configs in `.luarc.json`. It is encouraged that you too eventually annotate your own mod!


# Future Work

- create branch `stable` for the latest stable luanti version.
  - write instructions/tooling for backporting updates
- Write a script that extracts all data from definition files for machine parsing.
  - idea: make use of installed LuaLS to generate JSON from definition files
  - idea: write our own extractor using [emmylua-analyzer-rust](https://github.com/EmmyLuaLs/emmylua-analyzer-rust). the work is mainly reshaping the output into JSON in this case.
- Replace the current official Luanti LuaLS addon.
- (low priority) investigate feasibility using AI to automate tasks (like what??)


# File Structure
- `config.json` is this LuaLS addon configurations file. It should be minimal to encourage the developer to decide their own LuaLS settings.
- `library/*.lua` are definition files related to engine API. There is a short description at the top of each file.
- `mtg/*.lua` are *TEMPORARY* definition files related to *Minetest Game* API. These should be moved to its own separate repository soon. This is ignored by LuaLS unless you explicitly add this directory to `workspace.library` in your LuaLS config.
  - TODO think deeper about the approach of writing definition files for games+mods that refuse supporting LuaCATS or definition files


# Guidelines

You should try to get new information merged into the following places first. These are considered *primary sources*. e.g. You want to clarify that object rotations are actually right-handed. You should make a PR to these repos first.
- <https://github.com/luanti-org/luanti/>, usually something within `doc` directory.
- <https://github.com/luanti-org/docs.luanti.org/>

This project represents yet another place to document the API through annotation. It is expected that this project will have some extra information not suitable for inclusion in the primary sources.

Contributors should get familiar with [LuaCATS, the annotation format](https://luals.github.io/wiki/annotations) used in this project. Also, please read the [**maintenance**](#maintenance) section before beginning your work \:D

When annotating, please follow the conventions below. Additionally deduce conventions from the surrounding and related definitions.
- Mark deprecated or discouraged practices with `@deprecated`.\
  e.g. using `minetest` namespace.

- Implementation details can be intentionally opaque or hidden where useful.\
  e.g. the `number` handle returned by `core.sound_play(...)` is instead annotated as `SoundHandle` class.

- It's *preferred* to maintain the primary sources text verbatim by *appending extra information* instead of modifying it.
  - Nonetheless, it's expected some divergence occurs where it's more useful.
  - Extra information appended will have **`AMENDMENT`** label.
  - Modified primary source text will have **`MODIFIED`** label (very rare).

- For symbols and names not explicitly given in Luanti docs, you should derive a name from engine C++ code, built-in Lua code or your own intuition. Whichever is best.

- Do not annotate implicit typecasting as valid practice.\
  e.g. `number` to `string` automatic casting for `MetaDataRef:set_string(...)` simply because it uses `luaL_checklstring(...)`

- Do not discard these useful return values by annotating `@nodiscard` to discourage bad practices:
  - `success`/`ok` booleans indicating operation success/failure.
  - Instantiation or instances from Constructors
  - Getter functions.

- Do not annotate any internal `builtin/*.lua` APIs. These APIs shouldn't be exposed in this project as it is out of scope.


# Maintenance
To facilitate faster "catching up" for newcomers and future forgetful maintainers, it is recommended to document information related to maintaining this project.

## Update checklist
Every time the definition files are updated please check through this list:
1. [Check and test](#checking-and-testing) your modifications.
2. Run through the [`cspell` checker](#spell-checking).
3. Update the commit hash at the top of the `README.md`.
4. Luanti stable release update? grep for the last release version and update wherever necessary.

## Checking and testing
After updating or adding more complicated symbols, you should test if your annotation appears correctly. Make a temporary Lua file and play around with related symbols, you don't need to run it in Luanti.

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
Sometimes, the primary source does not really document the API very well leading to confusion, or that you felt that the primary source missed something. You will need to search through Luanti's source code for mentions of that symbol. You may use `find`, `grep`, `fzf`, your built-in editor project-wide search, LSP symbols search, etc to ease the work. You'll become more familiar with the codebase as you do this more often, so don't get discouraged!

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
- For VSCode developers, you may use git extensions such as [Git Graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph) and [Git History](https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory)
- For Neovim developers, you may use git plugins such as [neogit](https://github.com/NeogitOrg/neogit) or [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)

## Spell Checking
For spell checking, [`cspell`](https://cspell.org/) is used. You are encouraged to set it up for your editor or use it as-is.

- With npm, you can run it simply like so `npx cspell path/to/repo`
- For VSCode developers, you can use [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
- For Neovim developers, you can use [cspell.nvim](https://github.com/davidmh/cspell.nvim). It depend on null-ls/none-ls however.

<!-- It's not frequently asked, maybe "predicted asked questions, PAQ"? -->
# Questions and Answers
## How do i add new fields to item/node definitions?
You can extend existing classes like so:
```lua
---@class ItemDef
---@field _mymod_rarity integer
```

## Why do some functions force me to declare a variable catching its return value(s), and some don't?
`@nodiscard` is an annotation that forces you to not discard its return. Usually, this is added to ensure that developers won't make mistakes of discarding a return value that's recommended to be handled.

Unfortunately, `@nodiscard` can't be used in methods e.g. `MetaDataRef:get_int(...)`, see [LuaLS#2434](https://github.com/LuaLS/lua-language-server/issues/2434)

## Why not contribute to [`luanti-lls-definitions by @fgaz`](https://codeberg.org/fgaz/luanti-lls-definitions)?
(by @frog) So i tried to use luanti-lls-definitions but those were really incomplete, and i didn't feel like contributing back to them\
And i felt like it would be easier to start from scratch than to attempt to complete them.

(by @corpserot) Well, there's a couple of reasons:
1. first and foremost that project uses an unreliable method to extract information from `lua_api.md` using TCL (seriously??)
2. @fgaz is very inactive in updating the definition files (check commits since project inception). It's very incomplete.
3. It uses EUPL license, which overcomplicates matters as it resembles closer to AGPL-3.0 than LGPL-2.1. It won't deter people that is already set on violating FOSS licenses. We don't use any definitions from that project, obviously.
4. I don't think @fgaz actually uses the definitions themself (dogfooding).

## Why does aliased types suck?
Type aliases are weak types, meaning they resolve to its defined contents and does not preserve much information about itself. This results in a multitude of issues:
- [LuaLS#2284](https://github.com/LuaLS/lua-language-server/issues/2284)
- [LuaLS#2436](https://github.com/LuaLS/lua-language-server/issues/2436), [LuaLS#2378](https://github.com/LuaLS/lua-language-server/issues/2376)
- [LuaLS@2885](https://github.com/LuaLS/lua-language-server/issues/2885)

## Why doesn't LuaCATS/definitions provide more type information?
Compared to more expressive dynamic language type systems like in Typescript or Python type hinting, LuaCATS is a lot simpler. In many cases, we can't express more complicated cases resulting in lost type information. See discussion in [LuaLS#2817](https://github.com/LuaLS/lua-language-server/issues/2817)