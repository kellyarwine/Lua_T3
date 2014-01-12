local game_rules = require "game_rules"
local inspect = require "inspect"
require "telescope"

describe("Game Rules", function()

  before(function()
    mock_board = {}
  end)

  context("winning_gamepiece", function()
    it("returns the winning gamepiece if any game segment is a win", function()
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "x", "x"} } end
      assert_equal("x", game_rules.winning_gamepiece(mock_board))
    end)

    it("returns nil if no game segment is a win", function()
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "y", "x"} } end
      assert_nil(game_rules.winning_gamepiece(mock_board))
    end)
  end)

  context("game_over", function()
    it("returns true if the game is won and there are available spaces", function()
      function mock_board.has_available_space() return true end
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "x", "x"} } end
      assert_true(game_rules.is_game_over(mock_board))
    end)

    it("returns true if there are no more available spaces and the game is not won", function()
      function mock_board.has_available_space() return false end
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "y", "x"} } end
      assert_true(game_rules.is_game_over(mock_board))
    end)

    it("returns false if there are available spaces and the game is not won", function()
      function mock_board.has_available_space() return true end
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "y", "x"} } end
      assert_false(game_rules.is_game_over(mock_board))
    end)
  end)

  context("game_decision", function()
    it("returns win if the game is won", function()
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "x", "x"} } end
      assert_equal("win", game_rules.get_game_decision(mock_board))
    end)

    it("returns draw if the game is not won", function()
      function mock_board.segment() return { {"x", "y", "x"}, {"x", "y", "x"} } end
      assert_equal("cats", game_rules.get_game_decision(mock_board))
    end)
  end)
end)