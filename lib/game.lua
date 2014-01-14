local Board = require "board"
local Easy_AI_Player = require "easy_ai_player"
local Human_Player = require "human_player"
local inspect = require "inspect"
local messages = require "messages"
local rules = require "rules"
local validations = require "validations"

local Game = {}

local function display_game_decision(self)
  local decision, winning_gamepiece = rules.get_game_decision(self.board)
  self.in_out:write(messages[decision](winning_gamepiece))
end

function Game:current_player()
  return self.players[1]
end

function Game:new(configurations)
  local o = {}
  self.in_out = configurations.in_out
  self.board = configurations.board
  self.player_1 = configurations.player_1
  self.player_2 = configurations.player_2
  self.players = configurations.players
  setmetatable(o, self)
  self.__index = self
  return o
end

function Game:loop()
  while rules.is_game_over(self.board) == false do
    self:display_board()
    local move = self:get_move()
    self:place_move(move)
    self:swap_current_player()
  end

  self:display_board()
  display_game_decision(self)
end

function Game:display_welcome()
  self.in_out:write(messages.play_game_welcome)
end

function Game:display_board()
  self.in_out:write(messages.build_board(self.board))
end

function Game:get_move()
  self.in_out:write(messages.move_prompt(self:current_player(), self.board))
  local user_input = self:current_player():get_move()

  if validations.is_invalid("move", self.board, user_input) then
    self.in_out:write(messages.invalid_selection)
    return self:get_move()
  else
    return user_input
  end
end

function Game:place_move(move)
  self.board.spaces[move] = self.players[1].gamepiece
end

function Game:swap_current_player()
  self.players = { self.players[2], self.players[1] }
end

return Game