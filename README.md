finish up testing for game_runner and game
add prompter module
mess around with assert match


At the end---------------------
go back and check global namespace
go back and check for local variables
check for random comments
see test coverage
update readme
run game on mike's computer after fresh install
get rid of inspect's


Input/Output to File

I've designed the game's input/output ('in_out') functionality, so that a user can include two filenames for writing to a file and reading from a file, respectively.  The reading/writing functionality can be used in conjunction with each other or separately (inputs could be read.

The sample file 't3_with_file_input_and_output.lua' to illustrate the game's configuration settings.
The sample file 'inputs.txt' illustrates how to configure input values.
The functionality require that the input file specificed exists, however, the output file need not exist.


Continuous Play Functionality

To run the game in 'continous mode', start the game and enter your desired configurations.  The game will loop one time. At the end of the loop's cycle, type 'yes' to play again, then 'yes' to keep the same configurations, and then enter a value to run the game loop multiple times.

The reasoning for this functionality is a common question I have heard often at 8th Light:

"But how do you REALLY know your Tic Tac Toe game is unbeatable??" - Doug Bradbury (with raised eyebrows)

 So, besides all of the TDD and unit testing, this was a way to be absolutely sure.

 The game is designed so that various player types can play the game as either player 1 or player 2.  Using the 'Input/Output to File' functionality, I set up a game between an 'Easy AI' player (gamepiece 'e') and a 'Hard AI' player (gamepiece 'h') with 'Easy AI' making the first move for each game.  I then ran the game 2,000 times and checked the output for an 'h wins' game decision.  The test was successful.  The 'Hard AI' player won 1,675 times.  The other 325 games were a tie.

 The reasoning for using the 'Easy AI' player is because 'Easy AI' was designed to input random moves.  So using the 'Easy AI' player resulted in game cycles that were more varied.  Pitting two 'Hard AI' players against each other resulted in the same pattern of play for each game.
