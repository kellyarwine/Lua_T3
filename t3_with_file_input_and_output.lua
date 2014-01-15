package.path = package.path .. ";./lib/?.lua;./scripts/?.lua;./spec/mock_in_out.lua"

local Game_Runner = require "game_runner"
local In_Out = require "in_out"

-- input to file, output to file
-- game_runner = Game_Runner:new(In_Out:new("spec/input.txt", "spec/output.txt"))
-- input to console, output to file
-- game_runner = Game_Runner:new(In_Out:new("none", "spec/output.txt"))
-- input to file, output to console
game_runner = Game_Runner:new(In_Out:new("spec/input.txt"))
game_runner:configure_game()
game_runner:play_game()