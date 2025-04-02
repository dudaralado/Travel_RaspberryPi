return {
	"nvimtools/none-ls.nvim",
	opts = function()
		local null_ls = require("null-ls")
		local helpers = require("null-ls.helpers")

		local markdownlint = {
                			method = null_ls.methods.DIAGNOSTICS,
			filetypes = { "markdown" },
			generator = null_ls.generator({
				command = "markdownlint",
				args = { "--stdin" },
				to_stdin = true,
				from_stderr = true,
				format = "line",
				check_exit_code = function(code, stderr)
					local success = code <= 1
					if not success then
						print(stderr)
					end
					return success
				end,
				on_output = helpers.diagnostics.from_patterns({
					{
						pattern = [[:(%d+):(%d+) [%w-/]+ (.*)]],
						groups = { "row", "col", "message" },
					},
					{
						pattern = [[:(%d+) [%w-/]+ (.*)]],
						groups = { "row", "message" },
					},
				}),
			}),
		}

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua, -- Lua formatter
			},
		})

		-- Set keymap for formatting
		vim.keymap.set("n", "gf", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "Format buffer using LSP" })
	end,
}
