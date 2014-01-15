local validations = require "validations"

describe("validations", function()

  context("is_invalid", function()
    context("move", function()
      before(function()
        mock_board_spaces = { "x", "2", "x", "4", "x", "6", "x", "8", "x" }
      end)

      it("returns true when the move is not valid", function()
        assert_true(validations.is_invalid(1, { "move", mock_board_spaces }))
        assert_true(validations.is_invalid(#mock_board_spaces, { "move", mock_board_spaces }))
        assert_true(validations.is_invalid(1000000000, { "move", mock_board_spaces }))
        assert_true(validations.is_invalid(nil, { "move", mock_board_spaces }))
      end)

      it("returns false when the move is valid", function()
        assert_false(validations.is_invalid(2, { "move", mock_board_spaces }))
      end)
    end)

    context("gamepiece", function()
      it("returns true when the gamepiece selection is not valid", function()
        assert_true(validations.is_invalid("aaaaaaaa", { "gamepiece" }))
        assert_true(validations.is_invalid("10000000", { "gamepiece" }))
        assert_true(validations.is_invalid(".", { "gamepiece" }))
        assert_true(validations.is_invalid(nil, { "gamepiece" }))
      end)

      it("returns false when the gamepiece selection is not unique", function()
        assert_true(validations.is_invalid("a", { "gamepiece", "a" }))
      end)

      it("returns false when the gamepiece selection is unique", function()
        assert_false(validations.is_invalid("a", { "gamepiece", "b" }))
      end)

      it("returns false when the gamepiece selection is a single character and no existing gamepiece has been passed in (only one player has been created at this point)", function()
        assert_false(validations.is_invalid("a", { "gamepiece" }))
      end)
    end)

    context("board_size", function()
      it("returns true when the board size selection is not valid", function()
        assert_true(validations.is_invalid(validations.board_range[1] - 1, { "in_range", "board_range" }))
        assert_true(validations.is_invalid(validations.board_range[2] + 1, { "in_range", "board_range" }))
        assert_true(validations.is_invalid(10000000, { "in_range", "board_range" }))
        assert_true(validations.is_invalid(nil, { "in_range", "board_range" }))
      end)

      it("returns false when the board size selection is valid", function()
        assert_false(validations.is_invalid(validations.board_range[1] + 1, { "in_range", "board_range" }))
        assert_false(validations.is_invalid(validations.board_range[2] - 1, { "in_range", "board_range" }))
      end)
    end)

     context("choice", function()
       it("returns true when the selection is not an option compared to the available options", function()
         assert_true(validations.is_invalid("yeah", { "choice", "yes_no_options" }))
         assert_true(validations.is_invalid("100000000000", { "choice", "turn_order_options" }))
         assert_true(validations.is_invalid(nil, { "choice", "player_options" }))
       end)

       it("returns false when the selection is an option compared to the available options", function()
         assert_false(validations.is_invalid(validations.yes_no_options[1], { "choice", "yes_no_options" }))
         assert_false(validations.is_invalid(validations.turn_order_options[1], { "choice", "turn_order_options" }))
         assert_false(validations.is_invalid(validations.player_options[1], { "choice", "player_options" }))
       end)
     end)
  end)
end)