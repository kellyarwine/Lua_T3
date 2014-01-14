local Board = {}
local inspect = require "inspect"

local function create_spaces(self)
  self.spaces = {}
  for i = 1, self.size^2 do
    self.spaces[i] = tostring(i)
  end
end

local function segment_columns(self)
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

local function segment_left_diagonal(self)
  local segment = {}

  for j = 1, self.size do
    incrementer = (j - 1) * (self.size + 1)
    next_index = 1 + incrementer
    segment[j] = self.spaces[next_index]
  end

  return { segment }
end

local function segment_right_diagonal(self)
  local segment = {}

  for j = 1, self.size do
    incrementer = (j - 1) * (self.size - 1)
    next_index = self.size + incrementer
    segment[j] = self.spaces[next_index]
  end

  return { segment }
end

function Board:new(size)
  local o = {}
  o.size = size
  setmetatable(o, self)
  self.__index = self
  o.board = create_spaces(o)
  return o
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

function Board:available_spaces()
  available_spaces = {}

  for _, space in ipairs(self.spaces) do
    if string.find(space, "^%d") then table.insert(available_spaces, space) end
  end

  return available_spaces
end

function Board:has_available_space()
  return #self:available_spaces() > 0
end

return Board