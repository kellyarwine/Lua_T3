local inspect = require "inspect"
local validations = require "validations"

describe("validations", function()

  context("is_invalid", function()
    context("move", function()
      before(function()
        mock_board = {}
        mock_board.size = 3
        mock_board.spaces = { "x", "2", "x", "4", "x", "6", "x", "8", "x" }
      end)

      it("returns true when the move is not valid", function()
        assert_true(validations.is_invalid("move", mock_board, 1))
        assert_true(validations.is_invalid("move", mock_board, 11))
        assert_true(validations.is_invalid("move", mock_board, 10000000000))
        assert_true(validations.is_invalid("move", mock_board, nil))
      end)

      it("returns false when the move is valid", function()
        assert_false(validations.is_invalid("move", mock_board, 2))
      end)
    end)

    context("gamepiece", function()
      it("returns true when the gamepiece selection is not valid", function()
        assert_true(validations.is_invalid("gamepiece", "aaaaaaaaaa"))
        assert_true(validations.is_invalid("gamepiece", "1000000000"))
        assert_true(validations.is_invalid("gamepiece", "."))
        assert_true(validations.is_invalid("gamepiece", nil))
      end)

      it("returns false when the gamepiece selection is not unique", function()
        assert_true(validations.is_invalid("gamepiece", "a", "a"))
      end)

      it("returns false when the gamepiece selection is a single character", function()
        assert_false(validations.is_invalid("gamepiece", "a"))
      end)

      it("returns false when the gamepiece selection is unique", function()
        validations.is_invalid("gamepiece", "a", "b")
        assert_false(validations.is_invalid("gamepiece", "a", "b"))
      end)

      it("returns false when the gamepiece selection is a single character and no existing gamepiece has been passed in (only one player has been created at this point)", function()
        assert_false(validations.is_invalid("gamepiece", "a"))
      end)
    end)

    context("board_size", function()
      it("returns true when the board size selection is not valid", function()
        assert_true(validations.is_invalid("board_size", validations.minimum_board_size - 1))
        assert_true(validations.is_invalid("board_size", validations.maximum_board_size + 1))
        assert_true(validations.is_invalid("board_size", validations.maximum_board_size + 1000000000))
        assert_true(validations.is_invalid("board_size", nil))
      end)

      it("returns false when the board size selection is valid", function()
        assert_false(validations.is_invalid("board_size", validations.minimum_board_size))
        assert_false(validations.is_invalid("board_size", validations.maximum_board_size))
      end)
    end)

    context("player", function()
      it("returns true when the player selection is not valid", function()
        assert_true(validations.is_invalid("player", "blah"))
        assert_true(validations.is_invalid("player", "10000000000000"))
        assert_true(validations.is_invalid("player", "."))
        assert_true(validations.is_invalid("player", nil))
      end)

      it("returns false when the player selection is valid", function()
        assert_false(validations.is_invalid("player", validations.player_types[2]))
        assert_false(validations.is_invalid("player", validations.player_types[1]))
      end)
    end)

    context("turn_order", function()
      it("returns true when the turn order selection is not valid", function()
        assert_true(validations.is_invalid("turn_order", "blah"))
        assert_true(validations.is_invalid("turn_order", "1000000000000000"))
        assert_true(validations.is_invalid("turn_order", "."))
        assert_true(validations.is_invalid("turn_order", nil))
      end)

      it("returns false when the turn order selection is valid", function()
        assert_false(validations.is_invalid("turn_order", validations.turn_order_options[1]))
        assert_false(validations.is_invalid("turn_order", validations.turn_order_options[2]))
      end)
    end)

    context("play_again", function()
      it("returns true when the turn order selection is not valid", function()
        assert_true(validations.is_invalid("play_again", "blah"))
        assert_true(validations.is_invalid("play_again", "1000000000000000"))
        assert_true(validations.is_invalid("play_again", "."))
        assert_true(validations.is_invalid("play_again", nil))
      end)

      it("returns false when the turn order selection is valid", function()
        assert_false(validations.is_invalid("play_again", validations.play_again_options[1]))
        assert_false(validations.is_invalid("play_again", validations.play_again_options[2]))
      end)
    end)
  end)
end)
