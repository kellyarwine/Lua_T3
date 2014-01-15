local Game = require "game"
local messages = require "messages"
local Mock_In_Out = require "mock_in_out"
local Board = require "board"
require "telescope"

describe("Game", function()

  before(function()
    inputs = { "1", "4", "4", "a", "100", "3", "5", "9", "6" }
    mock_in_out = Mock_In_Out:new(inputs)
    mock_board = Board:new(3)
    mock_player_1 = { label = "k_player", gamepiece = "k" }
    mock_player_2 = { label = "m_player", gamepiece = "m" }
    mock_players = { mock_player_1, mock_player_2 }
    mock_configurations = { in_out = mock_in_out,
                            board = mock_board,
                            player_1 = mock_player_1,
                            player_2 = mock_player_2,
                            players = mock_players }
    game = Game:new(mock_configurations)
  end)

  context("new", function()
    it("initializes an instance of game with game configurations that are used to make the main game objects", function()
      assert_arrays_equal(mock_in_out, game.in_out)
      assert_arrays_equal(mock_board, game.board)
      assert_arrays_equal(mock_player_1, game.player_1)
      assert_arrays_equal(mock_player_2, game.player_2)
      assert_arrays_equal(mock_players, game.players)
    end)
  end)

  context("play", function()
    it("stops looping when the game is won, displays a final board and a win game decision", function()
      function mock_board.segment() return { { "k", "k", "k" } } end
      function mock_board.segment_rows() return { { "k", "2", "3" }, { "k", "5", "6" }, { "k", "8", "9" } } end
      function mock_board.available_spaces() return { "2", "5", "8", "3", "6", "9" } end
      local expected_value =
        "     |     |     \n" ..
        "  k  |  2  |  3  \n" ..
        "-----+-----+-----\n" ..
        "  k  |  5  |  6  \n" ..
        "-----+-----+-----\n" ..
        "  k  |  8  |  9  \n" ..
        "     |     |     \n\n"
      game:loop()
      assert_equal(expected_value, mock_in_out.outputs[1])
      assert_equal(messages.win(mock_player_1.gamepiece), mock_in_out.outputs[2])
    end)

    it("stops looping when the game is draw, displays a final board and a cats game decision", function()
      function mock_board.segment() return {} end
      function mock_board.segment_rows() return { { "k", "m", "k" }, { "m", "k", "m" }, { "m", "k", "m" } } end
      function mock_board.available_spaces() return {} end
      local expected_value =
        "     |     |     \n" ..
        "  k  |  m  |  k  \n" ..
        "-----+-----+-----\n" ..
        "  m  |  k  |  m  \n" ..
        "-----+-----+-----\n" ..
        "  m  |  k  |  m  \n" ..
        "     |     |     \n\n"
      game:loop()
      assert_equal(expected_value, mock_in_out.outputs[1])
      assert_equal(messages.cats(), mock_in_out.outputs[2])
    end)

    it("loops while the game is not over, displaying the board, prompting for moves, getting moves, placing the moves and swapping players", function()
      function mock_player_1:get_move() return 1 end
      function mock_player_2:get_move() return 2 end
      p1_move_prompt = messages.move_prompt(game.player_1, game.board)
      p2_move_prompt = messages.move_prompt(game.player_2, game.board)
      game.board.spaces = { "1", "2", "k",
                            "m", "k", "m",
                            "m", "k", "m" }
      local expected_value_1 =
        "     |     |     \n" ..
        "  1  |  2  |  k  \n" ..
        "-----+-----+-----\n" ..
        "  m  |  k  |  m  \n" ..
        "-----+-----+-----\n" ..
        "  m  |  k  |  m  \n" ..
        "     |     |     \n\n"

        local expected_value_2 =
        "     |     |     \n" ..
        "  k  |  2  |  k  \n" ..
        "-----+-----+-----\n" ..
        "  m  |  k  |  m  \n" ..
        "-----+-----+-----\n" ..
        "  m  |  k  |  m  \n" ..
        "     |     |     \n\n"

        local expected_value_3 =
        "     |     |     \n" ..
        "  k  |  m  |  k  \n" ..
        "-----+-----+-----\n" ..
        "  m  |  k  |  m  \n" ..
        "-----+-----+-----\n" ..
        "  m  |  k  |  m  \n" ..
        "     |     |     \n\n"

      game:loop()
      assert_equal(expected_value_1, mock_in_out.outputs[1])
      assert_equal(p1_move_prompt, mock_in_out.outputs[2])
      assert_equal(expected_value_2, mock_in_out.outputs[3])
      assert_equal(p2_move_prompt, mock_in_out.outputs[4])
      assert_equal(expected_value_3, mock_in_out.outputs[5])
      assert_equal(messages.cats(), mock_in_out.outputs[6])
    end)
  end)
end)