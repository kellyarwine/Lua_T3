local Mock_In_Out = {}

function Mock_In_Out:new(inputs)
  local o = {}
  o.inputs = inputs
  o.outputs = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Mock_In_Out:write(message)
  table.insert(self.outputs, message)
end

function Mock_In_Out:read()
  local input = self.inputs[1]
  table.remove(self.inputs, 1)
  return input
end

return Mock_In_Out