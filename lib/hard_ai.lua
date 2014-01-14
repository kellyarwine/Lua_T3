local inspect = require "inspect"
local rules = require "rules"

local Hard_AI = {}

local draw_score = 0
local win_score = 1
local lose_score = -1

local function max_value_position(input_table)
  -- if #input_table == 0 then table.insert(input_table, 0) end

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
  print(get_other_gamepiece(self))
  scores = self:minimax({ self.gamepiece, get_other_gamepiece(self) })
  print(inspect(self.board:available_spaces()))
  print("-----scores--------")
  print(inspect(scores))
  print("max value: " .. max_value_position(scores))
  print(self.board:available_spaces()[max_value_position(scores)])
  local max_value_position = max_value_position(scores)
  return tonumber(self.board:available_spaces()[max_value_position])
end

function Hard_AI:minimax(gamepieces)
  local scores = {}
  local available_spaces = self.board:available_spaces()
  print("available spaces are: " .. inspect(available_spaces))
  for i, space in ipairs(self.board:available_spaces()) do
    if #self.board:available_spaces() == 3 then print("=============DETERMINING SPACE " .. space .. "======================") end
    print("before " .. inspect(self.board.spaces))
    self.board.spaces[tonumber(space)] = gamepieces[1]
    print("after " .. inspect(self.board.spaces))
    print("i= " .. i)
    print("space= " .. space)
    self.i = i
    self.depth = self.depth + 1
    print("---------self.depth----------")
    print("depth: " .. tostring(self.depth))
    local score = self:score_board(gamepieces)
    print("FINAL SCORE: " .. tostring(score))
    self:unwind_board(space)
    self.depth = self.depth - 1
    print("FINAL SCORES: " .. inspect(scores))
    print("end of loop " .. i)
    table.insert(scores, score)
  end

  return scores
end

function Hard_AI:score_board(gamepieces)
  local scores = {}
  -- reverse(gamepieces)
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
    scores = self:minimax(reverse(gamepieces))
    if #scores == 0 then return 0 else return self:pick_score(scores, gamepieces) end
  end
end


function Hard_AI:unwind_board(initial_space)
  print("initial space " .. initial_space)
  print("before unwind " .. inspect(self.board.spaces))
  -- print("before unwind " .. inspect(gamepieces))
  self.board.spaces[tonumber(initial_space)] = initial_space
  -- reverse(gamepieces)
  print("after unwind " .. inspect(self.board.spaces))
  -- print("after unwind " .. inspect(gamepieces))
  print("i= " .. self.i)
end

function Hard_AI:score_win()
  if rules.winning_gamepiece(self.board) == nil then
    print("draw" .. inspect(self.board.spaces))
    return draw_score/self.depth
  elseif rules.winning_gamepiece(self.board) == self.gamepiece then
    print("we won!!!!!" .. inspect(self.board.spaces) .. " - " ..  rules.winning_gamepiece(self.board) .. "wins!" )
    return win_score/self.depth
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

-- function Hard_AI:maximum_depth()
--   if self.original_available_count >= 1 and self.original_available_count <= 4 then
--     return 5
--   elseif self.original_available_count >= 5 and self.original_available_count <= 8 then
--     return 4
--   else
--     return 2
--   end
-- end

-- def maximum_depth(original)
--         case original
--           when 1..4 then 4
--           when 5..8 then 5
--           else 2
--         end
--       end

function Hard_AI:pick_score(scores, gamepieces)
  if self.gamepiece == gamepieces[1] then
    return math.min(unpack(scores))
  else
    return math.max(unpack(scores))
  end
end

return Hard_AI