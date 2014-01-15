local messages = require "messages"
local Mock_In_Out = require "mock_in_out"
local Prompter = require "prompter"
require "telescope"

describe("Prompter", function()

  before(function()
    inputs = { "Yeah", "maybe", "whatever", "yessir", "YES" }
    mock_in_out = Mock_In_Out:new(inputs)
    prompter = Prompter:new(mock_in_out)
  end)

  context("new", function()
    it("initializes a prompter with an in_out", function()
      assert_equal(mock_in_out, prompter.in_out)
    end)
  end)

  context("prompt", function()
    it("writes a message to the i/o and accepts input until a valid input is received, then returns it", function()
      local prompt_message = "Enter your input here:"
      local user_input = prompter:prompt(prompt_message, string.lower, { "choice", "yes_no_options" })
      assert_equal(prompt_message, mock_in_out.outputs[1])
      assert_equal(messages.invalid_selection, mock_in_out.outputs[2])
      assert_equal(prompt_message, mock_in_out.outputs[3])
      assert_equal(messages.invalid_selection, mock_in_out.outputs[4])
      assert_equal(prompt_message, mock_in_out.outputs[5])
      assert_equal(messages.invalid_selection, mock_in_out.outputs[6])
      assert_equal(prompt_message, mock_in_out.outputs[7])
      assert_equal(messages.invalid_selection, mock_in_out.outputs[8])
      assert_equal(prompt_message, mock_in_out.outputs[9])
      assert_equal(string.lower("yes"), user_input)
      assert_equal(9, #mock_in_out.outputs)
    end)
  end)
end)