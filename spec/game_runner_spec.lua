-- require "telescope"
-- local Game_Runner = require "game_runner"
-- local inspect = require "inspect"
-- local messages = require "messages"
-- local Mock_In_Out = require "mock_in_out"
-- local validations = require "validations"

-- describe("Game_Runner", function()

--   context("new", function()
--     before(function()
--       local inputs = { "No" }
--       mock_in_out = Mock_In_Out:new(inputs)
--       game_runner = Game_Runner:new(mock_in_out)
--     end)

--     it("initializes a game_runner with an input/output", function()
--       assert_equal(mock_in_out, game_runner.in_out)
--     end)
--   end)
--THIS NEEDS TO BE PLAYER NOW  CHANGE TYPE TOO
--   context("configure_game", function()
--     before(function()
--       board_size = "3"
--       local inputs = { "2", "11", board_size, ".", "ll", "k", "easy_ai", "4", "Human", "?" , "10000000", "m", "me", "whatever", "Player 1" }
--       local mock_in_out = Mock_In_Out:new(inputs)
--       game_runner = Game_Runner:new(mock_in_out)
--       game_runner:configure_game()
--       outputs = game_runner.in_out.outputs
--       board_size_prompt = messages.board_size_prompt(validations.minimum_board_size, validations.maximum_board_size)
--       p1_gamepiece_prompt = messages.gamepiece_prompt(game_runner.game.player_1)
--       opponent_prompt = messages.opponent_prompt(validations.opponent_options)
--       p2_gamepiece_prompt = messages.gamepiece_prompt(game_runner.game.player_2)
--       turn_order_prompt = messages.turn_order_prompt(validations.turn_order_options)
--     end)

--     it("displays a welcome message", function()
--       assert_equal(messages.welcome, outputs[1])
--     end)

--     it("prompts user for a board_size until valid input is received and then creates the board", function()

--       for i = 2, 6, 2 do
--         assert_equal(board_size_prompt, outputs[i])
--       end

--       for i = 3, 5, 2 do
--         assert_equal(messages.invalid_selection, outputs[i])
--       end

--       assert_equal(tonumber(board_size), game_runner.game.board.size)
--     end)

--     it("prompts user for a gamepiece until valid input is received and then creates player_1 (the user)", function()
--       for i = 7, 11, 2 do
--         assert_equal(p1_gamepiece_prompt, outputs[i])
--       end

--       for i = 8, 10, 2 do
--         assert_equal(messages.invalid_selection, outputs[i])
--       end

--       assert_equal("Human", game_runner.game.player_1.type)
--     end)

--     it("prompts user for the type of opponent until valid input is received and then creates player_2", function()
--       for i = 12, 16, 2 do
--         assert_equal(opponent_prompt, outputs[i])
--       end

--       for i = 13, 15, 2 do
--         assert_equal(messages.invalid_selection, outputs[i])
--       end

--       assert_equal("Human 2", game_runner.game.player_2.type)
--     end)

--     it("prompts user for the opponent's gamepiece until valid input is received and then updates player_2's gamepiece", function()
--       for i = 17, 21, 2 do
--       assert_equal(p2_gamepiece_prompt, outputs[i])
--       end

--       for i = 18, 20, 2 do
--         assert_equal(messages.invalid_selection, outputs[i])
--       end

--       assert_equal("m", game_runner.game.player_2.gamepiece)
--     end)

--     it("prompts user for the turn order until valid input is received and then sets up the order", function()
--       for i = 22, 26, 2 do
--         assert_equal(turn_order_prompt, outputs[i])
--       end

--       for i = 23, 25, 2 do
--         assert_equal(messages.invalid_selection, outputs[i])
--       end

--       assert_equal("Human", game_runner.game.players[1].type)
--       assert_equal("Human 2", game_runner.game.players[2].type)
--     end)
--   end)

--   context("integration tests", function()
--     context("configures and plays a game only one time through", function()
--       it("plays a game only one time", function()
--         local inputs = { "3", "k", "Human", "m", "Player 1", "1", "2", "4", "5", "7", "NO" }
--         local mock_in_out = Mock_In_Out:new(inputs)
--         local game_runner = Game_Runner:new(mock_in_out)
--         game_runner:configure_game()
--         game_runner:play_game()
--         local outputs = game_runner.in_out.outputs
--         local board_size_prompt = messages.board_size_prompt(validations.minimum_board_size, validations.maximum_board_size)
--         local p1_gamepiece_prompt = messages.gamepiece_prompt(game_runner.game.player_1)
--         local opponent_prompt = messages.opponent_prompt(validations.opponent_options)
--         local p2_gamepiece_prompt = messages.gamepiece_prompt(game_runner.game.player_2)
--         local turn_order_prompt = messages.turn_order_prompt(validations.turn_order_options)
--         local p1_move_prompt = messages.move_prompt(game_runner.game.player_1, game_runner.game.board)
--         local p2_move_prompt = messages.move_prompt(game_runner.game.player_2, game_runner.game.board)
--         local final_gameboard = messages.build_board(game_runner.game.board)
--         local game_decision = messages.win(game_runner.game.player_1.gamepiece)
--         local play_again_prompt = messages.play_again_prompt(validations.play_again_options)
--         assert_equal(messages.welcome, outputs[1])
--         assert_equal(board_size_prompt, outputs[2])
--         assert_equal(p1_gamepiece_prompt, outputs[3])
--         assert_equal(opponent_prompt, outputs[4])
--         assert_equal(p2_gamepiece_prompt, outputs[5])
--         assert_equal(turn_order_prompt, outputs[6])

--         for i = 8, 16, 4 do
--           assert_equal(p1_move_prompt, outputs[i])
--         end

--         for i = 10, 14, 4 do
--           assert_equal(p2_move_prompt, outputs[i])
--         end

--         assert_equal(final_gameboard, outputs[17])
--         assert_equal(game_decision, outputs[18])
--         assert_equal(play_again_prompt, outputs[19])
--       end)

--       it("plays a game only one time; player inputs two invalid moves during game", function()
--         local inputs = { "3", "k", "HUMAN", "m", "PLAYER 1", "1", "1", "a", "2", "4", "5", "7", "No" }
--         local mock_in_out = Mock_In_Out:new(inputs)
--         local game_runner = Game_Runner:new(mock_in_out)
--         game_runner:configure_game()
--         game_runner:play_game()
--         local outputs = game_runner.in_out.outputs
--         local board_size_prompt = messages.board_size_prompt(validations.minimum_board_size, validations.maximum_board_size)
--         local p1_gamepiece_prompt = messages.gamepiece_prompt(game_runner.game.player_1)
--         local opponent_prompt = messages.opponent_prompt(validations.opponent_options)
--         local p2_gamepiece_prompt = messages.gamepiece_prompt(game_runner.game.player_2)
--         local turn_order_prompt = messages.turn_order_prompt(validations.turn_order_options)
--         local p1_move_prompt = messages.move_prompt(game_runner.game.player_1, game_runner.game.board)
--         local p2_move_prompt = messages.move_prompt(game_runner.game.player_2, game_runner.game.board)
--         local final_gameboard = messages.build_board(game_runner.game.board)
--         local game_decision = messages.win(game_runner.game.player_1.gamepiece)
--         local play_again_prompt = messages.play_again_prompt(validations.play_again_options)
--         assert_equal(messages.welcome, outputs[1])
--         assert_equal(board_size_prompt, outputs[2])
--         assert_equal(p1_gamepiece_prompt, outputs[3])
--         assert_equal(opponent_prompt, outputs[4])
--         assert_equal(p2_gamepiece_prompt, outputs[5])
--         assert_equal(turn_order_prompt, outputs[6])
--         assert_equal(p1_move_prompt, outputs[8])
--         assert_equal(p1_move_prompt, outputs[16])
--         assert_equal(p1_move_prompt, outputs[20])
--         assert_equal(p2_move_prompt, outputs[10])
--         assert_equal(messages.invalid_selection, outputs[11])
--         assert_equal(p2_move_prompt, outputs[12])
--         assert_equal(messages.invalid_selection, outputs[13])
--         assert_equal(p2_move_prompt, outputs[14])
--         assert_equal(p2_move_prompt, outputs[18])
--         assert_equal(final_gameboard, outputs[21])
--         assert_equal(game_decision, outputs[22])
--         assert_equal(play_again_prompt, outputs[23])
--       end)

--       --TODO:  needs to test just game decisions now
--       it("plays a game once and then plays a second game", function()
--         local inputs = { "3", "k", "Human", "m", "player 1", "1", "2", "4", "5", "7", "YES", "3", "k", "Human", "m", "Player 1", "1", "2", "4", "5", "7", "No" }
--         local mock_in_out = Mock_In_Out:new(inputs)
--         local game_runner = Game_Runner:new(mock_in_out)
--         game_runner:configure_game()
--         game_runner:play_game()
--         local outputs = game_runner.in_out.outputs
--         local board_size_prompt = messages.board_size_prompt(validations.minimum_board_size, validations.maximum_board_size)
--         local p1_gamepiece_prompt = messages.gamepiece_prompt(game_runner.game.player_1)
--         local opponent_prompt = messages.opponent_prompt(validations.opponent_options)
--         local p2_gamepiece_prompt = messages.gamepiece_prompt(game_runner.game.player_2)
--         local turn_order_prompt = messages.turn_order_prompt(validations.turn_order_options)
--         local final_gameboard = messages.build_board(game_runner.game.board)
--         local game_decision = messages.win(game_runner.game.player_1.gamepiece)
--         local play_again_prompt = messages.play_again_prompt(validations.play_again_options)
--         assert_equal(messages.welcome, outputs[1])
--         assert_equal(board_size_prompt, outputs[2])
--         assert_equal(p1_gamepiece_prompt, outputs[3])
--         assert_equal(opponent_prompt, outputs[4])
--         assert_equal(p2_gamepiece_prompt, outputs[5])
--         assert_equal(turn_order_prompt, outputs[6])
--         assert_equal(final_gameboard, outputs[17])
--         assert_equal(game_decision, outputs[18])
--         assert_equal(play_again_prompt, outputs[19])
--         assert_equal(messages.welcome, outputs[20])
--         assert_equal(board_size_prompt, outputs[21])
--         assert_equal(p1_gamepiece_prompt, outputs[22])
--         assert_equal(opponent_prompt, outputs[23])
--         assert_equal(p2_gamepiece_prompt, outputs[24])
--         assert_equal(turn_order_prompt, outputs[25])
--         assert_equal(final_gameboard, outputs[36])
--         assert_equal(game_decision, outputs[37])
--         assert_equal(play_again_prompt, outputs[38])
--       end)
--     end)
--   end)
-- end)