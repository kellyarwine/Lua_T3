local Board = require "board"
local Game = require "game"
local inspect = require "inspect"
local messages = require "messages"
local Mock_In_Out = require "mock_in_out"
local rules = require "rules"
require "telescope"

describe("Game", function()

  before(function()
    -- local inputs = { "1", "2", "4", "5", "4", "a", "100000000", "3" }
    local inputs = { "1", "4", "4", "a", "100", "3", "5", "9", "6" }
    local mock_in_out = Mock_In_Out:new(inputs)
    game = Game:new(mock_in_out)
    board = Board:new(3)
  end)

--   context("new", function()
--     it("initializes an instance of game with the in_out instance that is passed in", function()
--       local mock_in_out = Mock_In_Out:new()
--       local game = Game:new(mock_in_out)
--       assert_arrays_equal(mock_in_out, game.in_out)
--     end)
--   end)

--   context("setup", function()
--     it("initializes a board and players", function()
--       assert_not_nil(game.board)
--       assert_not_nil(game.player_1)
--       assert_not_nil(game.player_2)
--     end)

--     it("displays a welcome message", function()
--       assert_equal(messages.welcome, game.in_out.outputs[1])
--     end)
--   end)

--   context("play", function()
--     it("displays the gameboard", function()
--       local function build_board_from_spaces(spaces) board.spaces = spaces return messages.build_board(board) end
--       game:play()
--       assert_equal(build_board_from_spaces({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }), game.in_out.outputs[2])
--       assert_equal(build_board_from_spaces({ "x", "2", "3", "4", "5", "6", "7", "8", "9" }), game.in_out.outputs[4])
--       assert_equal(build_board_from_spaces({ "x", "2", "3", "o", "5", "6", "7", "8", "9" }), game.in_out.outputs[6])
--       assert_equal(build_board_from_spaces({ "x", "2", "x", "o", "5", "6", "7", "8", "9" }), game.in_out.outputs[14])
--       assert_equal(build_board_from_spaces({ "x", "2", "x", "o", "o", "6", "7", "8", "9" }), game.in_out.outputs[16])
--       assert_equal(build_board_from_spaces({ "x", "2", "x", "o", "o", "6", "7", "8", "x" }), game.in_out.outputs[18])
--       assert_equal(build_board_from_spaces({ "x", "2", "x", "o", "o", "o", "7", "8", "x" }), game.in_out.outputs[20])
--     end)

--     it("prompts the user to make a move", function()
--       game:play()
--       assert_equal(messages.get_move_prompt(board), game.in_out.outputs[3])
--       assert_equal(messages.get_move_prompt(board), game.in_out.outputs[5])
--       assert_equal(messages.get_move_prompt(board), game.in_out.outputs[7])
--       assert_equal(messages.get_move_prompt(board), game.in_out.outputs[9])
--       assert_equal(messages.get_move_prompt(board), game.in_out.outputs[11])
--       assert_equal(messages.get_move_prompt(board), game.in_out.outputs[13])
--       assert_equal(messages.get_move_prompt(board), game.in_out.outputs[15])
--       assert_equal(messages.get_move_prompt(board), game.in_out.outputs[17])
--       assert_equal(messages.get_move_prompt(board), game.in_out.outputs[19])
--     end)

--     it("displays an invalid selection message when an invalid move is input", function()
--       game:play()
--       assert_equal(messages.invalid_selection, game.in_out.outputs[8])
--       assert_equal(messages.invalid_selection, game.in_out.outputs[10])
--       assert_equal(messages.invalid_selection, game.in_out.outputs[12])
--     end)

--     it("loops through the game updating the gameboard and alternating player turns", function()
--       game:play()
--       board = Board:new(3)
--       assert_arrays_equal({ "x", "2", "x", "o", "o", "o", "7", "8", "x" }, game.board.spaces)
--     end)

    -- it("displays a win message", function()
    --   game:play()
    --   assert_equal(messages.win("x"), game.in_out.outputs[21])
    -- end)
--   end)
end)