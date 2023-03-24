-- vim.cmd([[packadd packer.nvim]])
vim.cmd('packadd vim-jetpack')

require('jetpack.packer').add {
  {'tani/vim-jetpack', opt = 1},

  -- library: {{{
  {'nvim-lua/plenary.nvim'},
  {'nvim-tree/nvim-web-devicons'},
  {'vim-denops/denops.vim'},
  {'tpope/vim-repeat'},
  -- }}}

  -- lsp {{{
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    after = {'mason.nvim'},
    config = function()
      require('mason-lspconfig').setup()
      require('mason-lspconfig').setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end,
      })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    setup = function()
      vim.keymap.set('n', '[lsp]', '<NOP>')
      vim.keymap.set('n', '<Leader>l', '[lsp]', {remap = true})
      vim.keymap.set('n', '[lsp]n', '<CMD>lua vim.lsp.diagnostic.goto_next()<CR>')
      vim.keymap.set('n', '[lsp]p', '<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>')
      vim.keymap.set('n', '[lsp]R', '<CMD>lua vim.lsp.buf.rename()<CR>')
      vim.keymap.set('n', '[lsp]d', '<CMD>lua vim.lsp.buf.definition()<CR>')
      vim.keymap.set('n', '[lsp]D', '<CMD>lua vim.lsp.buf.declaration()<CR>')
      vim.keymap.set('n', '[lsp]i', '<CMD>lua vim.lsp.buf.implementation()<CR>')
      vim.keymap.set('n', '[lsp]h', '<CMD>lua vim.lsp.buf.hover()<CR>')
      vim.keymap.set('n', '[lsp]x', '<CMD>lua vim.lsp.buf.format()<CR>')
    end,
    config = function()
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = {'vim'}
            },
          },
        }
      })
    end,
  },
  -- }}}

  -- neovim as a language server {{{
  {
    'jose-elias-alvarez/null-ls.nvim',
    after = {'williamboman/mason.nvim'},
    config = function()
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    after = {'null-ls.nvim', 'mason.nvim'},
    config = function()
      local masonnullls = require('mason-null-ls')
      masonnullls.setup({
        automatic_setup = true,
      })

      local null_ls = require('null-ls')
      null_ls.setup({
        -- see https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
        sources = {
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.prettier,
        },
      })
    end,
  },
  -- }}}

  -- DAP {{{
  {
    'mfussenegger/nvim-dap',
    after = {'mason.nvim'},
    config = function()
      vim.keymap.set('n', '[dap]', '<NOP>')
      vim.keymap.set('n', '<Leader>d', '[dap]', {remap = true})
      vim.keymap.set('n', '[dap]b', '<CMD>lua require("dap").toggle_breakpoint()<CR>')
      vim.keymap.set('n', '[dap]c', '<CMD>lua require("dap").continue()<CR>')
      vim.keymap.set('n', '[dap]C', '<CMD>lua require("dap").close()<CR>')
      vim.keymap.set('n', '[dap]n', '<CMD>lua require("dap").step_over()<CR>')
      vim.keymap.set('n', '[dap]i', '<CMD>lua require("dap").step_into()<CR>')
      vim.keymap.set('n', '[dap]o', '<CMD>lua require("dap").step_out()<CR>')
      vim.keymap.set('n', '[dap]l', '<CMD>lua require("dap").run_last()<CR>')
      vim.keymap.set('n', '[dap]r', '<CMD>lua require("dap").repl.open()<CR>')
      vim.keymap.set('n', '[dap]R', '<CMD>lua require("dap").repl.close()<CR>')
    end,
  },

  {
    'jayp0521/mason-nvim-dap.nvim',
    after = {'mason.nvim'},
    config = function()
      require("mason-nvim-dap").setup({
        automatic_setup = true,
      })
      require("mason-nvim-dap").setup_handlers({})
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    requires = {'mfussenegger/nvim-dap'},
    config = function()
      vim.keymap.set('n', '[dap]u', '<CMD>lua require("dapui").toggle({reset=true})<CR>')
      require('dapui').setup({
        layouts = {
          {
            elements = {'scopes', 'breakpoints', 'stacks', 'watches'},
            size = 40,
            position = 'right',
          },
          {
            elements = {'repl', 'console'},
            size = 10,
            position = 'bottom',
          },
        }
      })
    end,
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  -- }}}

  -- file explorer {{{
  {
    'nvim-tree/nvim-tree.lua',
    setup = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.keymap.set('n', '<C-n>', '<CMD>NvimTreeToggle<CR>')
    end,
    config = function()
      local tree_cb = require('nvim-tree.config').nvim_tree_callback
      require('nvim-tree').setup({
        filters = {
          dotfiles = true,
        },
        view = {
          mappings = {
            custom_only = true,
            list = {
              { key = { '<CR>', 'l' }, cb = tree_cb('edit') },
              { key = { '<C-]>' }, cb = tree_cb('cd') },
              { key = { 'u' }, cb = tree_cb('dir_up') },
              { key = { 'q' }, cb = tree_cb('close') },
              { key = { 's' }, cb = tree_cb('split') },
              { key = { 'v' }, cb = tree_cb('vsplit') },
              { key = { '.' }, cb = tree_cb('toggle_dotfiles') },
              { key = { 'h' }, cb = tree_cb('close_node') },
              { key = { 'R' }, cb = tree_cb('refresh') },
              { key = { 'y' }, cb = tree_cb('copy_path') },
              { key = { 'Y' }, cb = tree_cb('copy_absolute_path') },
            },
          },
        },
      })
    end,
    requires = {'nvim-tree/nvim-web-devicons'},
    opt = true,
    cmd = {'NvimTreeToggle'},
  },
  --- }}}

  -- snippets {{{
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  {'saadparwaiz1/cmp_luasnip'},
  {'rafamadriz/friendly-snippets'},
  -- }}}

  -- auto-completion nvim-cmp {{{
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local luasnip = require('luasnip')
      local cmp = require('cmp')
      cmp.setup({
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'skkeleton' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, {'i', 's'}),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {'i', 's'}),
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
  -- }}}

  -- statusline {{{
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {theme = 'OceanicNext'},
        sections = {
          lualine_c = {{'filename', path = 1, shorting_target = 40 }},
        },
      })
    end,
  },
  -- }}}

  -- bufferline {{{
  {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup({
        options = {
          diagnostics = 'nvim_lsp',
          offsets = {{filetype = 'NvimTree' }},
        },
      })
    end,
  },
  -- }}}

  -- fuzzy finder {{{
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').setup({
        defaults = {border = true}
      })
    end,
    setup = function()
      vim.keymap.set('n', '[ts]', '<NOP>')
      vim.keymap.set('n', '<Leader>f', '[ts]', {remap = true})
      vim.keymap.set('n', '[ts]f', '<CMD>Telescope fd<CR>')
      vim.keymap.set('n', '[ts]g', '<CMD>Telescope live_grep<CR>')
      vim.keymap.set('n', '[ts]b', '<CMD>Telescope buffers<CR>')
      vim.keymap.set('n', '[ts]h', '<CMD>Telescope help_tags<CR>')
      vim.keymap.set('n', '[ts]o', '<CMD>Telescope oldfiles<CR>')
      vim.keymap.set('n', '[ts]m', '<CMD>Telescope marks<CR>')
      vim.keymap.set('n', '[ts]r', '<CMD>Telescope registers<CR>')
      vim.keymap.set('n', '[ts]M', '<CMD>Telescope man_pages<CR>')

      vim.keymap.set('n', '[lsp]r', '<CMD>Telescope lsp_references<CR>')
    end,
  },
  -- }}}

  -- motion {{{
  {
    'phaazon/hop.nvim',
    config = function()
      require('hop').setup({})
      vim.keymap.set('n', '[hop]', '<NOP>')
      vim.keymap.set('n', '<Leader>h', '[hop]', {remap = true})
      vim.keymap.set('n', '[hop]w', '<CMD>HopWord<CR>')
      vim.keymap.set('n', '[hop]s', '<CMD>HopPattern<CR>')
      vim.keymap.set('n', '[hop]d', '<CMD>HopChar2<CR>')
    end,
  },
  --- }}}

  -- treesitter {{{
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {enable = true},
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup({
      })
    end,
  },

  {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  -- }}}

  -- editing: {{{
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },

  {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  -- }}}

  -- color {{{
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  -- }}}

  -- git {{{
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({})
    end,
  },

  {
    'TimUntersberger/neogit',
    setup = function()
      vim.keymap.set('n', '[git]', '<Nop>')
      vim.keymap.set('n', '<Leader>g', '[git]', {remap = true})
      vim.keymap.set('n', '[git]g', '<CMD>Neogit<CR>')
    end,
    config = function()
      require('neogit').setup({
        disable_commit_confirmation = true,
      })
    end,
  },
  -- }}}

  -- terminal {{{
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup({
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-\><c-\>]],
        persist_size = false,
        direction = 'horizontal',
      })
    end,
  },
  -- }}}

  --- preview {{{
  {
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
  },
  --}}}

  -- skk {{{
  {
    'vim-skk/skkeleton',
    config = function()
      vim.cmd([[
        call skkeleton#config({
        \ "markerHenkan": "",
        \ "markerHenkanSelect": ">",
        \ })
      ]])
    end,
    setup = function()
      vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-toggle)", { remap = true })
      vim.keymap.set("c", "<C-j>", "<Plug>(skkeleton-toggle)", { remap = true })
    end,
    requires = { "vim-denops/denops.vim" },
  },

  {
    'rinx/cmp-skkeleton',
    after = {'nvim-cmp', 'skkeleton'},
    config = function()
    end,
  },
  -- }}}

  -- colorscheme: {{{
  { "mhartington/oceanic-next" }
  -- }}}

}

-- vim: foldmethod=marker
