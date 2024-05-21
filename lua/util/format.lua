local M = {}

function M.enabled(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local gaf = vim.g.disable_autoformat
  local baf = vim.b[buf].disable_autoformat

  -- If the buffer has a local value, use that
  if baf ~= nil then
    return baf
  end

  -- Otherwise use the global value if set, or true by default
  return gaf == nil or gaf
end

function M.toggle(buf)
  if buf then
    vim.b.disable_autoformat = not M.enabled()
  else
    vim.g.disable_autoformat = not M.enabled()
    vim.b.disable_autoformat = nil
  end
end

return M
