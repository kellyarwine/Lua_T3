inspect = require "inspect"
utils = require "utils"

local Game_Rules = {}

function Game_Rules.is_game_over(board)
  return Game_Rules.winning_gamepiece(board) ~= nil
         or board:has_available_space() == false
end

function Game_Rules.get_game_decision(board)
  if Game_Rules.winning_gamepiece(board) ~= nil then
    return "win"
  else
    return "cats"
  end
end

function Game_Rules.winning_gamepiece(board)
  board_segments = board:segment()
  for _, board_segment in ipairs(board_segments) do
    local winning_gamepiece = Game_Rules.segment_winning_gamepiece(board_segment)

    if winning_gamepiece ~= nil then
      return winning_gamepiece
    end

  end

  return nil
end

function Game_Rules.segment_winning_gamepiece(board_segment)
  for i = 1, (#board_segment - 1) do
    if board_segment[i] ~= board_segment[i + 1] then return nil end
  end

  return board_segment[1]
end

return Game_Rules