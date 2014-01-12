local utils = {}

function utils.map(func, array)
  if type(func) ~= "function" then error("function expected") end
  if type(array) ~= "table" then error("table expected") end

  local result = {}

  for i = 1, #array do
    result[i] = func(array[i])
  end

  return result
end

function utils.multiply_string(string_value, multiplier)
  if type(string_value) ~= "string" or nil then error("string expected") end
  if type(multiplier) ~= "number" then error("number expected") end

  local result = ""
  if multiplier > 0 then
    result = string_value .. utils.multiply_string(string_value, multiplier - 1)
  end

  return result
end

return utils