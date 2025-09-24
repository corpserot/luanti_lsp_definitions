---@meta _
-- DRAFT 1 WIP
-- lua_api.md: Translations

---@alias textdomain string

--[[
`core.get_translator(textdomain)` is a simple wrapper around
`core.translate` and `core.translate_n`.
After `local S, PS = core.get_translator(textdomain)`, we have
`S(str, ...)` equivalent to `core.translate(textdomain, str, ...)`, and
`PS(str, str_plural, n, ...)` to `core.translate_n(textdomain, str, str_plural, n, ...)`.
It is intended to be used in the following way, so that it avoids verbose
repetitions of `core.translate`:

```lua
local S, PS = core.get_translator(textdomain)
S(str, ...)
```

As an extra commodity, if `textdomain` is nil, it is assumed to be "" instead.
]]
---@nodiscard
---@param textdomain textdomain|nil
---@return fun(str:string, ...:string):string S, fun(str:string, str_plural:string, n:number, ...:string):string PS
function core.get_translator(textdomain) end

--[[
* `core.translate(textdomain, str, ...)` translates the string `str` with
  the given `textdomain` for disambiguation. The textdomain must match the
  textdomain specified in the translation file in order to get the string
  translated. This can be used so that a string is translated differently in
  different contexts.
  It is advised to use the name of the mod as textdomain whenever possible, to
  avoid clashes with other mods.
  This function must be given a number of arguments equal to the number of
  arguments the translated string expects.
  Arguments are literal strings -- they will not be translated.
]]
---@nodiscard
---@param textdomain textdomain
---@param str string
---@param ... string
function core.translate(textdomain, str, ...) end

-- cspell:disable
--[[
* `core.translate_n(textdomain, str, str_plural, n, ...)` translates the
  string `str` with the given `textdomain` for disambiguation. The value of
  `n`, which must be a nonnegative integer, is used to decide whether to use
  the singular or the plural version of the string. Depending on the locale of
  the client, the choice between singular and plural might be more complicated,
  but the choice will be done automatically using the value of `n`.

  You can read https://www.gnu.org/software/gettext/manual/html_node/Plural-forms.html
  for more details on the differences of plurals between languages.

  Also note that plurals are only handled in .po or .mo files, and not in .tr files.


For instance, suppose we want to greet players when they join and provide a
command that shows the amount of time since the player joined. We can do the
following:

```lua
local S, PS = core.get_translator("hello")
core.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    core.chat_send_player(name, S("Hello @1, how are you today?", name))
end)
core.register_chatcommand("playtime", {
    func = function(name)
        local last_login = core.get_auth_handler().get_auth(name).last_login
        local playtime = math.floor((last_login-os.time())/60)
        return true, PS(
            "You have been playing for @1 minute.",
            "You have been playing for @1 minutes.",
            minutes, tostring(minutes))
    end,
})

```
When someone called "CoolGuy" joins the game with an old client or a client
that does not have localization enabled, they will see `Hello CoolGuy, how are
you today?`. If they use the `/playtime` command, they will see `You have been
playing for 1 minute` or (for example) `You have been playing for 4 minutes.`

However, if we have for instance a translation file named `hello.de.po`
containing the following:

```po
msgid ""
msgstr ""
"Plural-Forms: nplurals=2; plural=(n != 1);\n"

msgid "Hello @1, how are you today?"
msgstr "Hallo @1, wie geht es dir heute?"

msgid "You have been playing for @1 minute."
msgid_plural "You have been playing for @1 minutes."
msgstr[0] "Du spielst seit @1 Minute."
msgstr[1] "Du spielst seit @1 Minuten."
```

and CoolGuy has set a German locale, they will see `Hallo CoolGuy, wie geht es
dir heute?` when they join, and the `/playtime` command will show them `Du
spielst seit 1 Minute.` or (for example) `Du spielst seit 4 Minuten.`
]]
-- cspell:enable
---@nodiscard
---@param textdomain textdomain
---@param str string
---@param str_plural string
---@param n number
---@param ... string
function core.translate_n(textdomain, str, str_plural, n, ...) end

--[[
On some specific cases, server translation could be useful. For example, filter
a list on labels and send results to client. A method is supplied to achieve
that:

`core.get_translated_string(lang_code, string)`: resolves translations in
the given string just like the client would, using the translation files for
`lang_code`. For this to have any effect, the string needs to contain translation
markup, e.g. `core.get_translated_string("fr", S("Hello"))`.

The `lang_code` to use for a given player can be retrieved from
the table returned by `core.get_player_information(name)`.

IMPORTANT: This functionality should only be used for sorting, filtering or similar purposes.
You do not need to use this to get translated strings to show up on the client.
]]
---@param lang_code string
---@param str string
---@return string
function core.get_translated_string(lang_code, str) end