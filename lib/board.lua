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

  local row_segments = self:segment_rows()
  for i=1, #row_segments do
    table.insert(segments, row_segments[i])
  end

  local column_segments = self:segment_columns()
  for i=1, #column_segments do
    table.insert(segments, column_segments[i])
  end

  table.insert(segments, self:segment_left_diagonal())
  table.insert(segments, self:segment_right_diagonal())

  return segments
end

function Board:segment_rows()
  local segments = {}

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

function Board:segment_columns()
  local segments = {}

  for i = 1, self.size do
    local segment = {}

    for j = 1, self.size do
      incrementer = (j - 1) * self.size
      next_index = i + incrementer
      segment[j] = self.spaces[next_index]
    end

    table.insert(segments, segment)
  end

  return segments
end


function Board:segment_left_diagonal()
  local segment = {}

  for j = 1, self.size do
    incrementer = (j - 1) * (self.size + 1)
    next_index = 1 + incrementer
    segment[j] = self.spaces[next_index]
  end

  return segment
end

function Board:segment_right_diagonal()
  local segment = {}

  for j = 1, self.size do
    incrementer = (j - 1) * (self.size - 1)
    next_index = self.size + incrementer
    segment[j] = self.spaces[next_index]
  end

  return segment
end

function Board:has_available_space()
  local spaces_string = table.concat(self.spaces)
  local open_space = '%d'
  return string.find(spaces_string, open_space) ~= nil
end

return Board