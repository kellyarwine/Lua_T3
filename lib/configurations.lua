local Board = require "board"
local inspect = require "inspect"
local messages = require "messages"
local validations = require "validations"

local Configurations = {}

function Configurations:new(in_out)
  local o = { in_out = in_out }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Configurations:configure_game()
  self:configure_board()
  self:configure_players()
  self:configure_turn_order()
end

local function gamepiece_prompt(self, player_order, existing_gamepiece)
  self.in_out:write(messages.gamepiece_prompt(player_order))
  local user_input = self.in_out:read()

  if validations.is_invalid("gamepiece", user_input, existing_gamepiece) then
    self.in_out:write(messages.invalid_selection)
    return gamepiece_prompt(self, player_order, existing_gamepiece)
  else
    return user_input
  end
end

function Configurations:configure_board()
  self.board = Board:new(self:board_size_prompt())
end

function Configurations:board_size_prompt()
  self.in_out:write(messages.board_size_prompt(validations.minimum_board_size, validations.maximum_board_size))
  local user_input = tonumber(self.in_out:read())

  if validations.is_invalid("board_size", user_input) then
    self.in_out:write(messages.invalid_selection)
    return self:board_size_prompt()
  else
    return user_input
  end
end

local function update_player_2_label(self)
  if self.player_1.label == self.player_2.label then
    self.player_2.label = self.player_2.label .. " 2"
  end
end

function Configurations:configure_players()
  self:create_player(1)
  self:create_player(2, self.player_1.gamepiece)
  self.players = { self.player_1, self.player_2 }
  update_player_2_label(self)
end

function Configurations:create_player(player_position, other_player_gamepiece)
  local player_type_selected = require(self:player_selection_prompt(player_position))
  local gamepiece_selected = gamepiece_prompt(self, player_position, other_player_gamepiece)
  local player = ("player_" .. player_position)
  self[player] = player_type_selected:new(gamepiece_selected, self.in_out, self.board)
end

function Configurations:player_selection_prompt(player_order)
  self.in_out:write(messages.player_selection_prompt(validations.player_types, player_order))
  local user_input = string.lower(self.in_out:read())

  if validations.is_invalid("player", user_input) then
    self.in_out:write(messages.invalid_selection)
    return self:player_selection_prompt(player_order)
  else
    return string.gsub(user_input, " ", "_")
  end
end

function Configurations:configure_turn_order()
  local turn_order = self:turn_order_prompt()

  if string.upper(turn_order) ~= "player 1" then
    self.players = { self.players[2], self.players[1] }
  end
end

function Configurations:turn_order_prompt()
  self.in_out:write(messages.turn_order_prompt(validations.turn_order_options))
  local user_input = string.lower(self.in_out:read())

  if validations.is_invalid("turn_order", user_input) then
    self.in_out:write(messages.invalid_selection)
    return self:turn_order_prompt()
  else
    return string.gsub(user_input, " ", "_")
  end
end

return Configurations