local Configurations = require "configurations"
local messages = require "messages"
local Mock_In_Out = require "mock_in_out"
local Prompter = require "prompter"
require "telescope"
local validations = require "validations"

describe("Configurations", function()

  before(function()
    board_size_valid_input = "3"
    p1_type_valid_input = "HUMAN"
    p1_gamepiece_valid_input = "z"
    p2_type_valid_input = "human"
    p2_gamepiece_valid_input = "y"
    turn_order_valid_input = "player 1"
    board_size_prompt = messages.board_size_prompt(validations.board_range)
    p1_gamepiece_prompt = messages.gamepiece_prompt(1)
    p2_gamepiece_prompt = messages.gamepiece_prompt(2)
    p1_selection_prompt = messages.player_selection_prompt(validations.player_options, 1)
    p2_selection_prompt = messages.player_selection_prompt(validations.player_options, 2)
    turn_order_prompt = messages.turn_order_prompt(validations.turn_order_options)
    local inputs = { "z", board_size_valid_input, "zebra", p1_type_valid_input, "1", p1_gamepiece_valid_input, "Mr. T", p2_type_valid_input, p1_gamepiece_valid_input, p2_gamepiece_valid_input, "me", turn_order_valid_input }
    local mock_in_out = Mock_In_Out:new(inputs)
    prompter = Prompter:new(mock_in_out)
    configurations = Configurations:new(mock_in_out, prompter)
    configurations:configure_game()
    outputs = configurations.in_out.outputs
  end)

  context("new", function()
    it("initializes an instance of Configurations with an in_out and a prompter object", function()
      assert_equal(prompter, configurations.prompter)
      assert_equal(mock_in_out, configurations.mock_in_out)
    end)
  end)

  context("configure_game", function()
    it("displays a welcome message", function()
      assert_equal(messages.configurations_welcome, outputs[1])
    end)

    it("prompts the user for the board_size until valid input is received, then creates the board", function()
      assert_equal(board_size_prompt, outputs[2])
      assert_equal(messages.invalid_selection, outputs[3])
      assert_equal(board_size_prompt, outputs[4])
      assert_equal(tonumber(board_size_valid_input), configurations.board.size)
    end)

    it("prompts the user for the first player's player type until valid input is received, then creates the player", function()
      assert_equal(p1_selection_prompt, outputs[5])
      assert_equal(messages.invalid_selection, outputs[6])
      assert_equal(p1_selection_prompt, outputs[7])
      assert_equal(p1_gamepiece_valid_input, configurations.player_1.gamepiece)
    end)

    it("prompts the user for the first player's gamepiece until valid input is received", function()
      assert_equal(p1_gamepiece_prompt, outputs[8])
      assert_equal(messages.invalid_selection, outputs[9])
      assert_equal(p1_gamepiece_prompt, outputs[10])
      assert_equal(p1_gamepiece_valid_input, configurations.player_1.gamepiece)
    end)

    it("prompts the user for the second player's player type until valid input is received, then creates the player", function()
      assert_equal(p2_selection_prompt, outputs[11])
      assert_equal(messages.invalid_selection, outputs[12])
      assert_equal(p2_selection_prompt, outputs[13])
      assert_equal(p2_gamepiece_valid_input, configurations.player_2.gamepiece)
    end)

    it("prompts the user for the second player's gamepiece until valid input is received", function()
      assert_equal(p2_gamepiece_prompt, outputs[14])
      assert_equal(messages.invalid_selection, outputs[15])
      assert_equal(p2_gamepiece_prompt, outputs[16])
      assert_equal(p2_gamepiece_valid_input, configurations.player_2.gamepiece)
    end)

    it("prompts the user for the turn order until valid input is received, then sets up the order", function()
      assert_equal(turn_order_prompt, outputs[17])
      assert_equal(messages.invalid_selection, outputs[18])
      assert_equal(turn_order_prompt, outputs[19])
      assert_equal(p1_gamepiece_valid_input, configurations.players[1].gamepiece)
      assert_equal(p2_gamepiece_valid_input, configurations.players[2].gamepiece)
    end)

    it("saves all of the console output in memory", function()
      assert_equal(19, #outputs)
    end)

    it("changes player_2's label if both players have the same label", function()
      assert_equal("Human", configurations.player_1.label)
      assert_equal("Human 2", configurations.player_2.label)
    end)
  end)
end)