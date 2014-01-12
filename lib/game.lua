Board = require "board"
rules = require "rules"
inspect = require "inspect"
messages = require "messages"
validations = require "validations"

Game = {}

function Game:new(in_out)
  local o = { in_out = in_out }
  setmetatable(o, self)
  self.__index = self
  o:setup()
  return o
end

function Game:setup()
  self.board = Board:new(3)
  self:display_welcome()
end

function Game:play()
  while rules.is_game_over(self.board) == false do
    self:display_board()
    local move = self:get_move()
    self:place_move(move)
  end

  self:display_board()
  self:display_game_decision()
  self:display_play_again()
end

function Game:display_welcome()
  self.in_out:write(messages.welcome)
end

function Game:display_board()
  self.in_out:write(messages.build_board(self.board))
end

function Game:prompt_for_move()
  self.in_out:write(messages.make_move_prompt(self.board))
end

function Game:display_invalid_selection()
  self.in_out:write(messages.invalid_selection)
end


function Game:display_game_decision()
  local decision = rules.get_game_decision(self.board)
  self.in_out:write(messages[decision])
end

function Game:display_play_again()
  self.in_out:write(messages.play_again_prompt)
end

function Game:get_move()
  self:prompt_for_move()
  --wonder if tonumber should go here?
  user_input = tonumber(self.in_out:read())

  if not validations.is_valid_move(self.board, user_input) then
    self:display_invalid_selection()
    self:get_move()
  end

  return user_input
end

function Game:place_move(move)
  self.board.spaces[move] = "x"
end

return Game