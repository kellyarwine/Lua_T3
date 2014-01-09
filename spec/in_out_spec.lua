local In_Out = require "in_out"
require "telescope"

describe("In_Out", function()

  local contexts

  context("write to and read from a file", function()
    it("outputs a message and reads input", function()
      in_out = In_Out:new("stdout.txt")
      in_out:write("hi")
      content = in_out:read()
      assert_equal("hi", content)
      os.remove("stdout.txt")
      --not sure if I need these??
      -- io.output(io.stdout)
      -- io.input(io.stdin)
    end)
  end)
end)