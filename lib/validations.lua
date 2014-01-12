inspect = require "inspect"

validations = {}

local integer_identifier = "%d"

local function is_integer(user_input)
  return string.find(user_input, integer_identifier) ~= nil
end

local function is_nil(user_input)
  return user_input == nil
end


local function in_board_range(board, user_input)
  return user_input >= 1 and user_input <= #board.spaces
end

local function is_space_open(board, user_input)
  local lookup_value = tonumber(board.spaces[user_input])
  return lookup_value ~= nil
end

function validations.is_valid_move(board, user_input)
  return not is_nil(user_input)
         and is_integer(user_input)
         and in_board_range(board, user_input)
         and is_space_open(board, user_input)
end

return validations