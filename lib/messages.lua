local inspect = require "inspect"
local utils = require "utils"

local cell_width                      = 5
local cell_padding_symbol             = " "
local horizontal_grid_line            = "-"
local grid_crosshairs                 = "+"
local vertical_grid_line              = "|"
local new_line                        = "\n"
local partial_make_move               = "%s, make your move (enter a number 1 - %d):\n"
local partial_board_size_prompt       = "Choose the size of the gameboard (enter a number %d - %d):\n"
local partial_player_selection_prompt = "Choose Player %d's player type (enter '%s'):\n"
local partial_turn_order_prompt       = "Choose which player goes first (enter '%s'):\n"
local partial_play_again_prompt       = "Ready to go again? (Enter '%s'.)\n"
local partial_gamepiece_prompt        = "Choose any single letter to be the gamepiece for Player %d:\n"
local partial_win                     = "%s wins.  Whoop.Dee.Do.\n\n"
local cats                            = "This game's a tie.  Better luck next time.\n\n"

local function cell_padding(cell_value, type)
  local cell_padding_amt = cell_width - #cell_value
  local cell_padding_amt_part = 0

  if cell_padding_amt % 2 == 0 then
    cell_padding_amt_part = cell_padding_amt/2
  elseif type == "left" then
    cell_padding_amt_part = math.floor(cell_padding_amt/2) + 1
  else
    cell_padding_amt_part = math.floor(cell_padding_amt/2)
  end

  return utils.multiply_string(tostring(cell_padding_symbol), cell_padding_amt_part)
end

local function build_cell(cell_value)
  local left_padding = cell_padding(cell_value, "left")
  local right_padding = cell_padding(cell_value, "right")
  return left_padding .. cell_value .. right_padding
end


local function build_row_data(segment)
  local cells = utils.map(build_cell, segment)
  return table.concat(cells, vertical_grid_line) .. new_line
end

local function build_header_footer(board)
  local header_footer = {}

  for i = 1, board.size do
    header_footer[i] = utils.multiply_string(cell_padding_symbol, cell_width)
  end

  return table.concat(header_footer, vertical_grid_line) .. new_line
end

local function build_row_border(board)
  local cell_border = {}

  for i = 1, board.size do
    cell_border[i] = utils.multiply_string(horizontal_grid_line, cell_width)
  end

  return table.concat(cell_border, grid_crosshairs) .. new_line
end

local messages = {}

messages.welcome                      = "Great.  You're here.  Ready to lose?\n\n"
messages.invalid_selection            = "Yeah, that's not gonna work.  You'll have to do better than that.\n"

function messages.build_board(board)
  local segments = board:segment_rows()
  local grid_data = utils.map(build_row_data, segments)
  local grid_row_border = build_row_border(board)
  local grid_header_footer = build_header_footer(board)
  local gameboard = table.concat(grid_data, grid_row_border)
  return grid_header_footer .. gameboard .. grid_header_footer .. new_line
end

function messages.move_prompt(player, board)
  return string.format(partial_make_move, player.label, #board.spaces)
end

function messages.board_size_prompt(minimumu_board_size, maximum_board_size)
  return string.format(partial_board_size_prompt, minimumu_board_size, maximum_board_size)
end

function messages.player_selection_prompt(available_player_types, player_order)
  player_types_string = table.concat(available_player_types, "' or '")
  return string.format(partial_player_selection_prompt, player_order, player_types_string)
end

function messages.gamepiece_prompt(player_order)
  return string.format(partial_gamepiece_prompt, player_order)
end


function messages.turn_order_prompt(turn_order_options)
  local turn_orders_string = table.concat(turn_order_options, "' or '")
  return string.format(partial_turn_order_prompt, turn_orders_string)
end

function messages.play_again_prompt(play_again_options)
  local play_again_options_string = table.concat(play_again_options, "' or '")
  return string.format(partial_play_again_prompt, play_again_options_string)
end

function messages.win(winning_gamepiece)
  return string.format(partial_win, winning_gamepiece)
end

function messages.cats()
  return cats
end

return messages