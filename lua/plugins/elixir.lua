local elixir = require("elixir")
local elixirls = require("elixir.elixirls")

elixir.setup {
  nextls = { enable = false }, -- defaults to false
  credo = {
    enable = true,             -- defaults to true
  },
  elixirls = {
    settings = elixirls.settings {
      dialyzerEnabled = true,
      fetchDeps = false,
      enableTestLenses = false,
      suggestSpecs = false,
    },
    on_attach = function(client, bufnr)
      vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
      vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
    end
  }
}
