local status_ok, _ = pcall(require, "mason")
if not status_ok then
	return
end

-- Taken from https://github.com/williamboman/mason-lspconfig.nvim
-- Compatible servers can also be found there.
-- Non-defaults are marked with '*'
require("mason-lspconfig").setup({
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
    -- This setting has no relation with the `automatic_installation` setting.
  ensure_installed = {
    "sumneko_lua",
    "jedi_language_server",
    "clangd",
    "volar",
    "awk_ls",
    "dockerls",
    "kotlin_language_server",
    "html",
    "sqlls",
    "cssls",
    "yamlls"
  },

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    automatic_installation = false,
})

local function make_default_opts() return {
  on_attach = require("scott.lsp.handlers").on_attach,
	capabilities = require("scott.lsp.handlers").capabilities,
} end

-- Config options for each language server can be found at 
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup(make_default_opts())
    end,
    -- Next, you can provide targeted overrides for specific servers.
    ["jsonls"] = function ()
      local jsonls_opts = require("scott.lsp.settings.jsonls")
	 	  local opts = vim.tbl_deep_extend("force", jsonls_opts, make_default_opts())
      require("lspconfig").jsonls.setup(opts)
    end,
    ["sumneko_lua"] = function ()
      local sumneko_opts = require("scott.lsp.settings.sumneko_lua")
	    local opts = vim.tbl_deep_extend("force", sumneko_opts, make_default_opts())
      require("lspconfig").sumneko_lua.setup(opts)
    end,
    ["jedi_language_server"] = function ()
      require("lspconfig").jedi_language_server.setup(make_default_opts())
	 end,
    ["clangd"] = function ()
      require("lspconfig").clangd.setup(make_default_opts())
	 end,
    ["volar"] = function ()
      local volar_opts = require("scott.lsp.settings.volar")
	    local opts = vim.tbl_deep_extend("force", volar_opts, make_default_opts())
      require("lspconfig").volar.setup(opts)
	 end,
    ["awk_ls"] = function ()
      require("lspconfig").awk_ls.setup(make_default_opts())
	  end,
    ["dockerls"] = function ()
      require("lspconfig").dockerls.setup(make_default_opts())
	  end,
    ["kotlin_language_server"] = function ()
      require("lspconfig").kotlin_language_server.setup(make_default_opts())
	  end,
    ["html"] = function ()
      require("lspconfig").html.setup(make_default_opts())
	  end,
    ["cssls"] = function ()
      require("lspconfig").cssls.setup(make_default_opts())
	  end,
    ["sqlls"] = function ()
      require("lspconfig").sqlls.setup(make_default_opts())
	  end,
    ["yamlls"] = function ()
      require("lspconfig").yamlls.setup(make_default_opts())
	  end
}
