local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup {
  ensure_installed = { "c", "lua", "java", "kotlin", "yaml", "bash", "fish", "javascript", "markdown", "css", "dockerfile", "html", "json", "jsdoc", "json5", "markdown_inline", "python", "scala", "sql", "typescript", "tsx", "vue"},
  sync_install = false,
  ignore_install = { "" }, -- List of parsers to ignore installing

  -- Integration with autopairs nvim-plugin
  autopairs = {
    enable = true,
  },
  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true, -- false will disable the whole extension (for "all")

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },

  -- Incremental selection based on the named nodes from the grammar.
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  -- rainbow plugin configs taken from https://github.com/p00f/nvim-ts-rainbow
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int

     -- Setting colors
    colors = {
      -- Colors here
    },

    -- Term colors
    termcolors = {
      -- Term colors here
    }   -- termcolors = {} -- table of colour name strings
  },

  -- Integrate with context comment plugin
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },

  -- Indentation based on treesitter for the = operator. NOTE: This is an experimental feature.
  indent = { enable = true, },  -- disable = { "yaml" }
}
