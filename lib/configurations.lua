local Board = require "board"
local messages = require "messages"
local validations = require "validations"

local function update_player_2_label(self)
  if self.player_1.label == self.player_2.label then
    self.player_2.label = self.player_2.label .. " 2"
  end
end

local function gamepiece_prompt(self, player_order, existing_gamepiece)
  local prompt_message = messages.gamepiece_prompt(player_order)
  return self.prompter:prompt(prompt_message, string.lower, { "gamepiece", existing_gamepiece })
end

function player_selection_prompt(self, player_order)
  local prompt_message = messages.player_selection_prompt(validations.player_options, player_order)
  local user_input = self.prompter:prompt(prompt_message, string.lower, { "choice", "player_options" })
  return string.gsub(user_input, " ", "_")
end
local function board_size_prompt(self)
  local prompt_message = messages.board_size_prompt(validations.board_range)
  return self.prompter:prompt(prompt_message, tonumber, { "in_range", "board_range" })
end

local function create_player(self, player_position, other_player_gamepiece)
  local player_type_selected = require(player_selection_prompt(self, player_position))
  local gamepiece_selected = gamepiece_prompt(self, player_position, other_player_gamepiece)
  local player = ("player_" .. player_position)
  self[player] = player_type_selected:new(gamepiece_selected, self.in_out, self.board)
end

local function configure_turn_order(self)
  local prompt_message = messages.turn_order_prompt(validations.turn_order_options)
  local user_input = self.prompter:prompt(prompt_message, string.lower, { "choice", "turn_order_options" })

  if string.gsub(user_input, " ", "_") ~= "player_1" and user_input ~= "1" then
    self.players = { self.players[2], self.players[1] }
  end
end

local function configure_players(self)
  create_player(self, 1)
  create_player(self, 2, self.player_1.gamepiece)
  self.players = { self.player_1, self.player_2 }
  update_player_2_label(self)
end

local function configure_board(self)
  self.board = Board:new(board_size_prompt(self))
end



local Configurations = {}

function Configurations:configure_game()
  self.in_out:write(messages.configurations_welcome)
  configure_board(self)
  configure_players(self)
  configure_turn_order(self)
end

function Configurations:new(in_out, prompter)
  local o = { in_out = in_out, prompter = prompter }
  setmetatable(o, self)
  self.__index = self
  return o
end

return Configurations