package.path = package.path .. ";./lib/?.lua;./scripts/?.lua;./spec/mock_in_out.lua"

local Game_Runner = require "game_runner"
local In_Out = require "in_out"

game_runner = Game_Runner:new(In_Out:new("outputs.txt", "inputs.txt"))
game_runner:configure_game()
game_runner:play_game()