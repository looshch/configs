local rg_ignore = "-g '!{"
for _, exclusion in ipairs{
	'node_modules', 'package.json', 'package-lock.json', 'yarn.lock',
} do rg_ignore = rg_ignore..exclusion..',' end
rg_ignore = rg_ignore.."}'"

vim.api.nvim_create_autocmd('BufReadPost', {
	-- Put the cursor on the last known position.
	callback = function() vim.fn.setpos('.', vim.fn.getpos '\'"') end,
})
-- Delete trailing whitespaces.
vim.api.nvim_create_autocmd('BufWritePre', {command = '%s/\\s\\+$//e'})
vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = {'*.js, *.scss, *.css, *.html'},
	command = 'silent exec "!yarn prettier --write %"',
})

-- Display the index and the last part of the last active buffer name of each
-- tab in the tab line.
function _G.tabline()
	local function is_plugin_name(bufname)
		for _, name in ipairs{
			'fugitive',
		} do if bufname:find(name) then return true end end
		return false
	end
	local line = ''
	for i = 1, vim.fn.tabpagenr '$' do
		local buflist = vim.fn.tabpagebuflist(i)
		local winnr = vim.fn.tabpagewinnr(i)
		local initial_bufname = vim.fn.bufname(buflist[winnr])
		local bufname = initial_bufname
		while is_plugin_name(bufname) and winnr < #buflist do
			winnr = winnr + 1
			bufname = vim.fn.bufname(buflist[winnr])
		end
		while is_plugin_name(bufname) and winnr > 1 do
			winnr = winnr - 1
			bufname = vim.fn.bufname(buflist[winnr])
		end
		if is_plugin_name(bufname) then
			bufname = initial_bufname
		end
		local hl_suffix = i == vim.fn.tabpagenr() and 'Sel' or ''
		line = line..
			'%#TabLine'..hl_suffix..'#%'..i..'T '..i..' '..
			-- Prepend the file’s directory name to a file name.
			vim.fn.fnamemodify(bufname, ':h:t')..'/'..
			vim.fn.fnamemodify(bufname, ':t')
	end
	return line
end
vim.o.tabline = '%!v:lua.tabline()'

vim.o.number, vim.o.relativenumber = true, true
vim.o.ignorecase, vim.o.smartcase = true, true
vim.o.undofile, vim.o.swapfile = true, false
vim.o.wrap = false
vim.o.updatetime = 250
vim.o.virtualedit = 'all'
vim.o.statusline = '%F%M %v'
vim.opt.clipboard:append 'unnamedplus'
vim.opt.fillchars:append 'eob: '
vim.opt.diffopt:append 'algorithm:patience'

vim.keymap.set('i', '<c-l>', '<c-o>l')
vim.keymap.set('n', 'Q', '@q')
vim.keymap.set('n', 'U', '<c-r>')
vim.keymap.set({'n', 'v'}, '?', ':let @/=""<cr>', {silent = true})
vim.keymap.set('n', 'yp', ':let @* = fnamemodify(expand("%"), ":.")<cr>', {silent = true})
for _, action in ipairs{
	'd', 'D',
	'c', 'C',
} do
vim.keymap.set({'n', 'v'}, '"'..action, '"_'..action) end

local lazy_path = vim.fn.stdpath 'data'..'/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
	vim.fn.system{
		'git', 'clone', '--depth=1', '--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git', lazy_path,
	}
end
vim.opt.rtp:prepend(lazy_path)
require 'lazy'.setup{
	'nvim-lua/plenary.nvim',
	'nvim-treesitter/nvim-treesitter',

	'ellisonleao/gruvbox.nvim',
	'stevearc/oil.nvim',
	'ibhagwan/fzf-lua',
	'sindrets/winshift.nvim',
	'ggandor/leap.nvim',
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'neovim/nvim-lspconfig',
	'hrsh7th/nvim-cmp',
	'l3mon4d3/luasnip',
	'saadparwaiz1/cmp_luasnip',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-path',
	'lukas-reineke/cmp-rg',
	'windwp/nvim-autopairs',
	'windwp/nvim-ts-autotag',
	'joosepalviste/nvim-ts-context-commentstring',
	'numtostr/comment.nvim',
	'nvim-pack/nvim-spectre',
	'tpope/vim-fugitive',
	'rmagatti/auto-session',
}
vim.keymap.set('n', 'S', ':Lazy sync<cr>', {silent = true})
vim.api.nvim_create_autocmd('BufRead', {
	pattern = {'*.js'},
	callback = function() vim.o.filetype = 'typescriptreact' end,
})

require 'nvim-treesitter.configs'.setup{
	auto_install = true,
	autotag = {enable = true},
	highlight = {enable = true},
}

vim.o.termguicolors = true
vim.o.background = 'dark'
require 'gruvbox'.setup{bold = false}
vim.cmd.colorscheme 'gruvbox'

require 'oil'.setup{
	keymaps = {
		['<c-p>'] = 'actions.preview',
		['<cr>'] = 'actions.select',
		['<c-f>'] = ':!open -R %<cr><cr>',
		['-'] = 'actions.parent',
		['<c-v>'] = 'actions.select_vsplit',
		['<c-t>'] = 'actions.select_tab',
	},
	use_default_keymaps = false,
	view_options = {show_hidden = true},
	skip_confirm_for_simple_edits = true,

}
vim.keymap.set('n', 'gl', ':vs %|Oil<cr>', {silent = true})

local fzf = require 'fzf-lua'
fzf.setup{
	winopts = {fullscreen = true},
	previewers = {builtin = {ext_ft_override = {js = 'typescriptreact'}}}
}
vim.keymap.set('n', 'gc', function()
	fzf.live_grep_glob{
		cmd = 'rg -SFnu '..rg_ignore,
		resume = true,
	}
end)
vim.keymap.set('n', 'gn', fzf.git_files)

vim.keymap.set('n', ' d', ':tab sp<cr>', {silent = true})
vim.keymap.set('n', ' c', ':tabc<cr>', {silent = true})
vim.keymap.set('n', ' r', ':.+1,$tabdo :tabc<cr>', {silent = true})
vim.keymap.set('n', ' k', ':tabm +1<cr>', {silent = true})
vim.keymap.set('n', ' j', ':tabm -1<cr>', {silent = true})
vim.keymap.set('n', ' l', 'gt')
vim.keymap.set('n', ' h', 'gT')
for i = 1, 9 do
vim.keymap.set('n', ' '..i, i..'gt') end
vim.keymap.set('n', '  ', fzf.tabs)

for _, direction in ipairs{'h', 'j', 'k', 'l'} do
vim.keymap.set('n', '<c-'..direction..'>', '<c-w>'..direction) end
vim.keymap.set('n', ')', '15<c-w>>')
vim.keymap.set('n', '(', '15<c-w><')
vim.keymap.set('n', '+', '5<c-w>+')
vim.keymap.set('n', '_', '5<c-w>-')
vim.keymap.set('n', '<c-m>', ':WinShift<cr>', {silent = true})

local leap = require 'leap'
vim.keymap.set({'n', 'v'}, 's', function()
	leap.leap{target_windows = {vim.fn.win_getid()}}
end)

require 'mason'.setup()
require 'mason-lspconfig'.setup{automatic_installation = true}
vim.diagnostic.config{
	virtual_text = false,
	update_in_insert = true,
}
vim.api.nvim_create_autocmd('CursorHold', {callback = function()
	vim.diagnostic.open_float(nil, {focus = false})
end})
local cmp_capabilities = require 'cmp_nvim_lsp'.default_capabilities()
for _, l in ipairs{
	'bashls',
	'jsonls',
	'tsserver',
	'flow',
	'gopls',
} do require 'lspconfig'[l].setup{capabilities = cmp_capabilities} end
vim.o.completeopt = 'menu'
vim.keymap.set('n', 'gr', fzf.lsp_references)
vim.keymap.set('n', 'gd', fzf.lsp_definitions)
vim.keymap.set('n', 'gD', fzf.lsp_typedefs)
vim.keymap.set('n', ';f', vim.lsp.buf.format)
vim.keymap.set('n', ';r', vim.lsp.buf.rename)
vim.keymap.set('n', ';p', fzf.lsp_document_diagnostics)
vim.keymap.set('n', ';a', fzf.lsp_code_actions)
vim.keymap.set('n', ';u', ':w|!gouse -w %<cr><cr>')

local cmp = require 'cmp'
local luasnip = require 'luasnip'
cmp.setup{
	snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
	mapping = cmp.mapping.preset.insert{
		['<cr>'] = cmp.mapping.confirm{select = true},
	},
	sources = cmp.config.sources{
		{name = 'nvim_lsp'},
		{name = 'luasnip'},
		{name = 'path'},
		{
			name = 'rg',
			option = {additional_arguments = rg_ignore},
		},
	},
}
local autopairs = require 'nvim-autopairs.completion.cmp'
cmp.event:on('confirm_done', autopairs.on_confirm_done())

require 'nvim-autopairs'.setup{}

require 'ts_context_commentstring'.setup()
local cmtmapping = '<c-c>'
local cmtstr = require 'ts_context_commentstring.integrations.comment_nvim'
require 'Comment'.setup{
	toggler = {line = cmtmapping..cmtmapping},
	opleader = {line = cmtmapping},
	mappings = {extra = false},
	pre_hook = cmtstr.create_pre_hook(),
}

local spectre = require 'spectre'
vim.keymap.set('n', ';s', spectre.toggle)

require 'auto-session'.setup{}
