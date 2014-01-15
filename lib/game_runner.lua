local Configurations = require "configurations"
local Game = require "game"
local messages = require "messages"
local Prompter = require "prompter"
local validations = require "validations"

local function play_again_prompt(self)
  local prompt_message = messages.play_again_prompt(validations.yes_no_options)
  return self.prompter:prompt(prompt_message, string.lower, { "choice", "yes_no_options" })
end

local function same_configurations_prompt(self)
  local prompt_message = messages.same_configurations_prompt(validations.yes_no_options)
  return self.prompter:prompt(prompt_message, string.lower, { "choice", "yes_no_options" })
end

local function loop_number_prompt(self)
  local prompt_message = messages.loop_number_prompt(validations.game_loop_range)
  return self.prompter:prompt(prompt_message, tonumber, { "in_range", "game_loop_range" })
end

local Game_Runner = {}

function Game_Runner:play_game()
  self.game:loop()
  local play_again_user_input = play_again_prompt(self)

  if play_again_user_input == "yes" then
    same_configurations_user_input = same_configurations_prompt(self)

    if same_configurations_user_input == "yes" then

      for i = 1, loop_number_prompt(self) do
        self.game.board:reset()
        self.game:loop()
      end

    elseif play_again_prompt(self) == "yes"
           and same_configurations_prompt(self) == "no" then
      self:play_game()
    end
  end
end

function Game_Runner:configure_game()
  self.configurations = Configurations:new(self.in_out, self.prompter)
  self.configurations:configure_game()
  self.game = Game:new(self.configurations)
end

function Game_Runner:new(in_out)
  local o = { in_out = in_out }
  o.prompter = Prompter:new(o.in_out)
  setmetatable(o, self)
  self.__index = self
  return o
end

return Game_Runner