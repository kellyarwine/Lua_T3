local Game_Runner = require "game_runner"
local messages = require "messages"
local Mock_In_Out = require "mock_in_out"
local validations = require "validations"
require "telescope"

describe("Game_Runner/Integration", function()
  before(function()
    board_size_prompt = messages.board_size_prompt(validations.board_range)
    p1_gamepiece_prompt = messages.gamepiece_prompt(1)
    p2_gamepiece_prompt = messages.gamepiece_prompt(2)
    p1_selection_prompt = messages.player_selection_prompt(validations.player_options, 1)
    p2_selection_prompt = messages.player_selection_prompt(validations.player_options, 2)
    turn_order_prompt = messages.turn_order_prompt(validations.turn_order_options)
  end)

  context("new", function()
    it("initializes a game_runner with an in_out object", function()
      local mock_in_out = Mock_In_Out:new({})
      local game_runner = Game_Runner:new(mock_in_out)
      assert_equal(mock_in_out, game_runner.in_out)
    end)
  end)

  context("configure_game", function()
    before(function()
      board_size_valid_input = "3"
      p1_type_valid_input = "HUman"
      p1_gamepiece_valid_input = "Z"
      p2_type_valid_input = "huMAN"
      p2_gamepiece_valid_input = "y"
      turn_order_valid_input = "PLAYER 2"
      local inputs = { "2", "11", board_size_valid_input, "easy_ai", "4", p1_type_valid_input, "?" , "10000000", p1_gamepiece_valid_input, "me", "whatever", p2_type_valid_input, "?", "!", p2_gamepiece_valid_input, "me", "me again", "hey! over here!", turn_order_valid_input }
      local mock_in_out = Mock_In_Out:new(inputs)
      game_runner = Game_Runner:new(mock_in_out)
      game_runner:configure_game()
      outputs = game_runner.in_out.outputs
    end)

    it("displays a welcome message", function()
      assert_equal(messages.configurations_welcome, outputs[1])
    end)

    it("prompts user for a board_size until valid input is received and then creates the board", function()
      for i = 2, 6, 2 do
        assert_equal(board_size_prompt, outputs[i])
      end

      for i = 3, 5, 2 do
        assert_equal(messages.invalid_selection, outputs[i])
      end

      assert_equal(tonumber(board_size_valid_input), game_runner.game.board.size)
    end)

    it("prompts user for the player type until valid input is received and then creates player_1", function()
      for i = 7, 11, 2 do
        assert_equal(p1_selection_prompt, outputs[i])
      end

      for i = 8, 10, 2 do
        assert_equal(messages.invalid_selection, outputs[i])
      end

      assert_equal(string.lower(p1_gamepiece_valid_input), game_runner.game.player_1.gamepiece)
    end)

    it("prompts user for a gamepiece until valid input is received", function()
      for i = 12, 16, 2 do
        assert_equal(p1_gamepiece_prompt, outputs[i])
      end

      for i = 13, 15, 2 do
        assert_equal(messages.invalid_selection, outputs[i])
      end

      assert_equal(string.lower(p1_gamepiece_valid_input), game_runner.game.player_1.gamepiece)
    end)

    it("prompts user for the player type until valid input is received and then creates player_2", function()
      for i = 17, 19, 2 do
        assert_equal(p2_selection_prompt, outputs[i])
      end

      for i = 18, 20, 2 do
        assert_equal(messages.invalid_selection, outputs[i])
      end

      assert_equal(p2_gamepiece_valid_input, game_runner.game.player_2.gamepiece)
    end)

    it("prompts user for a gamepiece until valid input is received", function()
      for i = 22, 26, 2 do
      assert_equal(p2_gamepiece_prompt, outputs[i])
      end

      for i = 23, 25, 2 do
        assert_equal(messages.invalid_selection, outputs[i])
      end

      assert_equal(p2_gamepiece_valid_input, game_runner.game.player_2.gamepiece)
    end)

    it("prompts user for the turn order until valid input is received and then sets up the order", function()
      for i = 27, 33, 2 do
        assert_equal(turn_order_prompt, outputs[i])
      end

      for i = 28, 32, 2 do
        assert_equal(messages.invalid_selection, outputs[i])
      end

      assert_equal("Human 2", game_runner.game.players[1].label)
      assert_equal("Human", game_runner.game.players[2].label)
    end)

    it("saves all of the console output in memory", function()
      assert_equal(33, #outputs)
    end)
  end)

  context("configures and plays a game only one time through", function()
    before(function()
      local inputs = { "3", "Human", "m", "Human", "k", "player 1", "1", "2", "4", "5", "7", "NO" }
      local mock_in_out = Mock_In_Out:new(inputs)
      game_runner = Game_Runner:new(mock_in_out)
      game_runner:configure_game()
      game_runner:play_game()
      outputs = game_runner.in_out.outputs
      p1_move_prompt = messages.move_prompt(game_runner.game.player_1, game_runner.game.board)
      p2_move_prompt = messages.move_prompt(game_runner.game.player_2, game_runner.game.board)
      final_gameboard = messages.build_board(game_runner.game.board)
      game_decision = messages.win(game_runner.game.player_1.gamepiece)
      play_again_prompt = messages.play_again_prompt(validations.yes_no_options)
    end)

    it("configures the game", function()
      assert_equal(messages.configurations_welcome, outputs[1])
      assert_equal(board_size_prompt, outputs[2])
      assert_equal(p1_selection_prompt, outputs[3])
      assert_equal(p1_gamepiece_prompt, outputs[4])
      assert_equal(p2_selection_prompt, outputs[5])
      assert_equal(p2_gamepiece_prompt, outputs[6])
      assert_equal(turn_order_prompt, outputs[7])
    end)

    it("plays the game", function()
      for i = 9, 17, 4 do
        assert_equal(p1_move_prompt, outputs[i])
      end

      for i = 11, 15, 4 do
        assert_equal(p2_move_prompt, outputs[i])
      end
      assert_equal(final_gameboard, outputs[18])
      assert_equal(game_decision, outputs[19])
      assert_equal(play_again_prompt, outputs[20])
    end)

    it("saves all of the console output in memory", function()
      assert_equal(20, #outputs)
    end)
  end)

  context("configures and plays a game twice, choosing to play again a second time with the same configurations", function()
    before(function()
      local inputs = { "3", "hard ai", "m", "hard ai", "k", "player 1", "yes", "yes", "1" }
      local mock_in_out = Mock_In_Out:new(inputs)
      game_runner = Game_Runner:new(mock_in_out)
      game_runner:configure_game()
      game_runner:play_game()
      outputs = game_runner.in_out.outputs
      p1_move_prompt = messages.move_prompt(game_runner.game.player_1, game_runner.game.board)
      p2_move_prompt = messages.move_prompt(game_runner.game.player_2, game_runner.game.board)
      final_gameboard = messages.build_board(game_runner.game.board)
      game_decision = messages.cats(game_runner.game.player_1.gamepiece)
      play_again_prompt = messages.play_again_prompt(validations.yes_no_options)
      same_configurations_prompt = messages.same_configurations_prompt(validations.yes_no_options)
      loop_number_prompt = messages.loop_number_prompt(validations.game_loop_range)
    end)

    it("configures the game", function()
      assert_equal(messages.configurations_welcome, outputs[1])
      assert_equal(board_size_prompt, outputs[2])
      assert_equal(p1_selection_prompt, outputs[3])
      assert_equal(p1_gamepiece_prompt, outputs[4])
      assert_equal(p2_selection_prompt, outputs[5])
      assert_equal(p2_gamepiece_prompt, outputs[6])
      assert_equal(turn_order_prompt, outputs[7])
    end)

    it("plays the first game", function()
      for i = 9, 33, 6 do
        assert_equal(p1_move_prompt, outputs[i])
      end

      for i = 12, 30, 6 do
        assert_equal(p2_move_prompt, outputs[i])
      end

      assert_equal(game_decision, outputs[36])
      assert_equal(play_again_prompt, outputs[37])
      assert_equal(same_configurations_prompt, outputs[38])
      assert_equal(loop_number_prompt, outputs[39])
    end)

    it("plays the second game", function()
      for i = 44, 62, 6 do
        assert_equal(p1_move_prompt, outputs[i])
      end

      for i = 41, 65, 6 do
        assert_equal(p2_move_prompt, outputs[i])
      end

      assert_equal(final_gameboard, outputs[67])
      assert_equal(game_decision, outputs[68])
    end)

    it("saves all of the console output in memory", function()
      assert_equal(68, #outputs)
    end)
  end)
end)