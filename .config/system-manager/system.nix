{ lib, pkgs, ... }:
let
  jvm = pkgs.graalvmPackages.graalvm-ce;
in
{
  config = {
    nixpkgs.hostPlatform = "x86_64-linux";

    # Enable and configure services
    services = {
      # nginx.enable = true;
    };

    environment = {
      # Packages that should be installed on a system
      systemPackages = with pkgs;
        [
          helix
          btop
          bat
          eza
          microfetch
          cpufetch
          xclip # (or wl-clipboard if on wayland)
          nodejs_26

          # JVM languages
          (leiningen.override { jdk = jvm; })
          (clojure.override { jdk = jvm; })

          # language servers
          clojure-lsp
          clj-kondo
          lua-language-server
          stylua
          bash-language-server
          shellcheck
          shfmt
          marksman
          ltex-ls-plus
          prettierd
          nixd
          nixfmt
          sqruff
          taplo
          simple-completion-language-server
          basedpyright
          ruff
          typescript-language-server
        ]

        ++ [ jvm ]; # Java itself, as defined above

      # Add directories and files to `/etc` and set their permissions
      etc = {
        # with_ownership = {
        #   text = ''
        #     This is just a test!
        #   '';
        #   mode = "0755";
        #   uid = 5;
        #   gid = 6;
        # };
        #
        # with_ownership2 = {
        #   text = ''
        #     This is just a test!
        #   '';
        #   mode = "0755";
        #   user = "nobody";
        #   group = "users";
        # };
      };
    };

    # Enable and configure systemd services
    systemd.services = { };

    # Configure systemd tmpfile settings
    systemd.tmpfiles = {
      # rules = [
      #   "D /var/tmp/system-manager 0755 root root -"
      # ];
      #
      # settings.sample = {
      #   "/var/tmp/sample".d = {
      #     mode = "0755";
      #   };
      # };
    };
  };
}
