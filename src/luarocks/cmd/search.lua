
--- Module implementing the LuaRocks "search" command.
-- Queries LuaRocks servers.
local cmd_search = {}

local cfg = require("luarocks.core.cfg")
local util = require("luarocks.util")
local search = require("luarocks.search")

cmd_search.help_summary = "Query the LuaRocks servers."
cmd_search.help_arguments = "[--source] [--binary] { <name> [<version>] | --all }"
cmd_search.help = [[
--source     Return only rockspecs and source rocks,
             to be used with the "build" command.
--binary     Return only pure Lua and binary rocks (rocks that can be used
             with the "install" command without requiring a C toolchain).
--all        List all contents of the server that are suitable to
             this platform, do not filter by name.
--porcelain  Return a machine readable format.
]]

--- Splits a list of search results into two lists, one for "source" results
-- to be used with the "build" command, and one for "binary" results to be
-- used with the "install" command.
-- @param results table: A search results table.
-- @return (table, table): Two tables, one for source and one for binary
-- results.
local function split_source_and_binary_results(results)
   local sources, binaries = {}, {}
   for name, versions in pairs(results) do
      for version, repositories in pairs(versions) do
         for _, repo in ipairs(repositories) do
            local where = sources
            if repo.arch == "all" or repo.arch == cfg.arch then
               where = binaries
            end
            search.store_result(where, name, version, repo.arch, repo.repo)
         end
      end
   end
   return sources, binaries
end

--- Driver function for "search" command.
-- @param name string: A substring of a rock name to search.
-- @param version string or nil: a version may also be passed.
-- @return boolean or (nil, string): True if build was successful; nil and an
-- error message otherwise.
function cmd_search.command(flags, name, version)
   if flags["all"] then
      name, version = "", nil
   end

   if type(name) ~= "string" and not flags["all"] then
      return nil, "Enter name and version or use --all. "..util.see_help("search")
   end
   
   local query = search.make_query(name:lower(), version)
   query.exact_name = false
   local results, err = search.search_repos(query)
   local porcelain = flags["porcelain"]
   local full_name = name .. (version and " " .. version or "")
   util.title(full_name .. " - Search results for Lua "..cfg.lua_version..":", porcelain, "=")
   local sources, binaries = split_source_and_binary_results(results)
   if next(sources) and not flags["binary"] then
      util.title("Rockspecs and source rocks:", porcelain)
      search.print_results(sources, porcelain)
   end
   if next(binaries) and not flags["source"] then    
      util.title("Binary and pure-Lua rocks:", porcelain)
      search.print_results(binaries, porcelain)
   end
   return true
end

return cmd_search
