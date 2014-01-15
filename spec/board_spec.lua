package.path = package.path .. ";./lib/?.lua;./scripts/?.lua;./spec/mock_in_out.lua"

local Board = require "board"
require "telescope"

describe("Board", function()

  before(function()
    board = Board:new(4)
  end)

  context("new", function()
    it("initializes a board with a size and spaces", function()
      assert_arrays_equal({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16" }, board.spaces)
      assert_equal(4, board.size)
    end)
  end)

  context("segment", function()
    it("segments the array into the gameboard's respective rows, columns and diagonals for a 3 x 3 board", function()
      local three_x_three_board = Board:new(3)
      local expected_segments = { { "1", "2", "3" }, { "4", "5", "6" }, { "7", "8", "9" }, { "1", "4", "7" }, { "2", "5", "8" }, { "3", "6", "9" }, { "1", "5", "9" }, { "3", "5", "7" } }

      for i, segment in ipairs(expected_segments) do
        assert_arrays_equal(segment, three_x_three_board:segment()[i])
      end
    end)
  end)

  context("segment_rows", function()
    it("segments the array into the gameboard's respective rows, columns and diagonals for a 4 x 4 board", function()
      local expected_segments = { { "1", "2", "3", "4" }, { "5", "6", "7", "8" }, { "9", "10", "11", "12" }, { "13", "14", "15", "16" } }

      for i, segment in ipairs(expected_segments) do
        assert_arrays_equal(segment, board:segment()[i])
      end
    end)
  end)

  context("available_spaces", function()
    it("returns empty spaces on the gameboard", function()
      board.spaces = { "1", "x", "x", "x", "x", "x", "7", "8", "9", "10", "11", "x", "x", "x", "15", "16" }
      assert_arrays_equal({ "1", "7", "8", "9", "10", "11", "15", "16" }, board:available_spaces())
    end)

    it("returns an empty table if the board is full", function()
      board.spaces = { "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x", "x" }
      assert_equal(0, #board:available_spaces())
    end)
  end)

  context("reset board", function()
    it("resets the board to be a new gameboard", function()
      board:reset()
      assert_arrays_equal({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16" }, board.spaces)
    end)
  end)
end)