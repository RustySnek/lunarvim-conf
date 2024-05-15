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
  configurationSection = { "html", "css", "javascript", "heex" },
  capabilities = capabilities,
  embeddedLanguages = {
    css = true,
    javascript = true
  },
  filetypes = { "html" },
  provideFormatter = true,
  on_attach = general_on_attach

}

lspconfig.tailwindcss.setup {
  capabilities = capabilities,
  on_attach = general_on_attach,
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "eelixir",
    "html-eex",
    "html",
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
