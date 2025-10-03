# Luanti LuaLS Definitions
- **Status:** DRAFT 2 WIP (see [issue#6](https://github.com/corpserot/luanti_lsp_definitions/issues/6))
- **Luanti commit coverage:** `421835a3` (`5.14.X`)
- **Target projects when testing:**
  - [Minetest Game (MTG)](https://github.com/luanti-org/minetest_game) commit `ac2bc0f5`\
    With a custom LuaLS config (To be published).
- **Scheduled breaking changes**: Anytime, still in development.
<!--
  - This follows Luanti's minor releases, meaning we will schedule a breaking release when the target minor release is published.
  - Breaking changes matters for writing annotations on top of library definition. Otherwise, it's inconsequential meaning you don't have to care about this if you merely want type checking.
  - All changes, breaking or otherwise, are recorded in `CHANGELOG.md`
-->

# Why use this?
This library definition enables a lua language server to operate with Luanti APIs and types. This in turn allows for IDE-like capabilities including but not limited to:
- Typed annotation system called LuaCATS a la JSDoc annotations. In this case, this project uses definition files similar to Typescript definition files.
- Diagnostics through semantic analysis, replacing [luacheck](https://github.com/mpeterv/luacheck) completely.
- Autocompletion and hover information for API symbols, types, fields and more.

# How to use?
- Install [Lua Language Server, LuaLS](https://luals.github.io/) or [EmmyLua](https://github.com/EmmyLuaLs/emmylua-analyzer-rust) for your favourite text editor. Make sure it works first! ^v^
  - For VSCode users, you get first-class support with extra features enabled. So, please visit relevant first-party guides.
  - For Neovim users, you have many ways to configure your language server. As of 2025-08-25 there isn't any (easy and simple) setup that interactively asks you whether to enable an addon for a workspace/project.
  - For EmmyLua users, you may encounter some issues as this project prioritises LuaLS.
- Manual setup for single library definitions (Recommended for one-off uses):
  - Git clone this repository.
  - In your personal project config, add entries below. Optionally, manually inject whatever is inside `config.json` > `"settings"` into your LuaLS config. That entry contains recommended settings for Luanti game and mod development.
    ```json
    {
      "workspace.library": ["/path/to/luanti-lsp-definitions/library"],
      // e.g. selecting this specifically from "settings.Lua" entry in config.json:
      "diagnostics.disable": [
        "lowercase-global"
      ],
    }
    ```

Please read the friendly [`GUIDE.md`](https://github.com/corpserot/luanti_lsp_definitions/blob/master/GUIDE.md) as this library definition has some unique interpretations and conventions you should be aware of.

# Acknowledgements
There are a couple projects that was developed with similar ideas that I remember seeing. I would like to show my appreciation for their efforts with this simple acknowledgement. Note that this project only look at Luanti's source code along with its documents, meaning I don't use any information elsewhere. Please don't bother me about the stricter licensing from some of these other projects.

- [luanti_lsp_definitions](https://github.com/TheEt1234/luanti_lsp_definitions) by TheEt1234. The direct ancestor of this project. Licensed 0BSD, but it mixed in LGPLv2.1 contents from Luanti. Thusly, it would have been LGPLv2.1.
- [Typescript-to-lua](https://typescripttolua.github.io/) approach by jordan4ibanez in his game, [Crafter](https://github.com/jordan4ibanez/crafter). The Luanti API is defined in [`minetest-api.d.ts`](https://github.com/jordan4ibanez/crafter/blob/main/minetest-api.d.ts) Perhaps the most developed typed representation of Luanti API before this project. Licensed GPLv3.
- [luanti-lls-definitions](https://codeberg.org/fgaz/luanti-lls-definitions) by fgaz introduced me to LuaCATS. Licensed EUPLv1.2-or-later.
- [luanti-api](https://git.minetest.land/archie/luanti-api/) by archie. Licensed GPLv3.

# Quick Q&A
## Can i use Luacheck with this?
No.

## Can i use LuaDoc/LDoc with this?
No. You should use the language server's documentation generator instead ([LuaLS](https://luals.github.io/wiki/export-docs/)) ([EmmyLua](https://github.com/EmmyLuaLs/emmylua-analyzer-rust/tree/main/crates/emmylua_doc_cli))

## Should I use [Luanti Tools VSCode(ium) extension](https://marketplace.visualstudio.com/items?itemName=GreenXenith.minetest-tools) together with this?
Probably wait until the developer (GreenXenith) is made aware about this project. There's no reason it wouldn't work however.

## If i use this, do i have to use a LGPL-compliant license for my game/mod?
***Disclaimer: I am not a lawyer, and nothing in this material should be taken as legal advice. It may even be inaccurate. No attorney–client relationship is created by your use of this information provided for informative purposes. You should not act or rely on any information provided here without seeking the advice of a qualified attorney licensed in your jurisdiction. I disclaim all liability for actions you take or fail to take based on any content provided.***

You may skip this if you're well-informed about copyleft software licenses.

The answer is very unlikely... well, it depends. You can embed or use this library definition alongside your game/mod. However, please don't copy-paste contents of this library definition straight into your code. Particularly, the documentation text itself has to be treated a bit more carefully.

**Example:** Person A wrote a mod with a permissive license like MIT or 0BSD. If person A carelessly include content of this library definition into the mod's `init.lua`, then a portion of that file is at risk of being subjected to LGPL terms due to documentation text.

If you would like to modify or derive contents of this library definition, it's recommended to treat your derived work like a separate module from your game/mod. It could be simply a separate directory or file.

**Example:** Person A, being careful this time, copy-pastes parts of this library definition into a separate definition file `.defs.lua`. This would help isolate where LGPL terms apply.