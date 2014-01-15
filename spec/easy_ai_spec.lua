local Easy_AI = require "easy_ai"
local Mock_In_Out = require "mock_in_out"
require "telescope"

describe("Easy_AI", function()

  before(function()
    mock_board = {}
    mock_board.spaces = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
    mock_in_out = Mock_In_Out:new()
    easy_ai = Easy_AI:new("x", mock_in_out, mock_board)
    easy_ai:get_move()
  end)

  context("new", function()
    it("initializes an easy ai player with a gamepiece, an in_out object and a board", function()
      assert_equal("x", easy_ai.gamepiece)
      assert_equal(mock_in_out, easy_ai.in_out)
      assert_equal(mock_board, easy_ai.board)
    end)

    it("initializes an instance of easy_ai with a label", function()
      assert_equal("Computer", easy_ai.label)
    end)
  end)

  context("get_move", function()
    it("writes moves to in_out", function()
      assert_not_nil(mock_in_out.outputs[1])
    end)

    it("returns a random number less than or equaled to the number of board spaces", function()
      for i = 1, 1000 do
        assert_true(easy_ai:get_move() <= #mock_board.spaces)
      end
    end)

    it("returns a random number so that each space on the board is called in a somewhat equal distribution", function()
      local results = { ["1"] = 0, ["2"] = 0, ["3"] = 0, ["4"] = 0, ["5"] = 0, ["6"] = 0, ["7"] = 0, ["8"] = 0, ["9"] = 0 }

      for i = 1, 1000 do
        local move = tostring(easy_ai:get_move())
        results[move] = results[move] + 1
      end

      for k, v in pairs(results) do
        assert_less_than(v/1000, .20)
      end
    end)
  end)
end)