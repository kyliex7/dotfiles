return {
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },
  {
    "nvim-mini/mini.nvim",
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "FelipeLema/cmp-async-path",
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    enabled = false,
  },
  {
    'windwp/nvim-autopairs',
    enabled = false,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- Uncomment below to enable Treesitter
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = {
  --       "vim", "lua", "vimdoc",
  --       "html", "css",
  --     },
  --   },
  -- },
}
