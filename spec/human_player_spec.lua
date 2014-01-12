require "telescope"
local Human_Player = require "human_player"
local Mock_In_Out = require "mock_in_out"

describe("Human_Player", function()

  before(function()
    local inputs = { "5" }
    mock_in_out = Mock_In_Out:new(inputs)
    human_player = Human_Player:new("x", mock_in_out)
  end)

  context("new", function()
    it("initializes a human_player with an in_out and a gamepiece", function()
      assert_equal("x", human_player.gamepiece)
      assert_equal(mock_in_out, human_player.in_out)
    end)
  end)

  context("get_move", function()
    it("returns the number input from a player", function()
      assert_equal(5, human_player:get_move())
    end)
  end)
end)