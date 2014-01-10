package.path = package.path .. ";./lib/?.lua;./scripts/?.lua;./spec/mock_in_out.lua"

Game = require "Game"
In_Out = require "In_Out"
inspect = require "inspect"

in_out = In_Out:new()
game = Game:new(in_out)
game:play()