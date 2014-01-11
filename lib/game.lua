Board = require "board"
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
  self:display_board()
  self:display_make_move()
  local move = self:make_move()
  self:place_move(move)
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

function Game:make_move()
  --wonder if tonumber should go here?
  return tonumber(self.in_out:read())
end

function Game:place_move(move)
  self.board.spaces[move] = "x"
end

return Game