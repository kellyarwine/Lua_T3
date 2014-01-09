local In_Out = {}

function In_Out:new(i_o_filename)
  local o = { i_o_filename = i_o_filename } or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function In_Out:write(message)
  if self.i_o_filename then opened_file = io.output(self.i_o_filename) end

  io.write(message)

  if self.i_o_filename then opened_file:close() end
end

function In_Out:read()
  if self.i_o_filename then opened_file = io.input(self.i_o_filename) end

  local input = io.read()

  if self.i_o_filename then opened_file:close() end

  return input
end

return In_Out