--[[
88                                   
88                                   
88                                   
88 ,adPPYYba, 888888888 8b       d8  
88 ""     `Y8      a8P" `8b     d8'  
88 ,adPPPPP88   ,d8P'    `8b   d8'   
88 88,    ,88 ,d8"        `8b,d8'    
88 `"8bbdP"Y8 888888888     Y88'     
                            d8'      
                           d8'  
                          88                     
                         ""                     
                                               
8b,dPPYba,  8b       d8 88 88,dPYba,,adPYba,   
88P'   `"8a `8b     d8' 88 88P'   "88"    "8a  
88       88  `8b   d8'  88 88      88      88  
88       88   `8b,d8'   88 88      88      88  
88       88     "8"     88 88      88      88 

ASCII art from https://ascii.co.uk/text
style: Default Font 
]]
-- install lazy.nvim automatically if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup({
	-- Colour schemes
"lunarvim/darkplus.nvim",
"jacoborus/tender.vim",

-- Top tab bar - BarBar
{
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},

	init = function()
		vim.g.barbar_auto_setup = false
	end,

	opts = {

		-- enable animations
		animation = true,
		-- clickable by mouse
		clickable = true,
		-- disable top bar when only 1 buffer
		auto_hide = true,
		-- highlight visible buffers
		highlight_visible = true,

		icons = {
			-- Configure the base icons on the bufferline.
			-- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
			buffer_index = false,
			buffer_number = false,
			button = "",
			-- Enables / disables diagnostic symbols
			diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ" },
				[vim.diagnostic.severity.WARN] = { enabled = false },
				[vim.diagnostic.severity.INFO] = { enabled = false },
				[vim.diagnostic.severity.HINT] = { enabled = true },
			},
			gitsigns = {
				added = { enabled = true, icon = "+" },
				changed = { enabled = true, icon = "~" },
				deleted = { enabled = true, icon = "-" },
			},
			filetype = {
				-- Sets the icon's highlight group.
				-- If false, will use nvim-web-devicons colors
				custom_colors = false,

				-- Requires `nvim-web-devicons` if `true`
				enabled = true,
			},
			separator = { left = "▎", right = "" },

      -- Configure the icons on the bufferline when modified or pinned.
			-- Supports all the base icon options.
			modified = { button = "●" },
			pinned = { button = "", filename = true },

			-- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
			preset = "default",

			-- Configure the icons on the bufferline based on the visibility of a buffer.
			-- Supports all the base icon options, plus `modified` and `pinned`.
			alternate = { filetype = { enabled = false } },
			current = { buffer_index = true },
			inactive = { button = "×" },
			visible = { modified = { buffer_number = false } },
		},
		-- Set the filetypes which barbar will offset itself for
		sidebar_filetypes = {
			-- Use the default values: {event = 'BufWinLeave', text = nil}
			NvimTree = true,
		},
  },
},

-- bottom status line
{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opts = true } },

-- Nvim tree file browser
"nvim-tree/nvim-tree.lua",

-- show indents
"lukas-reineke/indent-blankline.nvim",

-- Treesitter
{ "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update { sync = true }
end,
dependencies = { "HiPhish/nvim-ts-rainbow2" } },

--[[Telescope.nvim - make sure gcc or clang is installed
as well as fd-find and ripgrep ]]
{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

{ "nvim-telescope/telescope.nvim", tag = "0.1.1", dependencies = { "nvim-lua/plenary.nvim" } },

-- which-key gives reminders of key functions
"folke/which-key.nvim",

{"neoclide/coc.nvim", branch = {"release"} },
})
