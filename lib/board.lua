local function create_spaces(self)
  self.spaces = {}
  for i = 1, self.size^2 do
    self.spaces[i] = tostring(i)
  end
end

local function segment_columns(self)
  local columns = {}

  for i = 1, self.size do
    local column = {}

    for j = 1, self.size do
      incrementer = (j - 1) * self.size
      next_index = i + incrementer
      column[j] = self.spaces[next_index]
    end

    table.insert(columns, column)
  end

  return columns
end

local function segment_left_diagonal(self)
  local left_diagonal = {}

  for j = 1, self.size do
    incrementer = (j - 1) * (self.size + 1)
    next_index = 1 + incrementer
    left_diagonal[j] = self.spaces[next_index]
  end

  return { left_diagonal }
end

local function segment_right_diagonal(self)
  local right_diagonal = {}

  for j = 1, self.size do
    incrementer = (j - 1) * (self.size - 1)
    next_index = self.size + incrementer
    right_diagonal[j] = self.spaces[next_index]
  end

  return { right_diagonal }
end



local Board = {}

function Board:reset()
  create_spaces(self)
end

function Board:available_spaces()
  available_spaces = {}

  for _, space in ipairs(self.spaces) do
    if string.find(space, "^%d") then table.insert(available_spaces, space) end
  end

  return available_spaces
end

function Board:segment_rows()
  local rows = {}

  for i = 1, self.size do
    local row = {}

    for j = 1, self.size do
      incrementer = (i - 1) * self.size
      next_index = j + incrementer
      row[j] = self.spaces[next_index]
    end

    table.insert(rows, row)
  end

  return rows
end

function Board:segment()
  local segment_groups = { self:segment_rows(),
                           segment_columns(self),
                           segment_left_diagonal(self),
                           segment_right_diagonal(self) }
  local segments = {}

  for _, segment_group in ipairs(segment_groups) do
    for _, segment in ipairs(segment_group) do
      table.insert(segments, segment)
    end
  end

  return segments
end

function Board:new(size)
  local o = {}
  o.size = size
  setmetatable(o, self)
  self.__index = self
  create_spaces(o)
  return o
end

return Board