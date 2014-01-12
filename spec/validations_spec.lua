local inspect = require "inspect"
local validations = require "validations"

describe("validations", function()

  before(function()
    mock_board = {}
    mock_board.size = 3
    mock_board.spaces = { "x", "2", "x", "4", "x", "6", "x", "8", "x" }
  end)

  context("is_valid_move", function()
    it("returns false when the move is not valid", function()
      assert_false(validations.is_valid_move(mock_board, "a"))
      assert_false(validations.is_valid_move(mock_board, "qu"))
      assert_false(validations.is_valid_move(mock_board, "."))
      assert_false(validations.is_valid_move(mock_board, 1))
      assert_false(validations.is_valid_move(mock_board, 9))
      assert_false(validations.is_valid_move(mock_board, 11))
      assert_false(validations.is_valid_move(mock_board, 10000000000))
      assert_false(validations.is_valid_move(mock_board, nil))
    end)

    it("returns true when the move is valid", function()
      assert_true(validations.is_valid_move(mock_board, 2))
    end)
  end)
end)
