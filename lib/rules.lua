local function segment_winning_gamepiece(board_segment)
  for i = 1, #board_segment - 1 do
    if board_segment[i] ~= board_segment[i + 1] then return nil end
  end

  return board_segment[1]
end



local rules = {}

function rules.get_game_decision(board)
  if rules.winning_gamepiece(board) then
    return "win", rules.winning_gamepiece(board)
  else
    return "cats"
  end
end

function rules.winning_gamepiece(board)
  local board_segments = board:segment()

  for _, board_segment in ipairs(board_segments) do
    local winning_gamepiece = segment_winning_gamepiece(board_segment)
    if winning_gamepiece then return winning_gamepiece end
  end

  return nil
end

function rules.is_game_over(board)
  return rules.winning_gamepiece(board) ~= nil
         or #board:available_spaces() == 0
end

return rules