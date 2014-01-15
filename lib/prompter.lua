local messages = require "messages"
local validations = require "validations"

local Prompter = {}

function Prompter:prompt(prompt_message, format_func, validation_args)
  self.in_out:write(prompt_message)
  local user_input = format_func(self.in_out:read())

  if validations.is_invalid(user_input, validation_args) then
    self.in_out:write(messages.invalid_selection)
    return self:prompt(prompt_message, format_func, validation_args)
  else
    return user_input
  end
end

function Prompter:new(in_out)
  local o = { in_out = in_out }
  setmetatable(o, self)
  self.__index = self
  return o
end

return Prompter