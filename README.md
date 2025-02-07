# file-resolver.nvim

A minimal Neovim plugin for resolving project files using customizable rules.
Designed for developers seeking lightweight file navigation and path resolution.

![Neovim Plugin Badge](https://img.shields.io/badge/Neovim-0.5%2B-green?logo=neovim) [![License](https://img.shields.io/badge/License-MIT-blue)](https://github.com/yebt/file-resolver.nvim)

## Features

- 🔍 Custom Rule System: Define project-specific file resolution logic
- 🚀 Lightweight: Minimal dependencies and overhead
- 🧩 Neovim Native: Built with Lua for seamless integration
- 🔄 Dynamic Resolution: Handle complex project structures
- 📂 Path Aliasing: Simplify imports and file references

## Installation

Using Lazy.nvim

```lua
{
  'yebt/file-resolver.nvim',
  keys = {
    '<leader>fr', ':lua require("file-resolver").resolve_current_file()<CR>'
  },
  config = function()
    require('file-resolver').setup()
  end
}

```

> [!NOTE]  
> Requires Neovim 0.5+

## Configuration

Create custom resolution rules in your init.lua:

```lua
local fr = require('fr')
fr.setup({})
fr.register_resolver('TypeScript Aliases', function(line, file_path)
  local match = line:match('from%s+[\'"](@[%w_/]+)[\'"]')
  if match then
    return vim.fn.getcwd() .. '/src/' .. match:gsub('@', '')
  end
end)
```

## Usage

### Basic Resolution

```vim
:lua require('file-resolver').resolve_current_file()
```

### Custom Keybind

```lua
vim.keymap.set('n', '<leader>fr', require('file-resolver').resolve_current_file)
```

### Project-Wide Resolution

```lua

require('file-resolver').project_resolve()
```

## Troubleshooting

Common issues:

1. Rules Not Applying:

Verify Lua pattern syntax 2. Check rule ordering (first match wins)

Performance Concerns: 3. Use specific patterns before wildcards

Limit complex regex in large projects

## Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## License

MIT License - See LICENSE for details 1
