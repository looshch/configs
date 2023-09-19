local rg_glob = "--ignore -g '!{"
for _, exclusion in ipairs{
	'package*.json', 'yarn.lock', 'CHANGELOG.md', '.git'
} do rg_glob = rg_glob..exclusion..',' end
rg_glob = rg_glob.."}'"

vim.api.nvim_create_autocmd('BufRead', {
	pattern = '*.js',
	callback = function() vim.o.filetype = 'typescriptreact' end,
})
vim.api.nvim_create_autocmd('BufRead', {
	-- Put the cursor on the last known position.
	callback = function() vim.fn.setpos('.', vim.fn.getpos '\'"') end,
})
-- Delete trailing whitespaces.
vim.api.nvim_create_autocmd('BufWritePre', {command = '%s/\\s\\+$//e'})
vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = {'*.{js,ts}*', '*.css', '*.html', '*.md', '*.svelte'},
	command = 'silent !npx prettier --prose-wrap=always --write %',
})

vim.o.number, vim.o.relativenumber = true, true
vim.o.ignorecase, vim.o.smartcase = true, true
vim.o.undofile, vim.o.swapfile = true, false
vim.o.wrap = false
vim.o.updatetime = 250
vim.o.virtualedit = 'all'
vim.o.statusline = '%F%M %v'
vim.opt.clipboard:append 'unnamedplus'
vim.opt.diffopt:append 'algorithm:minimal'
vim.opt.diffopt:append 'linematch:60'

vim.keymap.set('i', '<c-l>', '<c-o>l')
vim.keymap.set('n', 'Q', '@q')
vim.keymap.set('n', 'U', '<c-r>')
vim.keymap.set({'n', 'v'}, '?', function() vim.fn.setreg('/', '') end)
vim.keymap.set('n', 'yp', function()
	vim.fn.setreg('*', vim.fn.fnamemodify(vim.fn.expand '%', ':.'))
end)

local lazy_path = vim.fn.stdpath 'data'..'/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazy_path) then vim.fn.system{
	'git', 'clone', '--depth=1', '--filter=blob:none',
	'https://github.com/folke/lazy.nvim.git', lazy_path,
} end
vim.opt.rtp:prepend(lazy_path)
require 'lazy'.setup{
	'nvim-lua/plenary.nvim',
	'nvim-treesitter/nvim-treesitter',

	'catppuccin/nvim',
	'tpope/vim-sleuth',
	'stevearc/oil.nvim',
	'ibhagwan/fzf-lua',
	'sindrets/winshift.nvim',
	'akinsho/bufferline.nvim',
	'ggandor/leap.nvim',
	'kylechui/nvim-surround',
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'neovim/nvim-lspconfig',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-buffer',
	'lukas-reineke/cmp-rg',
	'echasnovski/mini.pairs',
	'windwp/nvim-ts-autotag',
	'folke/ts-comments.nvim',
	'mbbill/undotree',
	'tpope/vim-fugitive',
	'akinsho/toggleterm.nvim',
	'rmagatti/auto-session',
}
vim.keymap.set('n', 'S', require 'lazy'.sync)

require 'nvim-treesitter.configs'.setup{
	auto_install = true,
	highlight = {enable = true},
}

require 'catppuccin'.setup{transparent_background = true}
vim.cmd.colorscheme 'catppuccin'

require 'oil'.setup{
	keymaps = {
		['<c-p>'] = 'actions.preview',
		['<cr>'] = 'actions.select',
		['<c-f>'] = function() vim.cmd 'silent !open -R %' end,
		['-'] = 'actions.parent',
		['<c-v>'] = 'actions.select_vsplit',
		['<c-t>'] = 'actions.select_tab',
	},
	use_default_keymaps = false,
	view_options = {show_hidden = true},
	skip_confirm_for_simple_edits = true,
	cleanup_delay_ms = false,
}
vim.keymap.set('n', 'gl', function() vim.cmd 'vertical Oil' end)

require 'fzf-lua'.setup{
	winopts = {fullscreen = true},
	previewers = {builtin = {ext_ft_override = {js = 'typescriptreact'}}}
}
vim.keymap.set('n', 'gc', function() require 'fzf-lua'.live_grep_glob{
	cmd = 'rg -SFnuu '..rg_glob,
	resume = true,
} end)
vim.keymap.set('n', 'gn', require 'fzf-lua'.git_files)

vim.keymap.set('n', ';m', vim.cmd.WinShift)
for _, direction in ipairs{'h', 'j', 'k', 'l'} do
vim.keymap.set('n', '<c-'..direction..'>', '<c-w>'..direction) end
vim.keymap.set('n', ')', function() vim.cmd 'vertical resize +15' end)
vim.keymap.set('n', '(', function() vim.cmd 'vertical resize -15' end)
vim.keymap.set('n', '+', function() vim.cmd 'resize +15' end)
vim.keymap.set('n', '-', function() vim.cmd 'resize -15' end)

require 'bufferline'.setup{
	options = {
		show_buffer_close_icons = false,
		show_close_icon = false,
		truncate_names = false,
		tab_size = 0,
		mode = 'tabs',
		numbers = 'ordinal',
	},
}
vim.keymap.set('n', '  ', require 'fzf-lua'.tabs)
for i = 1, 9 do
vim.keymap.set('n', ' '..i, i..'gt') end
vim.keymap.set('n', ' d', function() vim.cmd 'tab split' end)
vim.keymap.set('n', ' c', vim.cmd.tabclose)
vim.keymap.set('n', ' r', function() vim.cmd '.+1,$tabdo :tabclose' end)
vim.keymap.set('n', ' k', function() vim.cmd 'tabmove +1' end)
vim.keymap.set('n', ' j', function() vim.cmd 'tabmove -1' end)
vim.keymap.set('n', ' l', vim.cmd.tabnext)
vim.keymap.set('n', ' h', vim.cmd.tabprevious)

vim.keymap.set({'n', 'v'}, 's', function()
	require 'leap'.leap{target_windows = {vim.fn.win_getid()}}
end)

require 'nvim-surround'.setup{}

require 'mason'.setup()
require 'mason-lspconfig'.setup{automatic_installation = true}
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
for _, l in ipairs{
	'bashls',
	'jsonls',
	'ts_ls',
	'svelte',
	'gopls',
} do require 'lspconfig'[l].setup{capabilities = capabilities} end
require 'lspconfig'.flow.setup{
	capabilities = capabilities,
	filetypes = {'typescriptreact'},
}
vim.diagnostic.config{virtual_text = false}
vim.api.nvim_create_autocmd('CursorHold', {callback = function()
	vim.diagnostic.open_float(nil, {focus = false})
end})

vim.keymap.set('n', 'gr', require 'fzf-lua'.lsp_references)
vim.keymap.set('n', 'gd', require 'fzf-lua'.lsp_definitions)
vim.keymap.set('n', 'gD', require 'fzf-lua'.lsp_typedefs)
vim.keymap.set('n', ';p', require 'fzf-lua'.lsp_document_diagnostics)
vim.keymap.set('n', ';a', require 'fzf-lua'.lsp_code_actions)
vim.keymap.set('n', ';u', function() vim.cmd 'w | silent !gouse -w %' end)
vim.keymap.set('n', ';f', vim.lsp.buf.format)
vim.keymap.set('n', ';r', vim.lsp.buf.rename)

local cmp = require 'cmp'
cmp.setup{
	mapping = cmp.mapping.preset.insert{['<cr>'] = cmp.mapping.confirm()},
	sources = cmp.config.sources{
		{name = 'nvim_lsp'},
		{name = 'path'},
		{name = 'buffer'},
		{name = 'rg', option = {additional_arguments = rg_glob}},
	},
}

require 'mini.pairs'.setup()

require 'nvim-ts-autotag'.setup{opts = {enable_close_on_slash = true}}

require 'ts-comments'.setup()
vim.keymap.del('n', 'gcc')
vim.keymap.set({'n', 'v'}, '<c-c>', require 'vim._comment'.operator, {
	expr = true,
})

vim.keymap.set('n', ';h', vim.cmd.UndotreeToggle)

require 'toggleterm'.setup()
vim.keymap.set('n', '<c-\\>', vim.cmd.ToggleTerm)

require 'auto-session'.setup()
