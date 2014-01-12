require "telescope"
local utils = require "utils"

describe("Utils Module", function()

  context("map", function()
    it("throws an error if a function and table are not passed in, respectively", function()
      assert_error(utils.map)
    end)

    it("applies a function to each element in a table", function()
      local actual_result_table  = utils.map(type, { "5", 5, "data" })
      local actual_result        = table.concat(actual_result_table, " ")
      assert_equal("string number string", actual_result)
    end)
  end)

  context("multiply_string", function()
    it("throws an error if a string and number are not passed in, respectively", function()
      assert_error(utils.multiply_string)
    end)

    it("returns a string a specified number of times", function()
      assert_equal("aaaaa", utils.multiply_string("a", 5))
    end)
  end)

end)