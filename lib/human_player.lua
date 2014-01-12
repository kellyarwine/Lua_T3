local Human_Player = {}

function Human_Player:new(gamepiece, in_out)
  local o = {}
  o.gamepiece = gamepiece
  o.in_out = in_out
  setmetatable(o, self)
  self.__index = self
  return o
end

function Human_Player:get_move()
  return tonumber(self.in_out:read())
end

return Human_Player