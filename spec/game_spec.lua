package.path = package.path .. ";./lib/?.lua;./spec/mock_in_out.lua"

local Game = require "game"
local Mock_In_Out = require "mock_in_out"
require "telescope"

describe("Game", function()

  before(function()
    local inputs = { "a" }
    local mock_in_out = Mock_In_Out:new(inputs)
    game = Game:new(mock_in_out)
  end)

  context("setup", function()
    it("initializes the board", function()
      assert_not_nil(game.board)
    end)
  end)

  context("play", function()

    before(function ()
      game:play()
    end)

    it("displays a welcome message", function()
      assert_equal("Welcome!", game.in_out.outputs[1])
    end)

    it("displays the board spaces", function()
      assert_equal(3, game.in_out.outputs[2])
    end)

    it("reads a player's move", function()
      assert_equal("This is the user's move: a", game.in_out.outputs[3])
    end)
  end)
end)