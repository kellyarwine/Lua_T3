local Easy_AI = {}

function Easy_AI:get_move()
  local move = math.random(#self.board.spaces)
  self.in_out:write(move)
  return move
end

function Easy_AI:new(gamepiece, in_out, board)
  local o = {}
  o.gamepiece = gamepiece
  o.in_out = in_out
  o.board = board
  o.label = "Computer"
  setmetatable(o, self)
  self.__index = self
  return o
end

return Easy_AI