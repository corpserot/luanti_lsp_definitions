---@meta

--- thought luanti used https :sob:, i thought i could trust it!!
--- Anyway why they are so worried about http api that they are locking it down like this? It's not like http is insecure right? (Get it? because the way you approve mods to use `os.execute` is basically the same process to approving them using the http api... was that joke bad... yeah i know it was)

---@class HTTP_async_handle

---@class HTTPRequest
---@field url string?
-- Timeout for request to be completed in seconds. Default depends on engine settings.
---@field timeout number?
-- The http method to use. Defaults to "GET".
---@field method "GET"|"HEAD"|"POST"|"PUT"|"PATCH"|"DELETE"?
-- Data for the POST, PUT, PATCH or DELETE request.
-- Accepts both a string and a table. If a table is specified, encodes
-- table as x-www-form-urlencoded key-value pairs.
---@field data string|table<string,string>?
-- Optional, if specified replaces the default Luanti user agent with
-- given string.
---@field user_agent string?
-- Optional, if specified adds additional headers to the HTTP request.
-- You must make sure that the header strings follow HTTP specification
-- ("Key: Value").
---@field extra_headers string[]?
-- Optional, if true performs a multipart HTTP request.
-- Default is false.
-- Not allowed for GET or HEAD method and `data` must be a table.
---@field multipart boolean?

---@class HTTPRequestResult
-- If true, the request has finished (either succeeded, failed or timed
-- out)
---@field completed boolean?
-- If true, the request was successful
---@field succeeded boolean?
-- If true, the request timed out
---@field timeout boolean?
-- HTTP status code
---@field code number?
-- Response body
---@field data string?

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
