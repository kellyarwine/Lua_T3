local function read_input(self)
  if self.input_filename ~= nil and self.input_filename ~= "none" then
    opened_file = io.input(self.input_filename)
    self.inputs = {}

    for line in opened_file:lines() do
      table.insert(self.inputs, line)
    end

    opened_file:close()
  end
end

local In_Out = {}

function In_Out:write(message)
  if self.output_filename then
    opened_file = io.open(self.output_filename, "a+")
    opened_file:write(message)
    opened_file:close()
  else
    io.write(message)
  end
end

function In_Out:read()
  if self.input_filename ~= "none" and self.input_filename then
    return table.remove(self.inputs, 1)
  else
    return io.read()
  end
end

function In_Out:new(input_filename, output_filename)
  local o = { input_filename = input_filename, output_filename = output_filename } or {}
  setmetatable(o, self)
  self.__index = self
  read_input(o)
  return o
end

return In_Out