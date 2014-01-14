local Configurations = require "configurations"
local Game = require "game"
local inspect = require "inspect"
local messages = require "messages"
local validations = require "validations"


local function play_again_prompt(self)
  self.in_out:write(messages.play_again_prompt(validations.play_again_options))
  local user_input = string.lower(self.in_out:read())

  if validations.is_invalid("play_again", user_input) then
    self.in_out:write(messages.invalid_selection)
    return play_again_prompt(self)
  else
    return user_input
  end
end

local Game_Runner = {}

function Game_Runner:new(in_out)
  local o = { in_out = in_out }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Game_Runner:configure_game()
  self.in_out:write(messages.welcome)
  self.configurations = Configurations:new(self.in_out)
  self.configurations:configure_game()
  self.game = Game:new(self.configurations)
end

function Game_Runner:play_game()
  self.game:setup()
  self.game:loop()

  if play_again_prompt(self) == "yes" then
    self:configure_game()
    self:play_game()
  end
end

return Game_Runner