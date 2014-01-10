local Game = require "game"
local inspect = require "inspect"
local messages = require "messages"
local Mock_In_Out = require "mock_in_out"
require "telescope"

describe("Game", function()

  before(function()
    local inputs = { "a" }
    local mock_in_out = Mock_In_Out:new(inputs)
    game = Game:new(mock_in_out)
  end)

  context("setup", function()
    it("initializes the board", function()
      assert_not_nil(game.board)
    end)
  end)

  context("play", function()

    before(function ()
      game:play()
    end)

    it("displays a welcome message", function()
      assert_equal(messages.welcome, game.in_out.outputs[1])
    end)

    it("displays the board spaces", function()
      local expected_value = "     |     |     \n" ..
                             "  1  |  2  |  3  \n" ..
                             "-----+-----+-----\n" ..
                             "  4  |  5  |  6  \n" ..
                             "-----+-----+-----\n" ..
                             "  7  |  8  |  9  \n" ..
                             "     |     |     \n"
      assert_equal(expected_value, game.in_out.outputs[2])
    end)

    it("reads a player's move", function()
      assert_equal("This is the user's move: a", game.in_out.outputs[3])
    end)
  end)
end)