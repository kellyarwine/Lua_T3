local Board = {}

function Board:new(size)
  local o = {}
  o.size = size
  setmetatable(o, self)
  self.__index = self
  o.board = o:create_spaces()
  return o
end

function Board:create_spaces()
  self.spaces = {}
  for i = 1, self.size^2 do
    self.spaces[i] = tostring(i)
  end
end

function Board:segment()
  local segments = {}
  local spaces_index = 1

  for i = 1, self.size do
    local segment = {}

    for j = 1, self.size do
      incrementer = (i - 1) * self.size
      next_index = j + incrementer
      segment[j] = self.spaces[next_index]
    end

    table.insert(segments, segment)
  end

  return segments
end

return Board