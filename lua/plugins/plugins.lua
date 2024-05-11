lvim.plugins = {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "jose-elias-alvarez/null-ls.nvim",
  "olacin/telescope-gitmoji.nvim",
  "neovim/nvim-lspconfig",
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "elixir-tools/elixir-tools.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
  "norcalli/nvim-colorizer.lua",
  "nvim-telescope/telescope-file-browser.nvim"
}

reload("plugins.telescope")
reload("plugins.elixir")
reload("plugins.neogit")
reload("plugins.lsp")
reload("plugins.treeshitter")
reload("plugins.null")
reload("plugins.luasnip")
reload("plugins.cmp")
require("colorizer").setup()
