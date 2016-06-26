local remove = require("luarocks.remove")
local test_env = require("new_test/test_environment")
local lfs = require("lfs")

local extra_rocks = {
   "/abelhas-1.0-1.rockspec",
   "/lualogging-1.3.0-1.src.rock",
   "/luasocket-3.0rc1-1.src.rock",
   "/luasocket-3.0rc1-1.rockspec"
}

expose("LuaRocks remove tests #blackbox #b_remove", function()   
   before_each(function()
      test_env.setup_specs(extra_rocks)
      testing_paths = test_env.testing_paths
      run = test_env.run
   end)

   describe("LuaRocks remove basic tests", function()
      it("LuaRocks remove with no flags/arguments", function()
         assert.is_false(run.luarocks_bool("remove"))
      end)

      it("LuaRocks remove invalid rock", function()
         assert.is_false(run.luarocks_bool("remove invalid.rock"))
      end)
      
      it("LuaRocks remove missing rock", function()
         assert.is_false(run.luarocks_bool("remove missing_rock"))
      end)
      
      it("LuaRocks remove invalid argument", function()
         assert.is_false(run.luarocks_bool("remove luacov --deps-mode"))
      end)

      it("LuaRocks remove builded abelhas", function()
         assert.is_true(run.luarocks_bool("build abelhas 1.0"))
         assert.is.truthy(lfs.attributes(testing_paths.testing_sys_tree .. "/lib/luarocks/rocks/abelhas"))
         assert.is_true(run.luarocks_bool("remove abelhas 1.0"))
         assert.is.falsy(lfs.attributes(testing_paths.testing_sys_tree .. "/lib/luarocks/rocks/abelhas"))
      end)
   end)

   describe("LuaRocks remove more complex tests", function()
      it("LuaRocks remove fail, break dependencies", function()
         assert.is_true(test_env.need_luasocket())
         assert.is.truthy(lfs.attributes(testing_paths.testing_sys_tree .. "/lib/luarocks/rocks/luasocket"))
         assert.is_true(run.luarocks_bool("build lualogging"))

         assert.is_false(run.luarocks_bool("remove luasocket"))
         assert.is.truthy(lfs.attributes(testing_paths.testing_sys_tree .. "/lib/luarocks/rocks/luasocket"))
      end)
      
      it("LuaRocks remove force", function()
         assert.is_true(test_env.need_luasocket())
         assert.is.truthy(lfs.attributes(testing_paths.testing_sys_tree .. "/lib/luarocks/rocks/luasocket"))
         assert.is_true(run.luarocks_bool("build lualogging"))

         local output = run.luarocks("remove --force luasocket")
         assert.is.falsy(lfs.attributes(testing_paths.testing_sys_tree .. "/lib/luarocks/rocks/luasocket"))
         assert.is.truthy(output:find("Checking stability of dependencies"))
      end)
      
      it("LuaRocks remove force fast", function()
         assert.is_true(test_env.need_luasocket())
         assert.is.truthy(lfs.attributes(testing_paths.testing_sys_tree .. "/lib/luarocks/rocks/luasocket"))
         assert.is_true(run.luarocks_bool("build lualogging"))

         local output = run.luarocks("remove --force-fast luasocket")
         assert.is.falsy(lfs.attributes(testing_paths.testing_sys_tree .. "/lib/luarocks/rocks/luasocket"))
         assert.is.falsy(output:find("Checking stability of dependencies"))
      end)
   end)
end)