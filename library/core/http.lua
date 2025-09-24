---@meta _

--- thought luanti used https :sob:, i thought i could trust it!!
--- Anyway why they are so worried about http api that they are locking it down like this? It's not like http is insecure right? (Get it? because the way you approve mods to use `os.execute` is basically the same process to approving them using the http api... was that joke bad... yeah i know it was)

---@class HTTP_async_handle

-- **DO NOT ALLOW ANY OTHER MODS TO ACCESS THIS TABLE, STORE IT IN A LOCAL VARIABLE!**
---@class HTTPApiTable
-- * `HTTPApiTable.fetch(HTTPRequest req, callback)`
--     * Performs given request asynchronously and calls callback upon completion
--     * callback: `function(HTTPRequestResult res)`
--     * Use this HTTP function if you are unsure, the others are for advanced use
---@field fetch fun(req: HTTPRequest, callback: fun(res: HTTPRequestResult):nil):nil
-- * `HTTPApiTable.fetch_async(HTTPRequest req)`: returns handle
--     * Performs given request asynchronously and returns handle for
--       `HTTPApiTable.fetch_async_get`
---@field fetch_async fun(req:HTTPRequest):HTTP_async_handle
---@field fetch_async_get fun(handle: HTTP_async_handle):HTTPRequestResult

-- * `core.request_http_api()`:
--     * returns `HTTPApiTable` containing http functions if the calling mod has
--       been granted access by being listed in the `secure.http_mods` or
--       `secure.trusted_mods` setting, otherwise returns `nil`.
--     * The returned table contains the functions `fetch`, `fetch_async` and
--       `fetch_async_get` described below.
--     * Only works at init time and must be called from the mod's main scope
--       (not from a function).
--     * Function only exists if Luanti server was built with cURL support.
--     * **DO NOT ALLOW ANY OTHER MODS TO ACCESS THE RETURNED TABLE, STORE IT IN
--       A LOCAL VARIABLE!**
---@return HTTPApiTable?
function core.request_http_api() end
