vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.o.number = true

vim.termguicolors = true

vim.o.guicursor = 'n-v-c:block,i-ci-ve:ver50,r-cr-o:hor20'

vim.o.relativenumber = true

vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.o.mouse = 'a'

vim.o.showmode = false
vim.o.laststatus = 2

vim.opt.list = true
vim.opt.listchars = {
  tab = "··",
  trail = "·",
}

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.updatetime = 250

vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.inccommand = 'split'

vim.o.scrolloff = 10

vim.o.confirm = true

vim.o.cursorline = false

-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set("x", "p", function() return 'pgv"' .. vim.v.register .. "y" end, { remap = false, expr = true })


vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')


vim.keymap.set('i', '<M-p>', '<left>', { noremap = true })
vim.keymap.set('i', '<M-n>', '<right>', { noremap = true })

vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>e', vim.cmd.Ex)

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })

vim.keymap.set("v", "<leader>j", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<leader>k", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = '[Y]ank to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y', { desc = '[Y]ank line to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = '[P]aste from system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { desc = '[P]aste before from system clipboard' })

vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = '[D]elete without yanking' })

-- Autocmds
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local asm_group = vim.api.nvim_create_augroup('asm_file_settings', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'asm', 'gas' },
  group = asm_group,
  desc = 'Set GAS assembly comment character to #',
  callback = function()
    vim.opt_local.commentstring = '# %s'
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',

        build = 'make',

        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      {
        'nvim-tree/nvim-web-devicons',
        enabled = true,
      },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>si', builtin.diagnostics, { desc = '[S]earch D[i]agnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {

          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = '~/dotfiles/nvim/.config/nvim' }
      end, { desc = '[S]earch [N]eovim files' })

      vim.keymap.set('n', '<leader>sd', function()
        builtin.find_files { cwd = '~/dotfiles' }
      end, { desc = '[S]earch [D]otfiles' })
    end,
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('<leader>grn', vim.lsp.buf.rename, '[R]e[n]ame')

          map('<leader>gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = 0 })

          map('<leader>grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          map('<leader>gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          map('<leader>grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          map('<leader>grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          map('<leader>gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          map('<leader>gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          map('<leader>grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- local capabilities = require('blink.cmp').get_lsp_capabilities()
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- capabilities.textDocument.completion.completionItem.resolveSupport = {
      --   "documentation",
      --   "detail",
      --   "additionalTextEdits",
      -- }

      local servers = {
        clangd = {
          cmd = {
            "clangd",
            "--fallback-style=webkit"
          }
        },
        pyright = {},
        -- lua_ls = {
        --   settings = {
        --     Lua = {
        --       completion = {
        --         callSnippet = 'Replace',
        --       },
        --     },
        --   },
        -- },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        -- lua = { 'stylua' },
        -- python = { 'isort', 'black' },
      },
    },
  },
  -- rust
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false,   -- This plugin is already lazy
  },
  {
    'saghen/blink.cmp',
    enabled = false,
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },

      appearance = {
        nerd_font_variant = 'mono'
      },

      completion = { documentation = { auto_show = true } },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'tokyonight'
        }
      }
    end
  },
  {
    "LudoPinelli/comment-box.nvim",
    config = function()
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      --          ╭─────────────────────────────────────────────────────────╮
      --          │                        ── Titles                        │
      --          │──────────────────────────────────────────────────────────│
      --          ╰─────────────────────────────────────────────────────────╯
      keymap({ "n", "v" }, "<Leader>cb", "<Cmd>CBccbox<CR>", opts)
      -- ── Named parts ─────────────────────────────────────────────────────
      keymap({ "n", "v" }, "<Leader>ct", "<Cmd>CBllline<CR>", opts)
      -- ──────────────────────────────────────────────────────────────────────
      -- simple line
      keymap("n", "<Leader>cl", "<Cmd>CBline<CR>", opts)
      -- keymap("i", "<M-l>", "<Cmd>CBline<CR>", opts) -- To use in Insert Mode
      -- Marked comments
      keymap({ "n", "v" }, "<Leader>cm", "<Cmd>CBllbox14<CR>", opts)
      -- Removing a box is simple enough with the command (CBd), but if you
      -- use it a lot:
      keymap({ "n", "v" }, "<Leader>cd", "<Cmd>CBd<CR>", opts)
    end
  },
  -- {
  --   'christoomey/vim-tmux-navigator',
  --   keys = {
  --     { '<c-h>',  '<cmd>:TmuxNavigateLeft<CR>',     mode = { 'n', 'i', 'v' } },
  --     { '<c-j>',  '<cmd>:TmuxNavigateDown<CR>',     mode = { 'n', 'i', 'v' } },
  --     { '<c-k>',  '<cmd>:TmuxNavigateUp<CR>',       mode = { 'n', 'i', 'v' } },
  --     { '<c-l>',  '<cmd>:TmuxNavigateRight<CR>',    mode = { 'n', 'i', 'v' } },
  --     { '<c-\\>', '<cmd>:TmuxNavigatePrevious<CR>', mode = { 'n', 'i', 'v' } },
  --   },
  -- },
  -- colorscheme
  {
    "neanias/everforest-nvim",
    version = false, -- Optional: Use the latest commit
    lazy = false,    -- Optional: Load the colorscheme immediately on startup
    priority = 1000, -- Make sure it loads first
    config = function()
      require("everforest").setup({
        background = "medium",
        transparent_background_level = 2,
        disable_italic_comments = false,
      })
      vim.cmd("colorscheme everforest")
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = false },
          functions = {},
          variables = {},
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd.colorscheme('tokyonight')
    end
  },
  {
    'aliqyan-21/darkvoid.nvim',
    priority = 1000,
    enabled = false,
    config = function()
      require('darkvoid').setup({
        transparent = true,
        glow = false,
        show_end_of_buffer = true,

        colors = {
          fg = "#c0c0c0",
          bg = "#000000",
          cursor = "#bdfe58",
          line_nr = "#404040",
          visual = "#303030",
          comment = "#585858",
          string = "#d1d1d1",
          func = "#e1e1e1",
          kw = "#f1f1f1",
          identifier = "#b1b1b1",
          type = "#a1a1a1",
          type_builtin = "#c5c5c5", -- current
          search_highlight = "#1bfd9c",
          operator = "#1bfd9c",
          bracket = "#e6e6e6",
          preprocessor = "#4b8902",
          bool = "#66b2b2",
          constant = "#b2d8d8",

          plugins = {
            treesitter = true,
            telescope = true,
          },

          eob = "#000000",

          -- Telescope specific colors
          border = "#585858",
          title = "#bdfe58",

          -- LSP diagnostics colors
          error = "#dea6a0",
          warning = "#d6efd8",
          hint = "#bedc74",
          info = "#7fa1c3",
        },
      })
      vim.cmd.colorscheme("darkvoid")
    end
  },
  {
    "rose-pine/neovim",
    priority = 1000,
    enabled = false,
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "auto",      -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = true,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true,        -- Handle deprecated options automatically
        },

        styles = {
          bold = false,
          italic = true,
          transparency = true,
        },

        groups = {
          border = "muted",
          link = "iris",
          panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",

          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },

        palette = {
          main = {
            base = '#0a0a0a',
            overlay = '#363738',
          },
        },

        highlight_groups = {
          TelescopeBorder = { fg = "highlight_high", bg = "none" },
          TelescopeNormal = { bg = "none" },
          TelescopePromptNormal = { bg = "base" },
          TelescopeResultsNormal = { fg = "subtle", bg = "none" },
          TelescopeSelection = { fg = "text", bg = "base" },
          TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
        },

        before_highlight = function(group, highlight, palette)
          -- Disable all undercurls
          if highlight.undercurl then
            highlight.undercurl = false
          end
          --
          -- Change palette colour
          -- if highlight.fg == palette.pine then
          --     highlight.fg = palette.foam
          -- end
        end,
      })

      vim.cmd("colorscheme rose-pine-main")
    end
  },

  {
    enabled = false,
    lazy = false,
    priority = 1000,
    'marko-cerovac/material.nvim',
    config = function()
      require('material').setup({
        contrast = {
          floating_windows = false,    -- Enable contrast for floating windows
          cursor_line = false,         -- Enable darker background for the cursor line
          lsp_virtual_text = false,    -- Enable contrasted background for lsp virtual text
          non_current_windows = false, -- Enable contrasted background for non-current windows
          filetypes = {},              -- Specify which filetypes get the contrasted (darker) background
        },
        disable = {
          colored_cursor = true, -- Disable the colored cursor
          borders = false,       -- Disable borders between vertically split windows
          background = true,     -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = true,    -- Prevent the theme from setting terminal colors
          eob_lines = false      -- Hide the end-of-buffer lines
        },
        async_loading = true,    -- Load parts of the theme asynchronously for faster startup (turned on by default)
        custom_colors = function(colors)
          colors.main.yellow = "#a6730e"
        end,
      })
      vim.cmd.colorscheme('material-deep-ocean')
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = false },
        statementStyle = { bold = false },
        typeStyle = {},
        transparent = true, -- do not set background color
        dimInactive = true, -- dim inactive window `:h hl-NormalNC`
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              }
            }
          }
        },
        overrides = function(colors) -- add/modify highlights
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
          }
        end,
        theme = "dragon",  -- Load "wave" theme
        background = {     -- map the value of 'background' option to a theme
          dark = "dragon", -- try "dragon" !
          light = "lotus"
        },
      })

      -- setup must be called before loading
      vim.cmd("colorscheme kanagawa")
      set_transparency()
    end
    -- config = function()
    --   require("kanagawa").setup({
    --     commentStyle = { italic = true },
    --     keywordStyle = { italic = false },
    --     statementStyle = { bold = false },
    --     transparent = true,
    --     dimInactive = true,
    --     theme = "dragon"
    --   })
    --   vim.cmd.colorscheme("kanagawa-dragon")
    --   vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- end,
  },
  {
    'echasnovski/mini.nvim',
    enabled = true,
    config = function()
      require('mini.ai').setup()
      require('mini.surround').setup()
      require('mini.operators').setup()
      -- require('mini.pairs').setup()
      -- require('mini.bracketed').setup()
      -- require('mini.snippets').setup()
      require('mini.statusline').setup({
        icons = true,
        theme = 'auto', -- 'auto' will adapt to your colorscheme
        sections = {
          left = { 'mode', ' ', 'branch', ' ', 'diagnostics' },
          middle = { 'filename', ' ', 'lsp' },
          right = { 'filetype', ' ', 'position', 'percent' },
        },
        separators = { left = '', right = '' },
      })
      require('mini.completion').setup({
        lsp_completion = {
          -- snippet insertion handled by default
          snippet_insert = nil,    -- uses default_snippet_insert()
        },
        fallback_action = '<C-n>', -- fallback if no LSP items (you can keep <C-n>)
      })
      -- Optional: make <Tab> / <S-Tab> navigate popup menu
      -- vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
      -- vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
    end,
    --
    -- [some] (operators) `operators` 'thing' "bettwer"
    -- { ( [ 'mini kk' ])}
    --
    -- second first fourth third
    -- (2 + 2)
    -- 1 2 4              45 45 5 54
    --
    --
    --
    --
    --
    -- (
    -- () () ()
    -- )
    --
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    opts = {
      textobjects = {
        enabled = true,
      },
      ensure_installed = { 'bash', 'c', 'diff', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
    },
  },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
