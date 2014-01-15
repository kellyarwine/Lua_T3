local messages = require "messages"

describe("messages", function()

  before(function()
    three_x_three_board = {}
    three_x_three_board.size = 3
    three_x_three_board.spaces = { "x", "x", "x", "4", "5", "6", "7", "8", "9" }
    four_x_four_board = {}
    four_x_four_board.size = 4
    superstar_player = { label = "Superstar" }
  end)

  context("build_board", function()
    it("outputs a constructed 3x3 gameboard", function()
      function three_x_three_board.segment_rows() return { { "x", "x", "x" }, { "4", "5", "6" }, { "7", "8", "9" } } end
      local expected_value = "     |     |     \n" ..
                             "  x  |  x  |  x  \n" ..
                             "-----+-----+-----\n" ..
                             "  4  |  5  |  6  \n" ..
                             "-----+-----+-----\n" ..
                             "  7  |  8  |  9  \n" ..
                             "     |     |     \n\n"
      assert_equal(expected_value, messages.build_board(three_x_three_board))
    end)

    it("outputs a constructed 4x4 gameboard with double digits for the space numbers", function()
      function four_x_four_board.segment_rows() return { { "x", "x", "x", "x" }, { "5", "6", "7", "8" }, { "9", "10", "11", "12" }, { "13", "14", "15", "16" } } end
      local expected_value = "     |     |     |     \n" ..
                             "  x  |  x  |  x  |  x  \n" ..
                             "-----+-----+-----+-----\n" ..
                             "  5  |  6  |  7  |  8  \n" ..
                             "-----+-----+-----+-----\n" ..
                             "  9  |  10 |  11 |  12 \n" ..
                             "-----+-----+-----+-----\n" ..
                             "  13 |  14 |  15 |  16 \n" ..
                             "     |     |     |     \n\n"
      assert_equal(expected_value, messages.build_board(four_x_four_board))
    end)
  end)

  context("move_prompt", function()
    it("instructs the player to make a move, displaying the minimum and maximum values that can be input", function()
      assert_equal("Superstar, make your move (enter a number 1 - 9):\n", messages.move_prompt(superstar_player, three_x_three_board))
    end)
  end)

  context("board_size_prompt", function()
    it("instructs the player to enter a board size, displaying the minimum and maximum values that can be input", function()
      assert_equal("Choose the size of the gameboard (enter a number 10 - 100):\n", messages.board_size_prompt({ 10, 100 }))
    end)
  end)

  context("player_selection_prompt", function()
    it("instructs the player to select a player, displaying all available player types that can be input", function()
      assert_equal("Choose Player 1's player type (enter 'Human' or 'Easy AI' or 'Hard AI'):\n", messages.player_selection_prompt({ "Human", "Easy AI", "Hard AI" }, 1))
    end)
  end)

  context("gamepiece_prompt", function()
    it("instructs the player to select a gamepiece, displaying all available constraints for the input", function()
      assert_equal("Choose any single letter to be the gamepiece for Player 1:\n", messages.gamepiece_prompt(1))
    end)
  end)

  context("turn_order_prompt", function()
    it("instructs the player to choose which player goes first, displaying all available players that can be input", function()
      assert_equal("Choose which player goes first (enter 'Player 1' or 'Player 2'):\n", messages.turn_order_prompt({ "Player 1", "Player 2" }))
    end)
  end)

  context("play_again_prompt", function()
    it("instructs the player to choose whether or not they want to play again, displaying all available players that can be input", function()
      assert_equal("Ready to go again? (Enter 'No' or 'Yes'.)\n", messages.play_again_prompt({ "No", "Yes" }))
    end)
  end)

  context("same_configurations_prompt", function()
    it("instructs the player to choose whether or not they want to use the same configurations to play another game", function()
      assert_equal("Same configurations as before? (Enter 'No' or 'Yes'.)\n", messages.same_configurations_prompt({ "No", "Yes" }))
    end)
  end)

  context("loop_number_prompt", function()
    it("instructs the player to choose how many times they want to repeat the game loop without stopping", function()
      assert_equal("How many games would you like to play? (Enter any number 1 - 2000.)\n", messages.loop_number_prompt({ 1, 2000 }))
    end)
  end)


  context("win", function()
    it("notifies the player of the win and displays the winning gamepiece", function()
      assert_equal("x wins.  Whoop.Dee.Do.\n\n", messages.win("x"))
    end)
  end)

  context("cats", function()
    it("notifies the player of a tie game", function()
      assert_equal("Cats game.  Better luck next time.\n\n", messages.cats("x"))
    end)
  end)
end)