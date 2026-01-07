return {
    'nvim-treesitter/nvim-treesitter',
		branch = "master",
		event = { "BufReadPost", "BufNewFile" },
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'lua',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
        'python',
        'cpp',
        'css',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  }
