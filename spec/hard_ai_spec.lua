local Board = require "board"
local Hard_AI = require "hard_ai"
local Mock_In_Out = require "mock_in_out"
require "telescope"

describe("Hard_AI", function()

  before(function()
    board = Board:new(3)
    mock_in_out = Mock_In_Out:new({})
    mock_gamepiece = "k"
    hard_ai = Hard_AI:new(mock_gamepiece, mock_in_out, board)
  end)

  context("new", function()
    it("initializes a hard_ai with a gamepiece, an in_out object and a board", function()
      assert_equal(mock_gamepiece, hard_ai.gamepiece)
      assert_equal(mock_in_out, hard_ai.in_out)
      assert_equal(board, hard_ai.board)
    end)

    it("initializes an hard_ai with a label", function()
      assert_equal("Computer", hard_ai.label)
    end)
  end)

  context("get_move", function()
    it("writes moves to in_out", function()
      hard_ai:get_move()
      assert_not_nil(mock_in_out.outputs[1])
    end)

    it("returns the best move for a board with 2 available spaces", function()
      hard_ai.board.spaces = { "m", "k", "m",
                               "m", "k", "m",
                               "7", "8", "k" }
      assert_equal(8, hard_ai:get_move())
    end)

    it("returns the best move for a board with 3 available spaces", function()
      hard_ai.board.spaces = { "1", "m", "k",
                               "k", "m", "k",
                               "7", "8", "m" }
      assert_equal(1, hard_ai:get_move())
    end)

    it("returns the best move for a board with 3 available spaces", function()
      hard_ai.board.spaces = { "k", "m", "k",
                               "k", "m", "k",
                               "7", "8", "9" }
      assert_equal(7, hard_ai:get_move())
    end)

    it("returns the best move for a board with 4 available spaces", function()
      hard_ai.board.spaces = { "k", "k", "m",
                               "k", "m", "6",
                               "7", "8", "9" }
      assert_equal(7, hard_ai:get_move())
    end)

    it("returns the best move for a board with 5 available spaces", function()
      hard_ai.board.spaces = { "k", "m", "m",
                               "k", "5", "6",
                               "m", "8", "9" }
      assert_equal(5, hard_ai:get_move())
    end)

    it("returns the best move for a board with 6 available spaces", function()
      hard_ai.board.spaces = { "k", "m", "3",
                               "k", "5", "6",
                               "7", "8", "9" }
      assert_equal(7, hard_ai:get_move())
    end)

    it("returns the best move for a board with 5 available spaces", function()
      hard_ai.board.spaces = { "k", "m", "3",
                               "m", "k", "6",
                               "7", "8", "9" }
      assert_equal(9, hard_ai:get_move())
    end)

    it("returns the best move for a board with 6 available spaces", function()
      hard_ai.board.spaces = { "k", "m", "3",
                               "4", "m", "6",
                               "7", "8", "9" }
      assert_equal(8, hard_ai:get_move())
    end)

    it("returns the best move for a board with 6 available spaces", function()
      hard_ai.board.spaces = { "k", "m", "3",
                               "4", "k", "6",
                               "7", "8", "9" }
      assert_equal(9, hard_ai:get_move())
    end)

    it("returns the best move for a board with 8 available spaces", function()
      hard_ai.board.spaces = { "m", "2", "3",
                               "4", "5", "6",
                               "7", "8", "9" }
      assert_equal(5, hard_ai:get_move())
    end)

    it("returns the best move for a board with 9 available spaces", function()
      hard_ai.board.spaces = { "1", "2", "3",
                               "4", "5", "6",
                               "7", "8", "9" }
      assert_equal(1, hard_ai:get_move())
    end)
  end)
end)

