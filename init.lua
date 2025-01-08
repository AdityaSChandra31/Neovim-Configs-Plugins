vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
   
  { import = "plugins" },
  {'glepnir/nerdicons.nvim', cmd = 'NerdIcons', config = function() require('nerdicons').setup({}) end},
  {"williamboman/mason.nvim"},
  { 'nvim-lua/plenary.nvim' },
}, lazy_config)

require ('nvim-treesitter.install').compilers = { 'zig' }

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.cmd [[
  call plug#begin('$HOME\\AppData\\Local\\nvim\\plugged')
  Plug 'tpope/vim-fugitive'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'neovim/nvim-lspconfig'
  call plug#end()
]]