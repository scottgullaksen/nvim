return {
	settings = {

		Lua = {
      -- Force LSP to recognize vim global
			diagnostics = {
				globals = { "vim" },
			},

      -- Make the server aware of Neovim runtime files
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}
