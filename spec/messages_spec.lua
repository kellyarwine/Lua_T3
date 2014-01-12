--TODO:  Should letters be uppercase?
local inspect = require "inspect"
local messages = require "messages"

describe("messages", function()

  before(function()
    mock_board = {}
    mock_board.size = 3
    mock_board.spaces = { "x", "x", "x", "4", "5", "6", "7", "8", "9" }
  end)

  context("build_board", function()
    it("outputs a constructed gameboard", function()
      function mock_board.segment_rows() return { { "x", "x", "x" }, { "4", "5", "6" }, { "7", "8", "9" } } end
      local expected_value = "     |     |     \n" ..
                             "  x  |  x  |  x  \n" ..
                             "-----+-----+-----\n" ..
                             "  4  |  5  |  6  \n" ..
                             "-----+-----+-----\n" ..
                             "  7  |  8  |  9  \n" ..
                             "     |     |     \n"
      assert_equal(expected_value, messages.build_board(mock_board))
    end)
  end)

  context("make_move_prompt", function()
    it("instructs the player to make a move displaying the minimum and maximum values that can be input", function()
      assert_equal("Please make your next move (enter a number 1 - 9):\n", messages.make_move_prompt(mock_board))
    end)
  end)
end)