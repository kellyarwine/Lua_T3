local Mock_In_Out = require "mock_in_out"
require "telescope"

describe("Mock_In_Out", function()

  before(function()
    inputs = { "howdy", "hola" }
    mock_in_out = Mock_In_Out:new(inputs)
  end)

  context("new", function()
    it("initializes a mock object with an empty table for outputs and the inputs passed in", function()
      assert_arrays_equal(inputs, mock_in_out.inputs)
      assert_arrays_equal({}, mock_in_out.outputs)
    end)
  end)

  context("write", function()
    it("stores messages intended to be written to the console", function()
      mock_in_out:write("Hey y'all!")
      mock_in_out:write("Sup?")
      assert_arrays_equal({ "Hey y'all!", "Sup?" }, mock_in_out.outputs)
    end)
  end)

  context("read", function()
    it("returns input values from the pre-configured input values passed in (one input for each read)", function()
      assert_equal("howdy", mock_in_out:read())
      assert_equal("hola", mock_in_out:read())
    end)
  end)
end)