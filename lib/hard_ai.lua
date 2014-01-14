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
  print(inspect(self.board:available_spaces()))
  print("-----scores--------")
  print(inspect(scores))
  print(max_value_position(scores))
  print(self.board:available_spaces()[max_value_position(scores)])
  local max_value_position = max_value_position(scores)
  return tonumber(self.board:available_spaces()[max_value_position])
end

function Hard_AI:minimax()
  local scores = {}
  local available_spaces = self.board:available_spaces()
  print("available spaces are: " .. inspect(available_spaces))
  for i, space in ipairs(self.board:available_spaces()) do
    print("before " .. inspect(self.board.spaces))
    self.board.spaces[tonumber(space)] = self:current_gamepiece()
    print("after " .. inspect(self.board.spaces))
    print("i= " .. i)
    print("space= " .. space)
    self.i = i
    print("current gamepiece: " .. self:current_gamepiece())
    self.depth = self.depth + 1
    print("---------self.depth----------")
    print("depth: " .. tostring(self.depth))
    local score = self:score_board()
    print("still score_win (score_board): " .. tostring(score))
    table.insert(scores, score)
    print("scores are: " .. inspect(scores))
    self:unwind_board(space)
    self.depth = self.depth - 1
    print("end of loop " .. i)
  end

  return scores
end

function Hard_AI:score_board()
  local scores = {}
  self:reverse_gamepieces()
  print("is game over? " .. tostring(rules.is_game_over(self.board)) .. " " .. inspect(self.board.spaces))
  if rules.is_game_over(self.board) then
    print("game is over")
    local test = self:score_win()
    print("----------score_win-----------")
    print("score_win:" .. tostring(test))
    print("i= " .. self.i)
    return test
  elseif self.depth <= self:maximum_depth() then
    print("in else clause")
    scores = self:minimax()
    if #scores == 0 then return 0 else return self:pick_score(scores) end
  end
end

function Hard_AI:reverse_gamepieces()
  self.gamepieces = { self.gamepieces[2], self.gamepieces[1] }
end

function Hard_AI:unwind_board(initial_space)
  print("initial space " .. initial_space)
  print("before unwind " .. inspect(self.board.spaces))
  print("before unwind " .. inspect(self.gamepieces))
  self.board.spaces[tonumber(initial_space)] = initial_space
  self:reverse_gamepieces()
  print("after unwind " .. inspect(self.board.spaces))
  print("after unwind " .. inspect(self.gamepieces))
  print("i= " .. self.i)
end

function Hard_AI:score_win()
  if rules.winning_gamepiece(self.board) == self.gamepiece then
    print("winning gamepiece: " .. rules.winning_gamepiece(self.board))
    -- print(inspect(self.board.spaces))
    -- print(rules.winning_gamepiece(self.board))
    -- print(self.gamepiece)
    -- (print "---------------self.depth----------")
    -- print(self.depth)
    -- (print "---------------win_score----------")
    -- print(win_score)
    -- (print "---------------win_score/self.depth----------")
    -- print(win_score/self.depth)
    print("we won!!!!!")
    return win_score/self.depth
  elseif rules.winning_gamepiece(self.board) == nil then
    print("draw")
    return draw_score/self.depth
  else
    print("we lost: " .. inspect(self.board.spaces))
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

function Hard_AI:pick_score(scores)
  if self.gamepiece == self:current_gamepiece() then
    return math.min(unpack(scores))
  else
    return math.max(unpack(scores))
  end
end

return Hard_AI