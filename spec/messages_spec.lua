local inspect = require "inspect"
local messages = require "messages"

describe("messages", function()

  context("build_row_border", function()
    it("create a gameboard border row", function()
      mock_size = 3
      mock_board = { size = mock_size }
      local expected_value = "-----+-----+-----\n"
      assert_equal(expected_value, messages.build_row_border(mock_board))
    end)
  end)

  context("build_cell", function()
    it("creates a gameboard cell containing player input", function()
      assert_equal("  1  ", messages.build_cell("1"))
    end)
  end)

  context("build_data_row", function()
    it("creates a gameboard row containing player input", function()
      local segment = { "1", "2", "3" }
      local expected_value = "  1  |  2  |  3  \n"
      assert_equal(expected_value, messages.build_row_data(segment))
    end)
  end)

  context("build_header_footer", function()
    it("creates the gameboard's the header and footer", function()
      mock_size = 2
      mock_board = { size = mock_size }
      local expected_value = "     |     \n"
      assert_equal(expected_value, messages.build_header_footer(mock_board))
    end)
  end)

  context("build_board", function()
    it("creates the gameboard", function()
      local mock_board = {}
      function mock_board.segment() return { { "1", "2", "3" }, { "4", "5", "6" }, { "7", "8", "9" } } end
      mock_board.spaces = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
      mock_board.size = 3
      local expected_value = "     |     |     \n" ..
                             "  1  |  2  |  3  \n" ..
                             "-----+-----+-----\n" ..
                             "  4  |  5  |  6  \n" ..
                             "-----+-----+-----\n" ..
                             "  7  |  8  |  9  \n" ..
                             "     |     |     \n"
      assert_equal(expected_value, messages.build_board(mock_board))
    end)
  end)

end)