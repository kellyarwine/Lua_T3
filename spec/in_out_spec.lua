local In_Out = require "in_out"
require "telescope"

describe("In_Out", function()
  context("new", function()
    it("initialized an instance of in_out with a filename when it is passed in", function()
      local in_out = In_Out:new("test.txt")
      assert_equal("test.txt", in_out.i_o_filename)
    end)

    it("initialized an instance of in_out without a filename when it is not passed in", function()
      local in_out = In_Out:new()
      assert_nil(in_out.i_o_filename)
    end)
  end)

  context("write/read", function()
    it("outputs a message to a file and reads input from a file", function()
      local filename = "stdout.txt"
      local in_out = In_Out:new(filename)
      in_out:write("hi")
      assert_equal("hi", in_out:read())
      os.remove(filename)
    end)
  end)
end)