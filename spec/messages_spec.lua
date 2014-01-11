--TODO:  tests need to test functionality and not actual text.
local inspect = require "inspect"
local messages = require "messages"

describe("messages", function()

  before(function()
    mock_board = {}
    mock_board.spaces = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
    mock_board.size = 3
  end)

  context("build_board", function()
    it("creates the gameboard", function()
      function mock_board.segment() return { { "1", "2", "3" }, { "4", "5", "6" }, { "7", "8", "9" } } end
      local expected_value = "     |     |     \n" ..
                             "  1  |  2  |  3  \n" ..
                             "-----+-----+-----\n" ..
                             "  4  |  5  |  6  \n" ..
                             "-----+-----+-----\n" ..
                             "  7  |  8  |  9  \n" ..
                             "     |     |     \n"
      assert_equal(expected_value, messages.build_board(mock_board))
    end)
  end)

  context("make_move_prompt", function()
    it("instructs the player to make a move", function()
      assert("Please take your next move (enter a number 1 - 9):\n", messages.make_move_prompt(mock_board))
    end)
  end)
end)