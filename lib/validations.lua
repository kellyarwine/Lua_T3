local inspect = require "inspect"
local function is_character(user_input)
  local character_pattern = '%a'
  return string.find(user_input, character_pattern) ~= nil
end

local function is_length_of_one(user_input)
  return #user_input == 1
end

local function is_unique_gamepiece(user_input, existing_gamepiece)
  return existing_gamepiece == nil
         or user_input ~= existing_gamepiece
end

local function is_space_open(user_input, board_spaces)
  local lookup_value = tonumber(board_spaces[user_input])
  return lookup_value ~= nil
end

local function in_board_range(user_input, board_spaces)
  return user_input >= 1 and user_input <= #board_spaces
end



local validations = {}

validations.player_options = { "human", "easy ai", "hard ai" }
validations.turn_order_options = { "player 1", "player 2", "1", "2" }
validations.yes_no_options = { "no", "yes", "y", "n" }
validations.board_range = { 3, 10 }
validations.game_loop_range = { 1, 2000 }

function validations.choice(user_input, available_options)
  if user_input == nil then return false end

  for _, available_option in ipairs(validations[available_options]) do
    if user_input == available_option then return true end
  end

  return false
end

function validations.in_range(user_input, range)
  return user_input >= validations[range][1]
         and user_input <= validations[range][2]
end

function validations.gamepiece(user_input, existing_gamepiece)
  return is_length_of_one(user_input)
         and is_character(user_input)
         and is_unique_gamepiece(user_input, existing_gamepiece)
end

function validations.move(user_input, board_spaces)
  if user_input == nil then return false end

  return in_board_range(user_input, board_spaces)
         and is_space_open(user_input, board_spaces)
end

function validations.is_valid(user_input, ...)
  local func, arg_1, arg_2 = unpack( ... )

  if user_input == nil or func == nil then return false end

  return validations[func](user_input, arg_1)
end

function validations.is_invalid(user_input, ...)
  return not validations.is_valid(user_input, ...)
end

return validations