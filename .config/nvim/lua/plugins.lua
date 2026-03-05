return require('packer').startup(function(use)
  use 'jiangmiao/auto-pairs'               -- bracket et.al. closing
  use 'preservim/nerdtree'                 -- filesystem explorer
  use 'preservim/tagbar'                   -- symbol outline
  use 'rbong/vim-flog'                     -- git log utility for fugitive
  use 'tpope/vim-surround'                 -- wrap strings in quotes or whatever
  use 'tpope/vim-fugitive'                 -- git helper
  use 'vim-airline/vim-airline'            -- status line
  use 'wbthomason/packer.nvim'             -- packer itself
  use 'iamcco/markdown-preview.nvim'       -- markdown preview
  use 'mfussenegger/nvim-dap'              -- nvim-dap (debug adapter protocol)
  use { 
    "rcarriga/nvim-dap-ui",
    requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} 
  }
  -- CoC NodeJs extension
  use {'neoclide/coc.nvim', branch = 'release'}

  -- Themes
  --use 'dracula/vim
  use 'sainnhe/sonokai'
  --use 'bluz71/vim-moonfly-colors'


  -- Treesitter config
  -- Treesitter is a code parser.
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()

    require'nvim-treesitter.configs'.setup {
      ensure_installed = {
        "php",
        "json",
        "yaml",
        "css",
        "html",
        "lua",
        "twig"
      },
      sync_install = false,
      auto_install = true,
    }
    end,
  }

  local vim = vim
  local opt = vim.opt

  opt.foldmethod = "indent"
  opt.foldexpr = "nvim_treesitter#foldexpr()"


  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = {
      {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-live-grep-args.nvim'
      }
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        defaults = { preview = { treesitter = false } }
      })
      telescope.load_extension('live_grep_args')
    end
  }


  -- PHP debugging adapter config
  local dap = require('dap')
  dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = { '/Users/fm56/.config/nvim/vscode-php-debug/out/phpDebug.js' }
  }
  dap.configurations.php = {
    {
      type = 'php',
      request = 'launch',
      name = 'Listen for Xdebug',
      port = 9003,
      log = true,
      localSourceRoot = '/Users/fm56/Documents/Jobs/plesk/'
    }
  }
  require("dapui").setup()

end)

