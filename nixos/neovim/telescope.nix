{ pkgs, inputs, system, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          require('telescope').setup{}
          nmap("<leader>ff", ":Telescope find_files<cr>")
          nmap("<leader>fg", ":Telescope live_grep<cr>")
          nmap("<leader>fb", ":Telescope buffers<cr>")
          nmap("<leader>fh", ":Telescope help_tags<cr>")
        '';
      }
      {
        plugin = telescope-fzf-native-nvim;
        type = "lua";
        config = ''
          require('telescope').load_extension('fzf')
        '';
      }

    ];
  };
}
