local utils = require "utils"

local messages = {}

messages.cell_width            = 5
messages.cell_padding          = " "
messages.horizontal_grid_line  = "-"
messages.grid_crosshairs       = "+"
messages.vertical_grid_line    = "|"
messages.new_line              = "\n"
messages.welcome               = "Great.  You're here.  Ready to lose?\n"
messages.partial_make_move     = "Please take your next move (enter a number 1 - "
messages.win                   = "Lucky chance.  You win.\n"
messages.lose                  = "You're a loser.  I figured as much.\n"
messages.cats                  = "This game's a tie.  But now I've got you figured out.\n"
messages.play_again_prompt     = "Ready to go again?\n"


function messages.build_board(board)
  local segments = board:segment_rows()
  local grid_data = utils.map(messages.build_row_data, segments)
  local grid_row_border = messages.build_row_border(board)
  local grid_header_footer = messages.build_header_footer(board)
  local gameboard = table.concat(grid_data, grid_row_border)
  return grid_header_footer .. gameboard .. grid_header_footer
end

function messages.build_header_footer(board)
  header_footer = {}

  for i = 1, board.size do
    header_footer[i] = utils.multiply_string(messages.cell_padding, messages.cell_width)
  end

  return table.concat(header_footer, messages.vertical_grid_line) .. messages.new_line
end

function messages.build_row_data(segment)
  local cells = utils.map(messages.build_cell, segment)
  return table.concat(cells, messages.vertical_grid_line) .. messages.new_line
end

function messages.build_cell(cell_value)
  cell_padding_amt = messages.cell_width - 1
  left_right_padding_amt = utils.multiply_string(messages.cell_padding, cell_padding_amt/2)
  return left_right_padding_amt .. cell_value .. left_right_padding_amt
end

function messages.build_row_border(board)
  cell_border = {}

  for i = 1, board.size do
    cell_border[i] = utils.multiply_string(messages.horizontal_grid_line, messages.cell_width)
  end

  return table.concat(cell_border, messages.grid_crosshairs) .. messages.new_line
end

function messages.make_move_prompt(board)
  return "Please take your next move (enter a number 1 - " ..
         #board.spaces .. "):\n"
end

function messages.game_decision(decision)
  return messages[decision]
end

return messages