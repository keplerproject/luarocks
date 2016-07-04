local test_env = require("new_test/test_environment")
local lfs = require("lfs")

test_env.unload_luarocks()
local help = require("luarocks.help")

expose("LuaRocks help tests #blackbox #b_help", function()

   before_each(function()
      test_env.setup_specs(extra_rocks)
      run = test_env.run
   end)

   it("LuaRocks help with no flags/arguments", function()
      assert.is_true(run.luarocks_bool("help"))
   end)

   it("LuaRocks help invalid argument", function()
      assert.is_false(run.luarocks_bool("help invalid"))
   end)
   
   it("LuaRocks help config", function()
      assert.is_true(run.luarocks_bool("help config"))
   end)
   
   it("LuaRocks-admin help with no flags/arguments", function()
      assert.is_true(run.luarocks_admin_bool("help"))
   end)
end)