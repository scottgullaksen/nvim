-- Note that non-buffer-specific keybindings for plugins should be set here.
-- Buffer-specific keybindings should be set in their respective plugin setup file.

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

-- Obtained from https://github.com/folke/which-key.nvim
-- Non-defaults are marked with '*'
local setup =  {
  plugins = {
    marks = false, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow *, rounded
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

-- Obtained from https://github.com/nvim-lualine/lualine.nvim
-- Non-defaults are marked with '*'
local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["b"] = {
    function ()
      require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})
    end,
    "Scope buffers",
  },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["W"] = { "<cmd>wqa!<CR>", "Save & Quit all" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["Q"] = { "<cmd>qa!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["f"] = {
    function ()
      require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})
    end,
    "Find files",
  },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = {
    name = "Gitsigns",
    j = { require 'gitsigns'.next_hunk, "Next Hunk" },
    k = { require 'gitsigns'.prev_hunk, "Prev Hunk" },
    l = { require 'gitsigns'.blame_line, "Blame" },
    p = { require 'gitsigns'.preview_hunk, "Preview Hunk" },
    r = { require 'gitsigns'.reset_hunk, "Reset Hunk" },
    R = { require 'gitsigns'.reset_buffer, "Reset Buffer" },
    s = { require 'gitsigns'.stage_hunk, "Stage Hunk" },
    u = { require 'gitsigns'.undo_stage_hunk, "Undo Stage Hunk" },
    S = { require 'gitsigns'.stage_buffer, "Stage buffer" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  l = {
    name = "LSP/Mason",
    a = { vim.lsp.buf.code_action, "Code Action" },
    f = { function () vim.lsp.buf.format{async=true} end, "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    m = { "<cmd>Mason<cr>", "Mason" },
    j = { vim.lsp.diagnostic.goto_next, "Next Diagnostic" },
    k = { vim.lsp.diagnostic.goto_prev, "Prev Diagnostic" },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    q = { vim.lsp.diagnostic.set_loclist, "Quickfix" },
    r = { vim.lsp.buf.rename, "Rename" },
  },
  s = {
    name = "Telescope",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    --[[ d = { ]]  -- TODO: not working
    --[[   "<cmd>Telescope lsp_document_diagnostics<cr>", ]]
    --[[   "Document Diagnostics", ]]
    --[[ }, ]]
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
  },

  t = {
    name = "Terminal",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit"},
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)

-- So the layout inherits style from the colorscheme
vim.cmd('hi WhichKeyFloat ctermbg=BLACK ctermfg=BLACK')
