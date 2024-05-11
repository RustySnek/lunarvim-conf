local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local general_on_attach = function(client, bufnr)
  if client.resolved_capabilities.completion then
    lsp_completion.on_attach(client, bufnr)
  end
end

lspconfig.cssls.setup {
  capabilities = capabilities,
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css" }
}

lspconfig.lua_ls.setup {}

lspconfig.tsserver.setup {}

lspconfig.html.setup {
  configurationSection = { "html", "css", "javascript" },
  capabilities = capabilities,
  embeddedLanguages = {
    css = true,
    elixir = true,
    heex = true,
    eelixir = true,
    javascript = true
  },
  filetypes = { "html", "heex", "elixir", "eelixir" },
  provideFormatter = true,
  on_attach = general_on_attach

}

lspconfig.tailwindcss.setup {
  capabilities = capabilities,
  on_attach = general_on_attach,
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "rust",
    "eelixir",
    "html-eex",
    "html",
    "javascript",
    "elixir",
    "heex",
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          'class[:]\\s*"([^"]*)"',
        },
      },
    },
  },
  init_options = {
    userLanguages = {
      rust = "html",
      elixir = "html-eex",
      heex = "html-eex",
      eelixir = "html-eex"
    }
  } }
