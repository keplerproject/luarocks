local make = require("luarocks.make")
local test_env = require("new_test/test_environment")
-- local lfs = require("lfs")

describe("LuaRocks #whitebox_make", function()
   it("trivial_test", function()
      assert.are.same(1,1)
   end)
end)

describe("LuaRocks #blackbox_make", function()
   it("trivial_test", function()
      assert.are.same(1,1)
   end)
end)