# cursorhold.nvim

Decouple `updatetime` from `CursorHold` and `CursorHoldI`.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
-- init.lua:
{
    "gh-liu/cursorhold.nvim",
    event = "VeryLazy",
    init = function()
        vim.g.cursorhold_updatetime = 100
    end,
}
```

## Configuration

```lua
-- in millisecond, used for both CursorHold and CursorHoldI,
-- use updatetime instead if not defined
vim.g.cursorhold_updatetime = 100
```
