local Human = {}

function Human:new(gamepiece, in_out, board)
  local o = {}
  o.gamepiece = gamepiece
  o.in_out = in_out
  o.label = "Human"
  setmetatable(o, self)
  self.__index = self
  return o
end

function Human:get_move()
  return tonumber(self.in_out:read())
end

return Human