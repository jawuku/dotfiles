# Configuration file for Home-Manager
{ config
, pkgs
, ...
}:
let
  # Add unstable channel to install a few packages - type following 2 commands:
  # sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
  # sudo nix-channel --update
   unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  # Python with packages
  my-Python-packages = ps:
    with ps; [
      sympy
      seaborn
      scikit-learn
      gmpy2
      statsmodels
      requests
      pyyaml
      pycountry
      beautifulsoup4
      pyspark
      notebook
    ];
  # Neovim custom plugin for Lisp brackets
nvim-parinfer = pkgs.vimUtils.buildVimPlugin {
  name = "nvim-parinfer";
  src = pkgs.fetchFromGitHub {
    owner = "gpanders";
    repo = "nvim-parinfer";
    rev = "5ca09287ab3f4144f78ff7977fabc27466f71044";
    sha256 = "diwLtmch8LzaX7FIwBNy78n3iY7VnqMC1n0ep8k5kWE=";
  };
};

in
{
  # Home packages
  home.packages = with pkgs; let
    R-with-packages = rWrapper.override {
      packages = with rPackages; [
        tidyverse
        languageserver
      ];
    };
  in
  ([
    bat
    eza
    pfetch
    julia-bin
    (python311.withPackages my-Python-packages)
    R-with-packages
    gcc
    xclip
    ripes # Risc-v visual simulator
    sqlite
    sequeler
    nil
    nixpkgs-fmt
    statix
    (leiningen.override { jdk = pkgs.jdk11; })
    (clojure.override { jdk = pkgs.jdk11; })
    (scala_3.override { jre = pkgs.graalvm-ce; })
    (sbt.override { jre = pkgs.graalvm-ce; })
    clojure-lsp
    clj-kondo
    metals
    graalvm-ce
    nodePackages.bash-language-server
    octaveFull
  ])

  # Add any packages from 'unstable' channel to get latest versions
  ++ (with unstable; [
    ruff ruff-lsp
  ]);

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -la --icons";
      lt = "eza --tree --icons";
      cat = "bat";
      rebuild = "sudo nixos-rebuild switch";
      trash = "sudo nix-collect-garbage -d";
      update = "sudo nix-channel --update";
      nixconfig = "sudo -Es hx /etc/nixos/configuration.nix";
      homeconfig = "sudo -Es hx /etc/nixos/home.nix";
    };
    sessionVariables = {
      EDITOR = "hx";
      BAT_THEME = "Monokai Extended";
    };
  };

  # network settings for virt-manager
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # configure neovim using nixpkgs
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      # dependencies
      plenary-nvim
      nvim-web-devicons
      nui-nvim

      # colour themes
      tender-vim
      gruvbox-nvim

      # LSP setup
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local lspconfig = require('lspconfig')
          
          lspconfig.ruff_lsp.setup{
            init_options = {
              settings = {
                -- Any extra CLI arguments for `ruff` go here.
                args = {},
              }
            }
          }

          lspconfig.clojure_lsp.setup {}
          
          lspconfig.nil_ls.setup {}
          
          lspconfig.bashls.setup {}
        '';
      }

      # top buffer line
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          require('bufferline').setup {}
        '';
      }

      # bottom bar
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup {
            options = { theme = 'papercolor_light' },
          }
        '';
      }

      # file navigation
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup({
            filters = { dotfiles = true },
            renderer = {
              group_empty = true,
              -- Folder open and closed icons
              icons = {
                glyphs = {
                  folder = {
                    arrow_closed = "▸", -- arrow when folder is closed
                    arrow_open = "▾"  -- arrow when folder is open
                  }
                }
              }
            },
            -- disable window_picker
            -- for explorer to work well with window splits
            actions = {
              open_file = {
                window_picker = {
                  enable = false
                }
              }
            }
          })
        '';
      }

      # show indentation
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          require('ibl').setup{
            indent = { char = "┆"}, -- unicode 0x2506
          }
        '';
      }
      # Treesitter
      nvim-treesitter
      nvim-treesitter.withAllGrammars
      rainbow-delimiters-nvim

      # Telescope
      telescope-nvim
      telescope-fzf-native-nvim

      # other useful utilities
      which-key-nvim
      {
        plugin = comment-nvim;
        type = "lua";
        config = ''
          require('Comment').setup{}
        '';
      }
      noice-nvim
      nvim-autopairs
      nvim-parinfer
    ];
    extraLuaConfig = ''
      -- options
      local myoptions = {
        expandtab = true,
        modeline = false,
        shiftwidth = 2,
        smartindent = true,
        tabstop = 2,
        softtabstop = 2,
        autochdir = true,
        clipboard = "unnamedplus",
        cmdheight = 2,
        confirm = true,
        hidden = true,
        ignorecase = true,
        joinspaces = false,
        scrolloff = 4,
        shiftround = true,
        showmode = false,
        sidescrolloff = 8,
        smartcase = true,
        splitbelow = true,
        splitright = true,
        termguicolors = true,
        wildmode = "list:longest",
        foldmethod = "expr",
        foldexpr = "nvim_treesitter#foldexpr()",
        list = true,
        number = true,
        relativenumber = true,
        signcolumn = "yes",
        undofile = true,
        background = "dark",
        foldenable = false,
        mouse = "a", -- enable mouse support
        updatetime = 300 -- reduce refresh time from 4000 ms
      }

      for k, v in pairs(myoptions) do vim.opt[k] = v end

      -- set tabs to be 4 spaces in Python and Julia
      vim.cmd [[autocmd Filetype python setlocal et ts=4 sw=4 sts=4]]
      vim.cmd [[autocmd Filetype julia  setlocal et ts=4 sw=4 sts=4]]

      -- Disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- telescope nvim setup
      require('telescope').setup()
      require('telescope').load_extension('fzf')
      
      -- treesitter setup
      require 'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
      }

      -- noice setup
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })

      -- Keymaps
      -- set leader key to space
      vim.g.mapleader = " "

      -- set local leader to comma
      vim.g.maplocalleader = ","
      
      -- Global mappings for LSP
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<space>f',
      function() vim.lsp.buf.format { async = true } end, opts)
      end
      })

      -- switch to windows above / below / left / right
      vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
      vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
      vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
      vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })

      vim.keymap.set("n", "<C-left>", "<C-w>h", { noremap = true })
      vim.keymap.set("n", "<C-right>", "<C-w>l", { noremap = true })
      vim.keymap.set("n", "<C-up>", "<C-w>k", { noremap = true })
      vim.keymap.set("n", "<C-down>", "<C-w>j", { noremap = true })

      -- '>' in Visual mode inserts an indent
      -- '<' removes it
      vim.keymap.set("v", "<", "<gv", { noremap = true, silent = false })
      vim.keymap.set("v", ">", ">gv", { noremap = true, silent = false })
      -- increment/decrement numbers with <leader>= and <leader>- respectively
      vim.keymap.set("n", "<leader>=", "<C-a>")
      vim.keymap.set("n", "<leader>-", "<C-x>")

      -- select all with Ctrl-a
      vim.keymap.set("n", "<C-a>", "gg<S-v>G", { noremap = true })

      -- [[ Which-key ]]
      require("which-key").setup {}

      local wk = require("which-key")

-- mappings which are for the leader key
local mappings = {
  q = { ":q<cr>", "Quit" },
  Q = { ":wq<cr>", "Save and Quit" },
  w = { ":w<cr>", "Save (Write)" },
  n = { ":NvimTreeToggle<cr>", "Toggle Nvim Tree" },
  E = { ":e ~/.config/nvim/init.vim<cr>", "Edit base config" },

  -- Find files through Telescope.nvim
  ff = { ":Telescope find_files<cr>", "Telescope find files" },
  fg = { ":Telescope live_grep<cr>", "Telescope live grep" },
  fb = { ":Telescope buffers<cr>", "Telescope buffers" },
  fh = { ":Telescope help_tags<cr>", "Telescope help tags" },

  -- split screens (horizontal and vertical reversed, in Python Numpy style)
  sh = { ":vsplit<cr>", "Horizontal Split(Python Style)" },
  sv = { ":split<cr>", "Vertical Split(Python Style)" },
  sd = { ":close<cr>", "Close current split" },
  se = { "<C-w>=", "Resize splits equally" },

  -- buffer actions
  bp = { ":bprevious<cr>", "Jump to previous buffer" },
  bn = { ":bnext<cr>", "Jump to next buffer" },
  be = { ":enew<cr>", "Create new buffer" },
  bd = { ":bdelete<cr>", "Close current buffer" },

  bf = { ":lua vim.lsp.buf.format({ timeout = 2000 })<cr>", "Format buffer" }
}

local opts = { prefix = "<leader>" }

wk.register(mappings, opts)

-- colourschemes - set custom commands
vim.cmd[[command Tender set background=dark | colo tender]]
vim.cmd[[command Gruvbox set background=light | colo gruvbox]]
-- Tender is default theme
vim.cmd[[colorscheme tender]]
    '';
  };

/* Comment out Wezterm and Kitty - Cinnamon's terminal works OK for now
  # wezterm terminal emulator setup
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        font = wezterm.font {
          family = "RobotoMono Nerd Font",
        },

        enable_scroll_bar = false,

        -- color_scheme = "Dimmed Monokai (Gogh)",
        -- color_scheme = "Dark+",
        -- color_scheme = "Doom Peacock",
        color_scheme = "Tender (Gogh)",

        scrollback_lines = 10240,

        font_size = 16,

        enable_tab_bar = true,

        hide_tab_bar_if_only_one_tab = true,

        automatically_reload_config = true,

        default_cursor_style = "BlinkingBar",

        initial_cols = 80,

        initial_rows = 25,
      }
    '';
  };

    programs.kitty = {
    enable = true;
    settings = {
      font_size = "14.0";
      font_family = "FiraCode Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      disable_ligatures = true;
      # font_features = "+ss02 +ss08 +cv16 +ss05";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      remember_window_size = true;
      initial_window_width = "87c";
      initial_window_height = "25c";

      # Kitty Gruvbox Light Theme
      # Based on https://github.com/morhetz/gruvbox by morhetz <morhetz@gmail.com>
      # Adapted to kitty by wdomitrz <witekdomitrz@gmail.com>

      cursor = "#928374";
      cursor_text_color = "#fbf1c7";
      url_color = "#458588";

      visual_bell_color = "#689d6a";
      bell_border_color = "#689d6a";

      active_border_color = "#b16286";
      inactive_border_color = "#1d2021";

      foreground = "#3c3836";
      background = "#fbf1c7";
      selection_foreground = "#928374";
      selection_background = "#3c3836";

      active_tab_foreground = "#282828";
      active_tab_background = "#928374";
      inactive_tab_foreground = "#7c6f64";
      inactive_tab_background = "#ebdbb2";

      # white (bg3/bg4)
      color0 = "#bdae93";
      color8 = "#a89984";

      # red
      color1 = "#cc241d";
      color9 = "#9d0006";

      # green
      color2 = "#98971a";
      color10 = "#79740e";

      # yellow
      color3 = "#d79921";
      color11 = "#b57614";

      # blue
      color4 = "#458588";
      color12 = "#076678";

      # purple
      color5 = "#b16286";
      color13 = "#8f3f71";

      # aqua
      color6 = "#689d6a";
      color14 = "#427b58";

      # black (fg4/fg3)
      color7 = "#7c6f64";
      color15 = "#665c54";
    };
  };
*/
  home.stateVersion = "23.05";
}
