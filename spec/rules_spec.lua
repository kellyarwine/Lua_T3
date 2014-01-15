local rules = require "rules"
require "telescope"

describe("Rules", function()

  before(function()
    mock_board = {}
  end)

  context("winning_gamepiece", function()
    it("returns the winning gamepiece if any row, column or diagonal is a win", function()
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "x", "x"} } end
      assert_equal("x", rules.winning_gamepiece(mock_board))
    end)

    it("returns nil if no row, column or diagonal is a win", function()
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "y", "x"} } end
      assert_nil(rules.winning_gamepiece(mock_board))
    end)
  end)

  context("game_over", function()
    it("returns true if the game is won and there are available spaces", function()
      function mock_board.available_spaces() return { "1" } end
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "x", "x"} } end
      assert_true(rules.is_game_over(mock_board))
    end)

    it("returns true if there are no more available spaces and the game is not won", function()
      function mock_board.available_spaces() return {} end
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "y", "x"} } end
      assert_true(rules.is_game_over(mock_board))
    end)

    it("returns false if there are available spaces and the game is not won", function()
      function mock_board.available_spaces() return { "1" } end
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "y", "x"} } end
      assert_false(rules.is_game_over(mock_board))
    end)
  end)

  context("game_decision", function()
    it("returns 'win' if the game is won", function()
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "x", "x"} } end
      local decision, winning_gamepiece = rules.get_game_decision(mock_board)
      assert_equal("win", decision)
      assert_equal("x", winning_gamepiece)
    end)

    it("returns 'cats' if no player has won", function()
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "y", "x"} } end
      assert_equal("cats", rules.get_game_decision(mock_board))
    end)
  end)
end)