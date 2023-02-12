-- Find info on how null-ls works and configs at https://github.com/jose-elias-alvarez/null-ls.nvim
-- Builtins can be found at https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins
-- Note that these sources will respect any project-local config file e.g. .prettierrc, eslint.json etc

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier,
    formatting.stylua,
    formatting.black,
    diagnostics.eslint,
    diagnostics.luacheck,
    diagnostics.pylint,
    code_actions.gitsigns,
  },
}
