local format = require("util.format")
local map = vim.keymap.set -- for conciseness

-- Use jk to exit the insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Increment/decrement
map("n", "<leader>+", "<C-a>", { desc = "Increment" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement" })

-- Select all
map("n", "<C-a>", "ggVG")

-- Split window
map("n", "ss", ":split<CR>", { desc = "Split window horizontally" })
map("n", "sv", ":vsplit<CR>", { desc = "Split window vertically" })
map("n", "se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "sx", ":close<CR>", { desc = "Close current split" })
map("n", "sq", ":close<CR>", { desc = "Close current split" })

-- Keeps cursor at the middle of the screen when jupping top and bottom
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
-- see: https://github.com/christoomey/vim-tmux-navigator/blob/master/plugin/tmux_navigator.vim
map("n", "<C-h>", ":<C-U>TmuxNavigateLeft<CR>", { desc = "Go to Left Window", silent = true })
map("n", "<C-j>", ":<C-U>TmuxNavigateDown<CR>", { desc = "Go to Lower Window", silent = true })
map("n", "<C-k>", ":<C-U>TmuxNavigateUp<CR>", { desc = "Go to Upper Window", silent = true })
map("n", "<C-l>", ":<C-U>TmuxNavigateRight<CR>", { desc = "Go to Right Window", silent = true })
map("n", "<C-\\>", ":<C-U>TmuxNavigatePrevious<CR>", { desc = "Go to Previous Window", silent = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- Toggle format
map("n", "<leader>uf", function()
  format.toggle()
end, { desc = "Toggle Auto Format (Global)" })
map("n", "<leader>uF", function()
  format.toggle(true)
end, { desc = "Toggle Auto Format (Buffer)" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

map("c", "Q", "q")
map("c", "Q!", "q!")
map("c", "Qa", "qa")
map("c", "Qa!", "qa!")
map("c", "W", "w")
map("c", "WA", "wa")
map("c", "WQ", "wq")
map("c", "wQ", "wq")
map("c", "WQA", "wqa")
map("c", "Wqa", "wqa")
map("c", "wQA", "wqa")
map("c", "WQa", "wqa")
map("c", "Wa", "wa")
map("c", "Wq", "wq")
map("c", "X", "x")
