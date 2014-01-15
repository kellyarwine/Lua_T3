local Human = require "human"
local Mock_In_Out = require "mock_in_out"
require "telescope"

describe("Human", function()

  before(function()
    local inputs = { "5" }
    mock_in_out = Mock_In_Out:new(inputs)
    human = Human:new("x", mock_in_out)
  end)

  context("new", function()
    it("initializes a human with an in_out and a gamepiece (the board object is not used)", function()
      assert_equal("x", human.gamepiece)
      assert_equal(mock_in_out, human.in_out)
    end)

    it("initializes a human with a label", function()
      assert_equal("Human", human.label)
    end)
  end)

  context("get_move", function()
    it("returns the number input from a player", function()
      assert_equal(5, human:get_move())
    end)
  end)
end)