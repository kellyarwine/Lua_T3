local In_Out = require "in_out"
require "telescope"

describe("In_Out", function()
  before(function()
    input_filename = "spec/input.txt"
    output_filename = "spec/output.txt"
    in_out = In_Out:new(output_filename, input_filename)
  end)

  context("new", function()
    it("initialized an instance of in_out with a filename when it is passed in", function()
      assert_equal(input_filename, in_out.input_filename)
      assert_equal(output_filename, in_out.output_filename)
    end)

    it("initialized an instance of in_out without a filename when it is not passed in", function()
      local in_out = In_Out:new()
      assert_nil(in_out.input_filename)
      assert_nil(in_out.output_filename)
    end)
  end)

  context("write/read", function()
    it("outputs a message to a file and reads input from a file", function()
      filename = "input_and_output_file.txt"
      local in_out = In_Out:new(filename)
      in_out:write("hi")

      local in_out_2 = In_Out:new(filename, filename)
      assert_equal("hi", in_out_2:read())
      os.remove(filename)
    end)
  end)
end)