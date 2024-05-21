vim.g.mapleader = " "

-- Enable autoformat by default
vim.b.disable_autoformat = false
vim.g.disable_autoformat = false

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.autoindent = true -- copy indent from current line when starting a new one
opt.expandtab = true -- expand tab to spaces
opt.tabstop = 2 -- spaces for tab
opt.softtabstop = 2
opt.shiftwidth = 2 -- 2 spaces for indent width

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- turn on termguicolors for catppuccin colorscheme to work
opt.termguicolors = true
opt.background = os.getenv("TERM_IS_DARK") == "true" and "dark" or "light"
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom
opt.splitkeep = "screen"

-- Enable auto write
opt.autowrite = true

-- Confirm to save changes before exiting modified buffer
opt.confirm = true

opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.smoothscroll = true
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldmethod = "expr"
opt.foldtext = ""
opt.foldlevel = 99

-- Show some invisible characters (tabs...
opt.list = true

-- Enable mouse mode
opt.mouse = "a"

-- Popup settings
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup

-- Dont show mode since we have a statusline
opt.showmode = false

-- Columns of context
opt.sidescrolloff = 8

opt.spelllang = { "en" }

-- Lower than default (1000) to quickly trigger which-key
opt.timeoutlen = 300

opt.undofile = true
opt.undolevels = 10000

-- Save swap file and trigger CursorHold
opt.updatetime = 200

-- Allow cursor to move where there is no text in visual block mode
opt.virtualedit = "block"

-- Command-line completion mode
opt.wildmode = "longest:full,full"

-- Minimum window width
opt.winminwidth = 5

-- Disable line wrap
opt.wrap = false
