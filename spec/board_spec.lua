package.path = package.path .. ";./lib/?.lua;./scripts/?.lua;./spec/mock_in_out.lua"

require "telescope"
local Board = require "board"

describe("Board", function()

  before(function()
    board = Board:new(3)
  end)

  context("new", function()
    it("initializes a board with a size and spaces", function()
      assert_arrays_equal({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, board.spaces)
      assert_equal(3, board.size)
    end)
  end)

  context("segment", function()
    it("segments the array into the gameboard's respective rows, columns and diagonals for a 2x2 board", function()
      local expected_segments = { { "1", "2", "3" }, { "4", "5", "6" }, { "7", "8", "9" }, { "1", "4", "7" }, { "2", "5", "8" }, { "3", "6", "9" }, { "1", "5", "9" }, { "3", "5", "7" } }

      for i, segment in ipairs(expected_segments) do
        assert_arrays_equal(segment, board:segment()[i])
      end
    end)
  end)

  context("available_spaces", function()
    it("returns empty spaces on the gameboard", function()
      board.spaces = { "1", "x", "x", "x", "x", "x", "7", "8", "9" }
      assert_arrays_equal({ "1", "7", "8", "9" }, board:available_spaces())
    end)

    it("returns false if the board is full", function()
      board.spaces = { "x", "x", "x", "x" }
      assert_false(board:has_available_space())
    end)
  end)

  context("has_available_space", function()
    it("returns true if the board has empty spaces", function()
      assert_true(board:has_available_space())
    end)

    it("returns false if the board is full", function()
      board.spaces = { "x", "x", "x", "x" }
      assert_false(board:has_available_space())
    end)
  end)
end)