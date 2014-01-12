package.path = package.path .. ";./lib/?.lua;./scripts/?.lua;./spec/mock_in_out.lua"

require "telescope"
local Board = require "board"

describe("Board", function()

  before(function()
    three_x_three_board_size = 3
    three_x_three_board = Board:new(three_x_three_board_size)
    four_x_four_board_size = 4
    four_x_four_board = Board:new(four_x_four_board_size)
  end)

  context("Board:create_spaces", function()
    it("initializes a board with a size and spaces", function()
      assert_arrays_equal({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, three_x_three_board.spaces)
      assert_equal(three_x_three_board_size, three_x_three_board.size)
    end)
  end)

  --TODO:  tests are probably redundant here now.
  context("segment_row", function()
    it("segments the array into the gameboard's respective rows for a 3x3 board", function()
      local expected_value = { { "1", "2", "3" }, { "4", "5", "6" }, { "7", "8", "9" } }
      for i = 1, three_x_three_board_size do
        assert_arrays_equal(expected_value[i], three_x_three_board:segment_rows()[i])
      end
    end)

    it("segments the array into the gameboard's respective rows for a 4x4 board", function()
      local expected_value = { { "1", "2", "3", "4" }, { "5", "6", "7", "8" }, { "9", "10", "11", "12" }, { "13", "14", "15", "16" } }
      for i = 1, four_x_four_board_size do
        assert_arrays_equal(expected_value[i], four_x_four_board:segment_rows()[i])
      end
    end)
  end)

  context("segment_column", function()
    it("segments the array into the gameboard's respective columns for a 3x3 board", function()
      local expected_value = { { "1", "4", "7" }, { "2", "5", "8" }, { "3", "6", "9" } }
      for i = 1, three_x_three_board_size do
        assert_arrays_equal(expected_value[i], three_x_three_board:segment_columns()[i])
      end
    end)

    it("segments the array into the gameboard's respective columns for a 4x4 board", function()
      local expected_value = { { "1", "5", "9", "13" }, { "2", "6", "10", "14" }, { "3", "7", "11", "15" }, { "4", "8", "12", "16" } }
      for i = 1, four_x_four_board_size do
        assert_arrays_equal(expected_value[i], four_x_four_board:segment_columns()[i])
      end
    end)
  end)

  context("segment_left_diagonal", function()
    it("segments the array into the gameboard's respective left diagonal for a 3x3 board", function()
      local expected_value = { "1", "5", "9" }
      assert_arrays_equal(expected_value, three_x_three_board:segment_left_diagonal())
    end)

    it("segments the array into the gameboard's respective left diagonal for a 4x4 board", function()
      local expected_value = { "1", "6", "11", "16" }
      assert_arrays_equal(expected_value, four_x_four_board:segment_left_diagonal())
    end)
  end)

  context("segment_right_diagonal", function()
    it("segments the array into the gameboard's respective right diagonal for a 3x3 board", function()
      local expected_value = { "3", "5", "7" }
      assert_arrays_equal(expected_value, three_x_three_board:segment_right_diagonal())
    end)

    it("segments the array into the gameboard's respective right diagonal for a 4x4 board", function()
      local expected_value = { "4", "7", "10", "13" }
      assert_arrays_equal(expected_value, four_x_four_board:segment_right_diagonal())
    end)
  end)

  context("segment", function()
    it("segments the array into the gameboard's respective rows, columns and diagonals for a 2x2 board", function()
      board_size = 2
      board = Board:new(board_size)
      local expected_value = { { "1", "2" }, { "3", "4" }, { "1", "3" }, { "2", "4" }, { "1", "4" }, { "2", "3" } }
      for i = 1, board_size * 3 do
        assert_arrays_equal(expected_value[i], board:segment()[i])
      end
    end)
  end)

end)