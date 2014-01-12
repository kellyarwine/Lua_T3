require "telescope"
local Easy_AI_Player = require "easy_ai_player"

describe("Easy_AI_Player", function()

  before(function()
    mock_board = {}
    mock_board.spaces = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
    easy_ai_player = Easy_AI_Player:new("x", mock_board)
  end)

  context("new", function()
    it("initializes an easy_ai_player with a gamepiece and a board", function()
      assert_equal("x", easy_ai_player.gamepiece)
      assert_equal(mock_board, easy_ai_player.board)
    end)
  end)

  context("get_move", function()
    it("returns a random number less than or equaled to the number of board spaces", function()
      for i = 1, 1000 do
        assert_true(easy_ai_player:get_move() <= #mock_board.spaces)
      end
    end)

    it("returns a random number insomuch that each space on the board is called in equal distribution", function()
      local results = { ["1"] = 0, ["2"] = 0, ["3"] = 0, ["4"] = 0, ["5"] = 0, ["6"] = 0, ["7"] = 0, ["8"] = 0, ["9"] = 0 }

      for i = 1, 1000 do
        local move = tostring(easy_ai_player:get_move())
        results[move] = results[move] + 1
      end

      for k, v in pairs(results) do
        assert_less_than(v/1000, .20)
      end
    end)
  end)
end)