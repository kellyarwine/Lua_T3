local Easy_AI = {}
local inspect = require "inspect"

function Easy_AI:new(gamepiece, in_out, board)
  local o = {}
  o.gamepiece = gamepiece
  o.board = board
  o.label = "Computer"
  setmetatable(o, self)
  self.__index = self
  return o
end

function Easy_AI:get_move()
  return math.random(#self.board.spaces)
end

return Easy_AI