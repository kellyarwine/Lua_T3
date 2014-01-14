local inspect = require "inspect"
local rules = require "rules"

local Hard_AI = {}

local draw_score = 0
local win_score = 1
local lose_score = -1

local function max_value_position(input_table)
  local max_value = math.max(unpack(input_table))

  for i, v in ipairs(input_table) do
    if v == max_value then return i end
  end
end

local function reverse(gamepieces)
  return { gamepieces[2], gamepieces[1] }
end

function Hard_AI:new(gamepiece, in_out, board)
  local o = {}
  o.gamepiece = gamepiece
  o.board = board
  o.label = "Computer"
  setmetatable(o, self)
  self.__index = self
  return o
end

local function get_other_gamepiece(self)
  for _, space in ipairs(self.board.spaces) do
    if space ~= self.gamepiece and string.find(space, "^%a") ~= nil then return space end
  end
end

function Hard_AI:get_move()
  self.depth = 0
  self.original_available_count = #self.board:available_spaces()
  scores = self:minimax({ self.gamepiece, get_other_gamepiece(self) })
  local max_value_position = max_value_position(scores)
  return tonumber(self.board:available_spaces()[max_value_position])
end

function Hard_AI:minimax(gamepieces)
  local scores = {}
  local available_spaces = self.board:available_spaces()

  for i, space in ipairs(self.board:available_spaces()) do
    self.board.spaces[tonumber(space)] = gamepieces[1]
    self.i = i
    self.depth = self.depth + 1
    local score = self:score_board(gamepieces)
    self:unwind_board(space)
    self.depth = self.depth - 1
    table.insert(scores, score)
  end

  return scores
end

function Hard_AI:score_board(gamepieces)
  local scores = {}

  if rules.is_game_over(self.board) then
    return self:score_win()
  elseif self.depth <= self:maximum_depth() then
    scores = self:minimax(reverse(gamepieces))
    -- return self:pick_score(scores, gamepieces)
    if #scores == 0 then return 0 else return self:pick_score(scores, gamepieces) end
  end
end


function Hard_AI:unwind_board(initial_space)
  self.board.spaces[tonumber(initial_space)] = initial_space
end

function Hard_AI:score_win()
  if rules.winning_gamepiece(self.board) == nil then
    return draw_score/self.depth
  elseif rules.winning_gamepiece(self.board) == self.gamepiece then
    return win_score/self.depth
  else
    return lose_score/self.depth
  end
end

function Hard_AI:maximum_depth()
  if self.original_available_count >= 1 and self.original_available_count <= 4 then
    return 4
  elseif self.original_available_count >= 5 and self.original_available_count <= 8 then
    return 5
  else
    return 2
  end
end

function Hard_AI:pick_score(scores, gamepieces)
  if self.gamepiece == gamepieces[1] then
    return math.min(unpack(scores))
  else
    return math.max(unpack(scores))
  end
end

return Hard_AI