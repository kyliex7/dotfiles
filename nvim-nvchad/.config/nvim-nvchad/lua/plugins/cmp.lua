return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "FelipeLema/cmp-async-path",
    },
    opts = function()
      return {
        mapping = {
          ["<C-y>"] = require("cmp").mapping.confirm({ select = true }),
          ["<C-p>"] = require("cmp").mapping.select_prev_item(),
          ["<C-n>"] = require("cmp").mapping.select_next_item(),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "luasnip" },
          { name = "nvim_lua" },
          { name = "async_path" },
        },
        window = {
          completion = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },  -- Rounded border style
            winhighlight = "Normal:Normal,FloatBorder:MyBorderColor,CursorLine:CursorLine,Search:Search",
          },
          documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:Normal,FloatBorder:MyBorderColor,CursorLine:CursorLine,Search:Search",
          },
        },
      }
    end,
  },
}
