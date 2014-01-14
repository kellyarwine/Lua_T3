local inspect = require "inspect"

local validation_functions = {}
local validations = {}

validations.player_types = { "human", "easy ai", "hard ai" }
validations.turn_order_options = { "player 1", "player 2" }
validations.play_again_options = { "no", "yes" }
validations.minimum_board_size = 3
validations.maximum_board_size = 10

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

local function is_space_open(board, user_input)
  local lookup_value = tonumber(board.spaces[user_input])
  return lookup_value ~= nil
end

local function in_board_range(board, user_input)
  return user_input >= 1 and user_input <= #board.spaces
end

function validation_functions.play_again(user_input)
  for _, play_again_option in ipairs(validations.play_again_options) do
    if play_again_option == user_input then return true end
  end
end

function validation_functions.player(user_input)
  if user_input == nil then return false end

  for _, player_type in ipairs(validations.player_types) do
    if player_type == user_input then return true end
  end

  return false
end

function validation_functions.turn_order(user_input)
  for _, turn_order_option in ipairs(validations.turn_order_options) do
    if turn_order_option == user_input then return true end
  end
end

function validation_functions.board_size(user_input)
  return user_input >= validations.minimum_board_size
         and user_input <= validations.maximum_board_size
end

function validation_functions.gamepiece(user_input, existing_gamepiece)
  return is_length_of_one(user_input)
         and is_character(user_input)
         and is_unique_gamepiece(user_input, existing_gamepiece)
end

function validation_functions.move(board, user_input)
  if user_input == nil then return false end

  return in_board_range(board, user_input)
         and is_space_open(board, user_input)
end

local function is_valid(func, ...)
  return validations.get_validation_function(func, ...)
end

function validations.get_validation_function(func, ...)
  local arg_1, arg_2 = ...

  if arg_1 == nil then return false end

  return validation_functions[func](arg_1, arg_2)
end

function validations.is_invalid(func, ...)
  return not is_valid(func, ...)
end

return validations