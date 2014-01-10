local utils = {}

function utils.map(func, array)
  local result = {}

  for i = 1, #array do
    result[i] = func(array[i])
  end

  return result
end

function utils.multiply_string(string_value, multiplier)
  local result = ""
  if multiplier > 0 then
    result = string_value .. utils.multiply_string(string_value, multiplier - 1)
  end

  return result
end

return utils