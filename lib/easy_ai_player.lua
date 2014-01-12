local Easy_AI_Player = {}

function Easy_AI_Player:new(gamepiece, board)
  local o = {}
  o.gamepiece = gamepiece
  o.board = board
  setmetatable(o, self)
  self.__index = self
  return o
end

function Easy_AI_Player:get_move()
  return math.random(#self.board.spaces)
end

return Easy_AI_Player