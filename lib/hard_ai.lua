local inspect = require "inspect"
local rules = require "rules"

local Hard_AI = {}

local draw_score = 0
local win_score = 1
local lose_score = -1

local function max_value_position(input_table)
  if #input_table then table.insert(input_table, 0) end

  local max_value = math.max(unpack(input_table))
  for i, v in ipairs(input_table) do
    if v == max_value then return i end
  end
end

function Hard_AI:current_gamepiece()
  return self.gamepieces[1]
end

function Hard_AI:new(gamepiece, in_out, board, gamepieces)
  local o = {}
  o.gamepiece = gamepiece
  o.board = board
  o.gamepieces = gamepieces
  o.label = "Computer"
  setmetatable(o, self)
  self.__index = self
  return o
end

function Hard_AI:get_move()
  self.depth = 0
  self.original_available_count = #self.board:available_spaces()
  scores = self:minimax()
  local max_value_position = max_value_position(scores)
  return tonumber(self.board:available_spaces()[max_value_position])
end

function Hard_AI:minimax()
  local scores = {}
  local available_spaces = self.board:available_spaces()

  for i, space in ipairs(self.board:available_spaces()) do
    self.board.spaces[tonumber(space)] = self:current_gamepiece()
    self.depth = self.depth + 1
    local score = self:score_board()
    table.insert(scores, score)
    self:unwind_board(space)
    self.depth = self.depth - 1
  end

  return scores
end

function Hard_AI:score_board()
  local scores = {}
  self:reverse_gamepieces()

  if rules.is_game_over(self.board) then
    return self:score_win()
  elseif self.depth <= self:maximum_depth() then
    scores = self:minimax()
    if #scores == 0 then return 0 else return self:pick_score(scores) end
  end
end

function Hard_AI:reverse_gamepieces()
  self.gamepieces = { self.gamepieces[2], self.gamepieces[1] }
end

function Hard_AI:unwind_board(initial_space)
  self.board.spaces[tonumber(initial_space)] = initial_space
  self:reverse_gamepieces()
end

function Hard_AI:score_win()
  if rules.winning_gamepiece(self.board) == self.gamepiece then
    return win_score/self.depth
  elseif rules.winning_gamepiece(self.board) == nil then
    return draw_score/self.depth
  else
    return lose_score/self.depth
  end
end

function Hard_AI:maximum_depth()
  if self.original_available_count >= 1 and self.original_available_count <= 6 then
    return 5
  elseif self.original_available_count >= 7 and self.original_available_count <= 8 then
    return 4
  else
    return 2
  end
end

function Hard_AI:pick_score(scores)
  if self.gamepiece == self:current_gamepiece() then
    return math.min(unpack(scores))
  else
    return math.max(unpack(scores))
  end
end

return Hard_AI