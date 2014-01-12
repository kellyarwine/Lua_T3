local Board = require "board"
local Game = require "game"
local inspect = require "inspect"
local messages = require "messages"
local Mock_In_Out = require "mock_in_out"
require "telescope"

describe("Game", function()

  before(function()
    local inputs = { "1", "2", "4", "4", "a", "100000000", "3" }
    local mock_in_out = Mock_In_Out:new(inputs)
    game = Game:new(mock_in_out)
    board = Board:new(3)
    game:play()
  end)

  context("new", function()
    it("initializes an instance of game with the in_out instance that is passed in", function()
      local mock_in_out = Mock_In_Out:new()
      local game = Game:new(mock_in_out)
      assert_arrays_equal(mock_in_out, game.in_out)
    end)
  end)

  context("setup", function()
    it("initializes a board", function()
      assert_not_nil(game.board)
    end)

    it("displays a welcome message", function()
      assert_equal(messages.welcome, game.in_out.outputs[1])
    end)
  end)

  context("play", function()
    it("displays the gameboard", function()
      local function build_board_from_spaces(spaces) board.spaces = spaces return messages.build_board(board) end

      assert_equal(build_board_from_spaces({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }), game.in_out.outputs[2])
      assert_equal(build_board_from_spaces({ "x", "2", "3", "4", "5", "6", "7", "8", "9" }), game.in_out.outputs[4])
      assert_equal(build_board_from_spaces({ "x", "x", "3", "4", "5", "6", "7", "8", "9" }), game.in_out.outputs[6])
      assert_equal(build_board_from_spaces({ "x", "x", "3", "x", "5", "6", "7", "8", "9" }), game.in_out.outputs[8])
      assert_equal(build_board_from_spaces({ "x", "x", "x", "x", "5", "6", "7", "8", "9" }), game.in_out.outputs[16])
    end)

    it("prompts the user to make a move", function()
      assert_equal(messages.make_move_prompt(board), game.in_out.outputs[3])
      assert_equal(messages.make_move_prompt(board), game.in_out.outputs[5])
      assert_equal(messages.make_move_prompt(board), game.in_out.outputs[7])
      assert_equal(messages.make_move_prompt(board), game.in_out.outputs[9])
      assert_equal(messages.make_move_prompt(board), game.in_out.outputs[11])
      assert_equal(messages.make_move_prompt(board), game.in_out.outputs[13])
      assert_equal(messages.make_move_prompt(board), game.in_out.outputs[15])
    end)

    it("displays an invalid selection message when an already-occupied space is input as a move", function()
      assert_equal(messages.invalid_selection, game.in_out.outputs[10])
    end)

    it("displays an invalid selection message when a letter is input as a move", function()
      assert_equal(messages.invalid_selection, game.in_out.outputs[12])
    end)

    it("displays an invalid selection message when a number outside of the board range is input as a move", function()
      assert_equal(messages.invalid_selection, game.in_out.outputs[12])
    end)

    it("loops through the game updating the gameboard with the player's move", function()
      board = Board:new(3)
      assert_arrays_equal({ "x", "x", "x", "x", "5", "6", "7", "8", "9" }, game.board.spaces)
    end)

    it("displays a win message", function()
      assert_equal(messages.win, game.in_out.outputs[17])
    end)

    it("prompts the user to play again", function()
      assert_equal(messages.play_again_prompt, game.in_out.outputs[18])
    end)
  end)
end)