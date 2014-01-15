local In_Out = require "in_out"
require "telescope"

describe("In_Out", function()
  before(function()
    input_filename = "spec/input.txt"
    output_filename = "spec/output.txt"
    in_out = In_Out:new(input_filename, output_filename)
  end)

  context("new", function()
    it("initialized an instance of in_out with an input filename and output filename when passed in", function()
      assert_equal(in_out.input_filename, input_filename)
      assert_equal(in_out.output_filename, output_filename)
    end)

    it("initialized an instance of in_out without filenames when not passed in", function()
      local in_out = In_Out:new()
      assert_nil(in_out.input_filename)
      assert_nil(in_out.output_filename)
    end)
  end)

  context("read", function()
    it("reads input to a file", function()
      local filename = "spec/inputs.txt"
      local in_out = In_Out:new(input_filename)
      assert_equal("3", in_out:read())
      assert_equal("easy ai", in_out:read())
      assert_equal("z", in_out:read())
      assert_equal("easy ai", in_out:read())
      assert_equal("y", in_out:read())
      assert_equal("player 2", in_out:read())
      assert_equal("yes", in_out:read())
      assert_equal("yes", in_out:read())
      assert_equal("5", in_out:read())
    end)
  end)

  context("write", function()
    it("outputs a message to a file and then reads the output from a file", function()
      local in_out_2 = In_Out:new("none", output_filename)
      in_out_2:write("hi")

      local in_out_3 = In_Out:new(output_filename)
      assert_equal("hi", in_out_3:read())
      os.remove(output_filename)
    end)
  end)
end)