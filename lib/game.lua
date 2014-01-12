Board = require "board"
game_rules = require "game_rules"
inspect = require "inspect"
messages = require "messages"

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
  self:display_welcome()
end

function Game:play()
  --TODO:  name game_rules just rules??
  while game_rules.is_game_over(self.board) == false do
    self:display_board()
    self:display_make_move()
    local move = self:make_move()
    self:place_move(move)
  end

  self:display_board()
  self:display_game_decision()
  self:display_play_again()
end

function Game:display_welcome()
  self.in_out:write(messages.welcome)
end

function Game:display_board()
  self.in_out:write(messages.build_board(self.board))
end

function Game:display_make_move()
  self.in_out:write(messages.make_move_prompt(self.board))
end

function Game:display_game_decision()
  local decision = game_rules.get_game_decision(self.board)
  self.in_out:write(messages.game_decision(decision))
end

function Game:display_play_again()
  self.in_out:write(messages.play_again_prompt)
end

function Game:make_move()
  --wonder if tonumber should go here?
  return tonumber(self.in_out:read())
end

function Game:place_move(move)
  self.board.spaces[move] = "x"
end

return Game