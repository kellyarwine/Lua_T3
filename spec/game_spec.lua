local Board = require "board"
local Game = require "game"
local inspect = require "inspect"
local messages = require "messages"
local Mock_In_Out = require "mock_in_out"
require "telescope"

describe("Game", function()

  before(function()
    local inputs = { "4" }
    local mock_in_out = Mock_In_Out:new(inputs)
    game = Game:new(mock_in_out)
  end)

  context("setup", function()
    it("initializes the board", function()
      assert_not_nil(game.board)
    end)

    it("displays a welcome message", function()
      assert_equal(messages.welcome, game.in_out.outputs[1])
    end)
  end)

  context("play", function()

    before(function ()
      board = Board:new(3)
      game:play()
    end)

    it("displays the gameboard", function()
      assert_equal(messages.build_board(board), game.in_out.outputs[2])
    end)

    it("prompts the user to make a move", function()
      assert_equal(messages.make_move_prompt(board), game.in_out.outputs[3])
    end)

    it("updates the gameboard with the player's move", function()
      local expected_board = { "1", "2", "3", "x", "5", "6", "7", "8", "9" }
      assert_equal("3", game.board.spaces[3])
      assert_equal("x", game.board.spaces[4])
      assert_equal("5", game.board.spaces[5])
    end)
  end)
end)