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
end

function Game:play()
  self.in_out:write(messages.welcome)
  self.in_out:write(messages.build_board(self.board))
  move = self.in_out:read()
  self.in_out:write("This is the user's move: " .. move)
end

return Game