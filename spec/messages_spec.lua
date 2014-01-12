--TODO:  tests need to test functionality and not actual text.  Should letters be uppercase?
local inspect = require "inspect"
local messages = require "messages"

describe("messages", function()

  before(function()
    mock_board = {}
    mock_board.size = 3
    mock_board.spaces = { "x", "x", "x", "4", "5", "6", "7", "8", "9" }
  end)

  context("build_board", function()
    it("creates the gameboard", function()
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
    it("instructs the player to make a move", function()
      assert_equal("Please take your next move (enter a number 1 - 9):\n", messages.make_move_prompt(mock_board))
    end)
  end)

  context("game_decision", function()
    it("displays the win message if a game status of win is passed in", function()
      assert_equal(messages.win, messages.game_decision("win"))
    end)

    it("displays the lose message if a game status of lose is passed in", function()
      assert_equal(messages.lose, messages.game_decision("lose"))
    end)

    it("displays the win message if a game status of win is passed in", function()
      assert_equal(messages.cats, messages.game_decision("cats"))
    end)
  end)
end)