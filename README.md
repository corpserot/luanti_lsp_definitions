# Luanti LuaLS Definitions
- **Status:** A bit incomplete for Luanti `5.13` and may have mistakes.
- **Last Luanti commit accounted for:** `5ab66da6` (`5.13.X`)
- **Target projects when testing:**
  - [Minetest Game (MTG)](https://github.com/luanti-org/minetest_game) commit `8fbfc14c`\
    With `mtg/.luarc.json` LuaLS config.
  <!-- - [Skyblock: Zero](https://github.com/ChefZander/skyblock_zero) commit `9511788f` -->
  <!-- - [Age of Mending](https://codeberg.org/Age_of_Mending/Age_of_Mending.git) commit `3d12e842` -->
- **Scheduled breaking changes**: Anytime, still in development.

You may want to use the Table of Contents feature on Github or your favourite editor.

# How to use
- Install [Lua Language Server, LuaLS](https://luals.github.io/) for your favourite text editor. Make sure it works first! ^v^
  - For VSCode users, you get first-class support with extra features enabled. So, please visit that site.
  - For Neovim users, you have many ways to configure LuaLS. As of 2025-08-25 there isn't any (easy and simple) LuaLS setup that interactively asks you whether to enable an addon for a workspace/project.
- Manual setup for single library definitions (Recommended for one-off uses):
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
- Manual setup for collection of library definitions (Recommended for multi-library uses):
  - Git clone this repository into this file structure: `luals_addons/luanti-lsp-definitions`. This allows you to add more addons under the same directory, e.g. `luals_addons/busted` for the testing suite.
  - in your LuaLS config, add entries below. The `Apply` value allows the LSP to read library definitions without asking, provided you matched the criteria to enable it.
    ```json
    {
      "workspace.checkThirdParty": "Apply",
      "workspace.userThirdParty": ["/path/to/luals_addons"]
    }
    ```
- Automatic setup for VSCode:
  - Open the Addon Manager with this command: `lua.addon_manager.open` (*Lua: Open Addon Manager...*)
  - Find and install the Luanti library definition
  - The default behaviour is to ask through a notification whenever the criteria matches.

## Using this as a Luanti game/mod developer
After following the above instructions, you are left with two types of dependencies for your game/mod: Annotated dependencies and Un-annotated dependencies
- *Annotated dependencies* and *Un-annotated dependencies* as-is:
  - Game developers simply just include it in their project without any further additions.
  - Mod developers should put it inside a `.gitignore`d directory where you can safely fetch/clone your dependencies without distributing them.
- *Un-annotated dependencies* and you wish to annotate its source code: Both developers should follow the advice above. Then, write your modifications into a separate branch like you are proposing a regular PR to upstream.
- *Un-annotated dependencies* and you wish to annotate a separate library definition: Similar to the above. However, this allows you to write the annotation separately in parallel should upstream refuse to incorporate your work (e.g. they prefer a different tool than LuaLS and don't want to maintain annotation that they don't use).


<!-- TODO split out contributors+maintainer stuff out into a separate file because this is getting too long -->
# Future Work
- update `bundle.sh` and write `bundle.ps1`
- create branch `stable` for the latest stable luanti version.
  - write instructions/tooling for backporting updates
- Write a script that extracts all data from definition files for machine parsing.
  - the work is mainly reshaping the output in both cases.
  - idea: make use of installed LuaLS to generate JSON from definition files.
  - idea: write our own extractor using [emmylua-analyzer-rust](https://github.com/EmmyLuaLs/emmylua-analyzer-rust).
- Replace the current official Luanti LuaLS addon.


# File Structure
- `config.json` is this LuaLS addon configurations file. It should be minimal to encourage the developer to decide their own LuaLS settings.
- `library/*.lua` are definition files related to engine API. There is a short description at the top of each file.
- `MAINTAINENCE.md` is the guide for maintainers and contributors. Please read it if you would like to contribute.


# Questions and Answers
## I'm getting the wrong kind of ObjectRef/PlayerRef! How do i fix this?
TODO unsure if this is necessary. try to make this unnecessary
Because of how closely related these types are, it's expected that you get comfortable with casting using `@as Type` like so:
```lua
core.register_on_punchnode(function(pos, node, puncher)
  if puncher.is_player() then
  else
  end
  puncher = puncher --[[@as ObjectRef]]
end)
```

Or better yet, add an extra definition for functions of your chooseing:
```lua
-- mymod.d.lua
---@param f fun(pos:vector, node:MapNode, puncher:ObjectRef, pointed_thing:pointed_thing):nil
---@return nil
function core.register_on_punchnode(f) end
```

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

## How do i distribute my game/mod's LuaLS configurations?
Good LSP client implementations + UI/UX would allow at least three layers of configurations:
- Personal workspace/project LSP configs e.g. making some diagnostics an error for `minetest_game` instead.
- Upstream workspace/project LSP configs e.g. `minetest_game` would need to disable deprecated diagnostics in the entire project.
- Personal LSP configs e.g. making the LSP quieter by default.

So as a game/mod developer all you need to do is include the `.luarc.json` file in the project root.