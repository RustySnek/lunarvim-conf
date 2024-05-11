lvim.plugins = {
    "elixir-tools/elixir-tools.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "NeogitOrg/neogit",
      dependencies = {
      "nvim-telescope/telescope.nvim", 
      "sindrets/diffview.nvim",        
      "ibhagwan/fzf-lua",              
      },
  "jose-elias-alvarez/null-ls.nvim",
  "simrat39/rust-tools.nvim",
  'olacin/telescope-gitmoji.nvim',
  "neovim/nvim-lspconfig",
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "norcalli/nvim-colorizer.lua",
  "nvim-telescope/telescope-file-browser.nvim" }

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
local rt = require("rust-tools")
require('colorizer').setup()
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

          local elixir = require("elixir")
            local elixirls = require("elixir.elixirls")

            elixir.setup({
                nextls = { enable = false },
                credo = { enable = true},
                elixirls = {
                    enable = true,
                    settings = elixirls.settings({
                        dialyzerEnabled = false,
                        enableTestLenses = false,
                    }),
                    on_attach = function(client, bufnr)
                        vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
                        vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
                        vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
                    end,
                },
            })
local neogit = require("neogit")
neogit.setup({
  use_magit_keybindings = true,
})
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local general_on_attach = function(client, bufnr)
  if client.resolved_capabilities.completion then
    lsp_completion.on_attach(client, bufnr)
  end
end
lspconfig.cssls.setup {
  filetypes = {"css"},
  capabilities=capabilities,

cmd = {"css-languageserver", "--stdio"},
}
lspconfig.tsserver.setup{

}
lspconfig.html.setup {
  configurationSection = {"html", "css", "elixir", "heex", "javascript", "eelixir"},
cmd = {"html-languageserver", "--stdio"},
capabilities=capabilities,
  embeddedLanguages = {
    css = true,
    elixir = true,
    heex = true,
    eelixir = true,
    javascript = true
  },
  filetypes = {"html", "heex", "elixir", "eelixir"},
  provideFormatter = true,
on_attach = general_on_attach

}
root_dir = lspconfig.util.root_pattern('tailwind.config.js', 'tailwind.config.ts', 'postcss.config.js', 'postcss.config.ts'),

lspconfig.tailwindcss.setup {  
  capabilities=capabilities,
  on_attach = general_on_attach,
  cmd = {"tailwindcss-language-server", "--stdio"},
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
  }}
lvim.leader = "space"
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}

-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
local fb_actions = require "telescope._extensions.file_browser.actions"

require("telescope").setup {
  extensions = {
        gitmoji = {
        action = function(entry)
        local current_line = vim.fn.line('.')
        local current_col = vim.fn.col('.')
        local emoji_text = entry.value.text
        vim.fn.append(current_line -1, {emoji_text .. ' '})
        vim.fn.execute("normal! x")
      end
    },    file_browser = {
      -- path
      -- cwd
      cwd_to_path = false,
      grouped = false,
      files = true,
      add_dirs = true,
      depth = 1,
      auto_depth = false,
      select_buffer = false,
      hidden = { file_browser = false, folder_browser = false },
      -- respect_gitignore
      -- browse_files
      -- browse_folders
      hide_parent_dir = false,
      collapse_dirs = false,
      prompt_path = false,
      quiet = false,
      dir_icon = "",
      dir_icon_hl = "Default",
      display_stat = { date = true, size = true, mode = true },
      hijack_netrw = false,
      use_fd = true,
      git_status = true,
      mappings = {
        ["i"] = {
          ["<A-c>"] = fb_actions.create,
          ["<S-CR>"] = fb_actions.create_from_prompt,
          ["<A-r>"] = fb_actions.rename,
          ["<A-m>"] = fb_actions.move,
          ["<A-y>"] = fb_actions.copy,
          ["<A-d>"] = fb_actions.remove,
          ["<C-o>"] = fb_actions.open,
          ["<C-g>"] = fb_actions.goto_parent_dir,
          ["<C-e>"] = fb_actions.goto_home_dir,
          ["<C-w>"] = fb_actions.goto_cwd,
          ["<C-t>"] = fb_actions.change_cwd,
          ["<C-f>"] = fb_actions.toggle_browser,
          ["<C-h>"] = fb_actions.toggle_hidden,
          ["<C-s>"] = fb_actions.toggle_all,
          ["<bs>"] = fb_actions.backspace,
        },
        ["n"] = {
          ["c"] = fb_actions.create,
          ["r"] = fb_actions.rename,
          ["m"] = fb_actions.move,
          ["y"] = fb_actions.copy,
          ["d"] = fb_actions.remove,
          ["o"] = fb_actions.open,
          ["g"] = fb_actions.goto_parent_dir,
          ["e"] = fb_actions.goto_home_dir,
          ["w"] = fb_actions.goto_cwd,
          ["t"] = fb_actions.change_cwd,
          ["f"] = fb_actions.toggle_browser,
          ["h"] = fb_actions.toggle_hidden,
          ["s"] = fb_actions.toggle_all,
        },
      },
    },
  },
}
require("telescope").load_extension "file_browser"
require("telescope").load_extension "gitmoji"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
lvim.format_on_save = true
-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
-- add your own keymapping
lvim.keys.normal_mode["ff"] = ":Telescope find_files<cr>"
lvim.keys.normal_mode["fg"] = ":Telescope live_grep<cr>"
--lvim.keys.normal_mode["fb"] = ":Telescope buffers<cr>"
lvim.keys.normal_mode["fh"] = ":Telescope help_tags<cr>"
lvim.keys.normal_mode["<A-n>"] = ":Neogit<cr>"
lvim.keys.normal_mode["fs"] = ":vsplit<cr>"
lvim.keys.normal_mode["ft"] = ":vert terminal<cr>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["fm"] = ":Telescope gitmoji<CR>"
lvim.keys.normal_mode["<C-n>"] = ":NvimTreeToggle<cr>"
lvim.keys.normal_mode["<Tab>"] = ":BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<S-Tab>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<S-e>"] = ":lua vim.diagnostic.open_float(0, {scope='line'})<CR>"
lvim.keys.normal_mode["fb"] = ":Telescope file_browser path=%:p:h<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
-- lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/configuration/language-features/language-servers>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
lsp_mgr = require("lvim.lsp.manager")
lsp_mgr.setup("tailwind-language-server")
-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
}
-- -- linters, formatters and code actions <https://www.lunarvim.org/docs/configuration/language-features/linting-and-formatting>
local null_ls = require("null-ls")
null_ls.setup({
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.diagnostics.eslint,
  null_ls.builtins.completion.spell,
})
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }
-- local code_actions = require "lvim.lsp.null-ls.code_actions"
-- code_actions.setup {
--   {
--     exe = "eslint",
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/configuration/plugins/user-plugins>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
