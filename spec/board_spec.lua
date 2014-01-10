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

  context("segment", function()
    it("segments the array into the gameboard's respective rows for a 3x3 board", function()
      local expected_value = { { "1", "2", "3" }, { "4", "5", "6" }, { "7", "8", "9" } }
      for i = 1, three_x_three_board_size do
        assert_arrays_equal(expected_value[i], three_x_three_board:segment()[i])
      end
    end)

    it("segments the array into the gameboard's respective rows for a 4x4 board", function()
      board_size = 4

      local expected_value = { { "1", "2", "3", "4" }, { "5", "6", "7", "8" }, { "9", "10", "11", "12" }, { "13", "14", "15", "16" } }
      for i = 1, four_x_four_board_size do
        assert_arrays_equal(expected_value[i], four_x_four_board:segment()[i])
      end
    end)
  end)
end)