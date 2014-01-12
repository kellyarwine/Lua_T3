local Board = require "board"
local Game = require "game"
local inspect = require "inspect"
local messages = require "messages"
local Mock_In_Out = require "mock_in_out"
require "telescope"

describe("Game", function()

  context("setup", function()

    before(function()
      local mock_in_out = Mock_In_Out:new()
      game = Game:new(mock_in_out)
    end)

    it("initializes the board", function()
      assert_not_nil(game.board)
    end)

    it("displays a welcome message", function()
      assert_equal(messages.welcome, game.in_out.outputs[1])
    end)
  end)

  context("play", function()

    before(function ()
      local inputs = { "1", "2", "3" }
      local mock_in_out = Mock_In_Out:new(inputs)
      game = Game:new(mock_in_out)
      board = Board:new(3)
      game:play()
    end)

    it("displays the gameboard", function()
      assert_equal(messages.build_board(board), game.in_out.outputs[2])
    end)

    it("prompts the user to make a move", function()
      assert_equal(messages.make_move_prompt(board), game.in_out.outputs[3])
    end)

    it("loops through the game until there is a win updating the gameboard with the player's move", function()
      assert_arrays_equal({ "x", "x", "x", "4", "5", "6", "7", "8", "9" }, game.board.spaces)
    end)
  end)
end)