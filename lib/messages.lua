local inspect = require "inspect"
local utils = require "utils"

local messages = {}

local cell_width           = 5
local cell_padding         = " "
local horizontal_grid_line = "-"
local grid_crosshairs      = "+"
local vertical_grid_line   = "|"
local new_line             = "\n"
local partial_make_move    = "Please take your next move (enter a number 1 - "
messages.welcome           = "Great.  You're here.  Ready to lose?\n\n"
messages.invalid_selection = "Yeah, that's not gonna work.  You'll have to do better than that.\n\n"
messages.win               = "Lucky chance.  You win.\n\n"
messages.lose              = "You're a loser.  I figured as much.\n\n"
messages.cats              = "This game's a tie.  But now I've got you figured out.\n\n"
messages.play_again_prompt = "Ready to go again?\n\n"


local function build_header_footer(board)
  local header_footer = {}

  for i = 1, board.size do
    header_footer[i] = utils.multiply_string(cell_padding, cell_width)
  end

  return table.concat(header_footer, vertical_grid_line) .. new_line
end

local function build_cell(cell_value)
  local cell_padding_amt = cell_width - 1
  local left_right_padding_amt = utils.multiply_string(cell_padding, cell_padding_amt/2)
  return left_right_padding_amt .. cell_value .. left_right_padding_amt
end

local function build_row_data(segment)
  local cells = utils.map(build_cell, segment)
  return table.concat(cells, vertical_grid_line) .. new_line
end

local function build_row_border(board)
  local cell_border = {}

  for i = 1, board.size do
    cell_border[i] = utils.multiply_string(horizontal_grid_line, cell_width)
  end

  return table.concat(cell_border, grid_crosshairs) .. new_line
end

function messages.build_board(board)
  local segments = board:segment_rows()
  local grid_data = utils.map(build_row_data, segments)
  local grid_row_border = build_row_border(board)
  local grid_header_footer = build_header_footer(board)
  local gameboard = table.concat(grid_data, grid_row_border)
  return grid_header_footer .. gameboard .. grid_header_footer
end

function messages.get_move_prompt(board)
  return "Please make your next move (enter a number 1 - " ..
         #board.spaces .. "):\n"
end

return messages