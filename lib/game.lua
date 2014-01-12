Board = require "board"
Easy_AI_Player = require "easy_ai_player"
Human_Player = require "human_player"
inspect = require "inspect"
messages = require "messages"
rules = require "rules"
validations = require "validations"

Game = {}

function Game:new(in_out)
  local o = { in_out = in_out }
  setmetatable(o, self)
  self.__index = self
  o:setup()
  return o
end

function Game:setup()
  self.board = Board:new(3)
  self.player_1 = Human_Player:new("x", self.in_out)
  self.player_2 = Human_Player:new("o", self.in_out)
  self.players = { self.player_1, self.player_2 }
  self:display_welcome()
end

function Game:play()
  while rules.is_game_over(self.board) == false do
    self:display_board()
    local move = self:get_move()
    self:place_move(move)
    self:swap_current_player()
  end

  self:display_board()
  self:display_game_decision()
  self:display_play_again()
end

function Game:swap_current_player()
  self.players = { self.players[2], self.players[1] }
end

function Game:display_welcome()
  self.in_out:write(messages.welcome)
end

function Game:display_board()
  self.in_out:write(messages.build_board(self.board))
end

function Game:prompt_for_move()
  self.in_out:write(messages.get_move_prompt(self.board))
  return self.players[1]:get_move()
end

function Game:display_invalid_selection()
  self.in_out:write(messages.invalid_selection)
end

function Game:display_game_decision()
  local decision = rules.get_game_decision(self.board)
  self.in_out:write(messages[decision])
end

function Game:display_play_again()
  self.in_out:write(messages.play_again_prompt)
end

function Game:get_move()
  local user_input = self:prompt_for_move()

  if not validations.is_valid_move(self.board, user_input) then
    self:display_invalid_selection()
    user_input = self:get_move()
  end

  return user_input
end

function Game:place_move(move)
  self.board.spaces[move] = self.players[1].gamepiece
end

return Game