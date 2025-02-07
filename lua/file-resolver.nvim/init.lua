local M = {}

-- Table of resolvers
M.resolvers = {}

--- Add a new resolver to table
-- @param name of the resolver
-- @param handler funciton that receives (line, file_path) and returns the resolved path or nil
function M.register_resolver(name, handler) M.resolvers[name] = handler end

--- Try to resolve a file based on the registered rules
function M.resolve_file()
  local line = vim.api.nvim_get_current_line()
  local file_path = vim.api.nvim_buf_get_name(0)

  for name, handler in pairs(M.resolvers) do
    local resolved_path = handler(line, file_path)
    if resolved_path then
      resolved_path = vim.fn.resolve(vim.fn.fnamemodify(resolved_path, ':p'))
      if vim.fn.filereadable(resolved_path) == 1 then
        vim.cmd('edit ' .. resolved_path)
        return
      else
        vim.notify(
          table.concat({
            'File not found!',
            ('Rule: ' .. name),
            ('Resolved path: ' .. resolved_path),
          }, '\n'),
          vim.log.levels.WARN
        )
        return
      end
    end
  end

  vim.notify('No resolver found!', vim.log.levels.WARN)
end

--- Rule for resolving PHP __DIR__ constant
M.register_resolver('PHP __DIR__', function(line, file_path)
  local dir = vim.fn.fnamemodify(file_path, ':h')
  local match = line:match('require[_once]*%s+__DIR__%s*%.%s*[\'"](.-)[\'"]')
  if match then return dir .. match end
end)

M.setup = function(opts)
  -- In the future add options
end

return M
