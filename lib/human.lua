local Human = {}

function Human:get_move()
  local move = tonumber(self.in_out:read())
  return move
end

function Human:new(gamepiece, in_out, board)
  local o = {}
  o.gamepiece = gamepiece
  o.in_out = in_out
  o.label = "Human"
  setmetatable(o, self)
  self.__index = self
  return o
end

return Human