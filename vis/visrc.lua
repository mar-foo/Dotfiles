require('vis')

local vis_config_path = os.getenv("HOME")..'.config/vis/plugins/vis-plug'

local plug = require('plugins/vis-plug')

local plugins = {
	{url = 'https://gitlab.com/timoha/vis-go', file = 'vis-go'},
	{url = 'https://git.sr.ht/~mcepl/vis-fzf-open'},
	{url = 'erf/vis-minimal-theme', theme = true, file = 'dark'},
	{'kupospelov/vis-ctags'}
}

plug.init(plugins, true)
require('plugins/tmux')

vis.events.subscribe(vis.events.INIT, function()
	vis.lexers.STYLE_DEFAULT = 'back:default'
	-- vis.lexers.STYLE_SELECTION = 'back:#005577'
	vis:command('map normal "  " :fzf-tmux<Enter>')
	vis:command('map insert jk <Escape>')
	vis:command('map insert kj <Escape>')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function()
	vis:command('set relativenumbers')
	vis:command('set cursorline')
	vis:command('set autoindent')
	vis:command('set colorcolumn 80')
end)