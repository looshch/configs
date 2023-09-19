vim.api.nvim_create_autocmd('FileType', {
	pattern = '<filetype>',
	callback = function()
		vim.bo.bufhidden = 'delete'
		vim.treesitter.start()
	end,
})
vim.api.nvim_create_autocmd('BufRead', {callback = function()
	-- Put the cursor on the last known position.
	vim.fn.setpos('.', vim.fn.getpos '\'"')
end})
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = '*',
	command = 'silent! checktime',
})
vim.api.nvim_create_autocmd('BufWritePre', {command = '%s/\\s\\+$//e'})

local font_size_factor = 1.1
local change_font_size = function(factor)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * factor
end

local setup_terminal_tab = function()
	vim.cmd.startinsert()
	vim.api.nvim_buf_set_name(
		0,
		vim.uv.cwd()..' ('..vim.api.nvim_get_current_tabpage()..')'
	)
end

vim.g.neovide_scroll_animation_length = 0.1
vim.g.neovide_cursor_animation_length = 0.4
vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_fullscreen = true
vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

vim.o.guifont = 'UbuntuMono Nerd Font:h12'
vim.o.number, vim.o.relativenumber = true, true
vim.o.ignorecase, vim.o.smartcase = true, true
vim.o.undofile, vim.o.swapfile = true, false
vim.o.wrap = false
vim.o.timeoutlen = 400
vim.o.virtualedit = 'all'
vim.o.statusline = '%{substitute(bufname("%"), " (\\\\d\\\\+)$", "", "")}%M %v'

vim.opt.clipboard:append 'unnamedplus'
vim.opt.diffopt:append 'algorithm:patience'
vim.opt.diffopt:append 'linematch:300'

vim.keymap.set('t', '<c-[>', function()
	if vim.bo.filetype == 'fzf' then
		vim.api.nvim_feedkeys(vim.keycode('<c-[>'), 'n', false)
		return
	end
	vim.api.nvim_feedkeys(vim.keycode('<c-\\><c-n>'), 'n', false)
end)
vim.keymap.set('t', '<c-]>', '<c-[>')
vim.keymap.set('n', 'U', '<c-r>')
vim.keymap.set({'n', 'v'}, '?', function() vim.fn.setreg('/', '') end)
vim.keymap.set('n', 'yp', function()
	vim.fn.setreg('*', vim.fn.expand '%:p')
end)
vim.keymap.set('n', 'yr', function()
	vim.fn.setreg('*', vim.fn.expand '%:.')
end)
vim.keymap.set('n', 'gf', function()
	vim.system{'open', '-R', vim.api.nvim_buf_get_name(0)}
end)
vim.keymap.set({'n', 'v'}, '<c-c>', require 'vim._comment'.operator, {
	expr = true,
})
vim.keymap.set('n', '<d-=>', function() change_font_size(font_size_factor) end)
vim.keymap.set('n', '<d-->', function()
	change_font_size(1/font_size_factor)
end)
vim.keymap.set('i', '<c-l>', '<c-o>l')
-- Enable copying and pasting in Neovide.
vim.keymap.set('v', '<d-c>', '"+y')
vim.keymap.set({'', 'i', 'c', 't'}, '<d-v>', function()
	vim.api.nvim_paste(vim.fn.getreg '+', true, -1)
end)

local lazy_path = vim.fn.stdpath 'data'..'/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazy_path) then vim.system{
	'git', 'clone', '--depth=1', '--filter=blob:none',
	'https://github.com/folke/lazy.nvim.git', lazy_path,
} end
vim.opt.rtp:prepend(lazy_path)
require 'lazy'.setup{
	'nvim-lua/plenary.nvim',
	{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

	'catppuccin/nvim',
	'chomosuke/term-edit.nvim',
	'tpope/vim-sleuth',
	'stevearc/oil.nvim',
	'ibhagwan/fzf-lua',
	'sindrets/winshift.nvim',
	'akinsho/bufferline.nvim',
	{'ggandor/leap.nvim', commit = '3c49d30'},
	{'kylechui/nvim-surround', opts = {}},
	{'mason-org/mason.nvim', opts = {}},
	'mason-org/mason-lspconfig.nvim',
	'neovim/nvim-lspconfig',
	{'saghen/blink.cmp', version = '1.*'},
	{'windwp/nvim-autopairs', opts = {}},
	{'windwp/nvim-ts-autotag', opts = {}},
	{'folke/ts-comments.nvim', opts = {}},
	'tpope/vim-fugitive',
	'rmagatti/auto-session',
}
vim.keymap.set('n', 'S', require 'lazy'.sync)

local transparent_bg = false
local apply_colorscheme = function()
	transparent_bg = not transparent_bg
	require 'catppuccin'.setup{transparent_background = transparent_bg}
	vim.cmd.colorscheme 'catppuccin-nvim'
end
apply_colorscheme()
vim.keymap.set('n', '<d-b>', apply_colorscheme)

require 'term-edit'.setup{
	prompt_end = '%$ ',
	mapping = {n = {
		['s'] = false,
		['S'] = false,
		['<C-i>'] = false,
	}},
}

require 'oil'.setup{
	keymaps = {
		['<C-h>'] = false,
		['<C-l>'] = false,
		['<c-v>'] = 'actions.select_vsplit',
	},
	cleanup_delay_ms = 60000,
}
vim.keymap.set('n', 'gl', function() vim.cmd 'vertical Oil' end)

require 'fzf-lua'.setup{
	winopts = {fullscreen = true},
	keymap = {fzf = {['ctrl-q'] = 'select-all+accept'}},
	grep = {RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH},
	lsp = {jump1 = false},
}
vim.keymap.del('n', 'gcc')
vim.keymap.set('n', 'gc', function()
	require 'fzf-lua'.live_grep{resume = true}
end)
vim.keymap.set('n', 'gn', require 'fzf-lua'.git_files)

vim.keymap.set('n', 'm', vim.cmd.WinShift)
for _, action in ipairs{'h', 'j', 'k', 'l', '='} do
vim.keymap.set('n', '<c-'..action..'>', '<c-w>'..action) end
vim.keymap.set('n', '<c-->', '<c-w>_')
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
	name_formatter = function(b) return b.name:gsub(' %(%d+%)$', '') end,
}}
vim.keymap.set('n', 'gt', require 'fzf-lua'.tabs)
for index = 1, 9 do
	vim.keymap.set({'n', 'i', 't'}, '<d-'..index..'>', function()
		if index > #vim.api.nvim_list_tabpages() then return end
		vim.cmd.tabnext(index)
	end)
end
vim.keymap.set('n', '<d-d>', function() vim.cmd 'tab split' end)
vim.keymap.set({'n', 't'}, '<d-c>', function()
	vim.rpcnotify(0, 'Exit', 0)
	if vim.bo.buftype == 'terminal' then
		vim.api.nvim_buf_delete(0, {force = true})
	elseif #vim.api.nvim_list_tabpages() > 1 then vim.cmd.tabclose() end
end)
vim.keymap.set('n', '<d-r>', function() vim.cmd '.+1,$tabdo :tabclose' end)
vim.keymap.set('n', '<d-k>', function() vim.cmd.tabmove '+1' end)
vim.keymap.set('n', '<d-j>', function() vim.cmd.tabmove '-1' end)
vim.keymap.set('n', '<d-l>', vim.cmd.tabnext)
vim.keymap.set('n', '<d-h>', vim.cmd.tabprevious)
vim.keymap.set('n', '<d-t>', function()
	vim.cmd 'tab terminal'
	setup_terminal_tab()
end)

vim.keymap.set({'n', 'v'}, 's', function()
	require 'leap'.leap{target_windows = {vim.api.nvim_get_current_win()}}
end)

require 'mason-lspconfig'.setup{ensure_installed = {
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

require 'blink.cmp'.setup{keymap = {preset = 'enter'}}

vim.cmd.packadd 'nvim.undotree'
vim.keymap.set('n', 'gh', vim.cmd.Undotree)

local on_restore = {function()
	if vim.api.nvim_buf_get_name(0) ~= '' then return end
	vim.cmd.terminal()
	setup_terminal_tab()
end}
require 'auto-session'.setup{
	single_session_mode = true,
	pre_save_cmds = {function()
		for _, b in ipairs(vim.api.nvim_list_bufs()) do
			if vim.bo[b].buftype == 'terminal'
				or #vim.fn.win_findbuf(b) == 0 then
				vim.api.nvim_buf_delete(b, {force = true})
			end
		end
	end},
	post_restore_cmds = on_restore,
	no_restore_cmds = on_restore,
}
