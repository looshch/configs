vim.api.nvim_create_autocmd('BufRead', {callback = function()
	-- Put the cursor on the last known position.
	vim.fn.setpos('.', vim.fn.getpos '\'"')
end})
vim.api.nvim_create_autocmd('BufRead', {
	pattern = '*.js',
	callback = function() vim.bo.filetype = 'typescriptreact' end,
})
vim.api.nvim_create_autocmd('BufWritePre', {command = '%s/\\s\\+$//e'})
vim.api.nvim_create_autocmd('VimLeavePre', {callback = function()
	require 'resession'.save(vim.fn.getcwd(), {notify = false})
end})

vim.o.number, vim.o.relativenumber = true, true
vim.o.ignorecase, vim.o.smartcase = true, true
vim.o.undofile, vim.o.swapfile = true, false
vim.o.wrap = false
vim.o.updatetime = 250
vim.o.virtualedit = 'all'
vim.o.statusline = '%F%M %v'
vim.opt.clipboard:append 'unnamedplus'
vim.opt.jumpoptions:append 'view'

vim.keymap.set('i', '<c-l>', '<c-o>l')
vim.keymap.set('n', 'U', '<c-r>')
vim.keymap.set({'n', 'v'}, '?', function() vim.fn.setreg('/', '') end)
vim.keymap.set('n', 'yp', function()
	vim.fn.setreg('*', vim.fn.fnamemodify(vim.fn.expand '%', ':.'))
end)
vim.keymap.set('n', 'gf', function() vim.cmd 'silent !open -R %' end)
vim.keymap.set({'n', 'v'}, '<c-c>', require 'vim._comment'.operator, {
	expr = true,
})
vim.keymap.set('t', 'jk', '<c-\\><c-n>')

local lazy_path = vim.fn.stdpath 'data'..'/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazy_path) then vim.fn.system{
	'git', 'clone', '--depth=1', '--filter=blob:none',
	'https://github.com/folke/lazy.nvim.git', lazy_path,
} end
vim.opt.rtp:prepend(lazy_path)
require 'lazy'.setup{
	'nvim-lua/plenary.nvim',
	'nvim-treesitter/nvim-treesitter',

	{'catppuccin/nvim', version = '1.11.0'},
	'tpope/vim-sleuth',
	'stevearc/oil.nvim',
	'ibhagwan/fzf-lua',
	'sindrets/winshift.nvim',
	'akinsho/bufferline.nvim',
	'ggandor/leap.nvim',
	{'kylechui/nvim-surround', opts = {}},
	{'mason-org/mason.nvim', opts = {}},
	'mason-org/mason-lspconfig.nvim',
	'neovim/nvim-lspconfig',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-buffer',
	{'windwp/nvim-autopairs', opts = {}},
	{'windwp/nvim-ts-autotag', opts = {}},
	{'folke/ts-comments.nvim', opts = {}},
	'mbbill/undotree',
	'tpope/vim-fugitive',
	{'rmagatti/auto-session', opts = {}},
}
vim.keymap.set('n', 'S', require 'lazy'.sync)

require 'nvim-treesitter.configs'.setup{
	auto_install = true,
	highlight = {enable = true},
}

require 'catppuccin'.setup{transparent_background = true}
vim.cmd.colorscheme 'catppuccin'

require 'oil'.setup{keymaps = {
	['<C-h>'] = false,
	['<C-l>'] = false,
	['<c-v>'] = 'actions.select_vsplit',
}}
vim.keymap.set('n', 'gl', function() vim.cmd 'vertical Oil' end)

require 'fzf-lua'.setup{
	winopts = {fullscreen = true},
	keymap = {fzf = {['ctrl-q'] = 'select-all+accept'}},
	previewers = {builtin = {ext_ft_override = {js = 'typescriptreact'}}},
	grep = {RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH},
	lsp = {jump1 = false},
}
vim.keymap.del('n', 'gcc')
vim.keymap.set('n', 'gc', function()
	require 'fzf-lua'.live_grep{resume = true}
end)
vim.keymap.set('n', 'gn', require 'fzf-lua'.git_files)

vim.keymap.set('n', 'm', vim.cmd.WinShift)
for _, direction in ipairs{'h', 'j', 'k', 'l'} do
vim.keymap.set('n', '<c-'..direction..'>', '<c-w>'..direction) end
vim.keymap.set('n', ')', function() vim.cmd 'vertical resize +15' end)
vim.keymap.set('n', '(', function() vim.cmd 'vertical resize -15' end)
vim.keymap.set('n', '+', function() vim.cmd.resize '+10' end)
vim.keymap.set('n', '-', function() vim.cmd.resize '-10' end)

require 'bufferline'.setup{options = {
	show_buffer_close_icons = false,
	show_close_icon = false,
	truncate_names = false,
	tab_size = 0,
	mode = 'tabs',
	numbers = 'ordinal',
}}
vim.keymap.set('n', '  ', require 'fzf-lua'.tabs)
for index = 1, 9 do
vim.keymap.set('n', ' '..index, index..'gt') end
vim.keymap.set('n', ' d', function() vim.cmd 'tab split' end)
vim.keymap.set('n', ' c', function()
	if vim.bo.buftype == 'terminal' then vim.cmd.windo 'bdelete!'
	else vim.cmd.tabclose() end
end)
vim.keymap.set('n', ' r', function() vim.cmd '.+1,$tabdo :tabclose' end)
vim.keymap.set('n', ' k', function() vim.cmd.tabmove '+1' end)
vim.keymap.set('n', ' j', function() vim.cmd.tabmove '-1' end)
vim.keymap.set('n', ' l', vim.cmd.tabnext)
vim.keymap.set('n', ' h', vim.cmd.tabprevious)
vim.keymap.set('n', ' t', function()
	vim.cmd 'tab terminal'
	vim.cmd.startinsert()
end)

vim.keymap.set({'n', 'v'}, 's', function()
	require 'leap'.leap{target_windows = {vim.fn.win_getid()}}
end)

local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
vim.lsp.config('*', {capabilities = capabilities})
vim.lsp.config.angularls = {cmd = {
	"ngserver",
	"--stdio",
	"--tsProbeLocations",
	"?/node_modules",
	"--ngProbeLocations",
	"/Users/l/.local/share/nvim/mason/packages/angular-language-server/node_modules/@angular/language-server/node_modules",
	"--angularCoreVersion",
	"20.1.0"
}}
vim.lsp.config.flow = {filetypes = {'typescriptreact'}}
vim.lsp.enable('sourcekit')
require 'mason-lspconfig'.setup{ensure_installed = {
	'angularls',
	'ts_ls',
	'bashls',
	'jsonls',
	'eslint',
	'gopls',
}}

vim.keymap.set('n', 'gr', require 'fzf-lua'.lsp_references)
vim.keymap.set('n', 'gd', require 'fzf-lua'.lsp_definitions)
vim.keymap.set('n', 'gD', require 'fzf-lua'.lsp_typedefs)
vim.keymap.set('n', 'gp', require 'fzf-lua'.lsp_document_diagnostics)
vim.keymap.set('n', 'gpp', function()
	vim.diagnostic.open_float(nil, {focus = false})
end)
vim.keymap.set('n', 'ga', require 'fzf-lua'.lsp_code_actions)
vim.keymap.set('n', ';f', vim.lsp.buf.format)
vim.keymap.set('n', ';r', vim.lsp.buf.rename)

local cmp = require 'cmp'
local get_bufnrs = function()
	return vim.tbl_filter(
		function(buf)
			return vim.fn.buflisted(buf) == 1 and
			vim.fn.bufloaded(buf) == 1
		end,
		vim.api.nvim_list_bufs()
	)
end
cmp.setup{
	mapping = cmp.mapping.preset.insert{['<cr>'] = cmp.mapping.confirm()},
	sources = cmp.config.sources{
		{name = 'nvim_lsp'},
		{name = 'path'},
		{
			name = 'buffer',
			option = {get_bufnrs = get_bufnrs},
		},
	},
}

vim.keymap.set('n', 'gh', vim.cmd.UndotreeToggle)
