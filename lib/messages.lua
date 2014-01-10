local utils = require "utils"

local Messages = {}

Messages.cell_width            = 5
Messages.cell_padding          = " "
Messages.horizontal_grid_line  = "-"
Messages.grid_crosshairs       = "+"
Messages.vertical_grid_line    = "|"
Messages.new_line              = "\n"
Messages.welcome               = "Great.  You're here.  Ready to lose?\n"

function Messages.build_board(board)
  local segments = board:segment()
  local grid_data = utils.map(Messages.build_row_data, segments)
  local grid_row_border = Messages.build_row_border(board)
  local grid_header_footer = Messages.build_header_footer(board)
  local gameboard = table.concat(grid_data, grid_row_border)
  return grid_header_footer .. gameboard .. grid_header_footer
end

function Messages.build_header_footer(board)
  header_footer = {}

  for i = 1, board.size do
    header_footer[i] = utils.multiply_string(Messages.cell_padding, Messages.cell_width)
  end

  return table.concat(header_footer, Messages.vertical_grid_line) .. Messages.new_line
end

function Messages.build_row_data(segment)
  local cells = utils.map(Messages.build_cell, segment)
  return table.concat(cells, Messages.vertical_grid_line) .. Messages.new_line
end

function Messages.build_cell(cell_value)
  cell_padding_amt = Messages.cell_width - 1
  left_right_padding_amt = utils.multiply_string(Messages.cell_padding, cell_padding_amt/2)
  return left_right_padding_amt .. cell_value .. left_right_padding_amt
end

function Messages.build_row_border(board)
  cell_border = {}

  for i = 1, board.size do
    cell_border[i] = utils.multiply_string(Messages.horizontal_grid_line, Messages.cell_width)
  end

  return table.concat(cell_border, Messages.grid_crosshairs) .. Messages.new_line
end

return Messages