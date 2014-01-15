local messages = require "messages"
local rules = require "rules"
local validations = require "validations"


local function swap_current_player(self)
  self.players = { self.players[2], self.players[1] }
end

local function current_player(self)
  return self.players[1]
end

local function display_game_decision(self)
  local decision, winning_gamepiece = rules.get_game_decision(self.board)
  self.in_out:write(messages[decision](winning_gamepiece))
end

local function display_board(self)
  self.in_out:write(messages.build_board(self.board))
end

local function place_move(self, move)
  self.board.spaces[move] = self.players[1].gamepiece
end

local function get_move(self)
  self.in_out:write(messages.move_prompt(current_player(self), self.board))
  local user_input = current_player(self):get_move()
  if validations.is_invalid(user_input, { "move", self.board.spaces } ) then
    self.in_out:write(messages.invalid_selection)
    return get_move(self)
  else
    return user_input
  end
end


local Game = {}

function Game:loop()
  while rules.is_game_over(self.board) == false do
    display_board(self)
    local move = get_move(self)
    place_move(self, move)
    swap_current_player(self)
  end

  display_board(self)
  display_game_decision(self)
end

function Game:new(configurations)
  local o = {}
  self.in_out = configurations.in_out
  self.board = configurations.board
  self.player_1 = configurations.player_1
  self.player_2 = configurations.player_2
  self.players = configurations.players
  setmetatable(o, self)
  self.__index = self
  return o
end

return Game