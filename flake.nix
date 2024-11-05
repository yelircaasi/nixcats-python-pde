{
  description = "A Neovim configuration for the stubborn Nixian hacker";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/f7542cb59c3215123304811023035d4470751b2f";
    nixCats.url = "github:BirdeeHub/nixCats-nvim/6ea180744a6e95b591b0d8e0caa9e99ef6c81a0b";

    blink-cmp = {
      url = "github:Saghen/blink.cmp/1628800e1747ecc767368cab45916177c723da82";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugins-typst-preview = {
      url = "github:chomosuke/typst-preview.nvim/06778d1b3d4d29c34f1faf80947b586f403689ba";
      flake = false;
    };

    plugins-lsp-progress = {
      url = "github:linrongbin16/lsp-progress.nvim/d5f4d28efe75ce636bfbe271eb45f39689765aab";
      flake = false;
    };

    plugins-xit-nvim = {
      url = "github:synaptiko/xit.nvim/8f724f76c595f02a5bed2904ae556f60c62510f6";
      flake = false;
    };

    nix-treesitter = {
      url = "github:ratson/nix-treesitter/4b8e8ddd71b0aee38976116adf178760905f57e5";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nixCats,
      ...
    }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = "${./.}";
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      extra_pkg_config = {
        # allowUnfree = true;
      };
      inherit
        (forEachSystem (
          system:
          let
            dependencyOverlays = (import ./nix/overlays.nix) ++ [
              # This overlay grabs all the inputs named in the format
              # `plugins-<pluginName>`
              # Once we add this overlay to our nixpkgs, we are able to
              # use `pkgs.neovimPlugins`, which is a set of our plugins.
              (utils.standardPluginOverlay inputs)
              # add any flake overlays here.
            ];
          in
          # these overlays will be wrapped with ${system}
          # and we will call the same utils.eachSystem function
          # later on to access them.
          {
            inherit dependencyOverlays;
          }
        ))
        dependencyOverlays
        ;
      # see :help nixCats.flake.outputs.categories
      # and
      # :help nixCats.flake.outputs.categoryDefinitions.scheme
      
      categoryDefinitions =
        {
          pkgs,
          settings,
          categories,
          name,
          ...
        }@packageDef:
        {
          # lspsAndRuntimeDeps: this section is for dependencies that should be
          # available at RUN TIME for plugins. Will be available to PATH within
          # neovim terminal this includes LSPs
          lspsAndRuntimeDeps = {
            general = with pkgs; [
              # essential
              ripgrep
              python312Packages.pylatexenc
              fd

              # lsps (minimal because should be provided per-project by nix)
              nixd
              tinymist

              # formatters
              nixfmt-rfc-style
              nodePackages_latest.prettier
              taplo
              typstyle
              rustfmt
              black
              stylua
              marksman
            ];
          };

          # install lz.n and treesitter grammars
          startupPlugins = {
            gitPlugins = with pkgs.neovimPlugins; [ xit-nvim ];
            general = with pkgs.vimPlugins; [
              lz-n
              (nvim-treesitter.withPlugins (
                p:
                (with p; [
                  lua
                  c
                  javascript
                  typescript
                  rust
                  haskell
                  typst
                  latex
                  nix
                  json
                  toml
                  yaml
                  markdown
                  markdown_inline
                  svelte
                  css
                  html
                  vim
                  bash
                  make
                  gitcommit
                  inputs.nix-treesitter.packages.${pkgs.system}.tree-sitter-xit
                ])
              ))
            ];
          };

          # plugins which are installed, but not loaded, and will be handled by
          # lz.n (not necessarily lazy loaded)
          optionalPlugins = {
            gitPlugins = with pkgs.neovimPlugins; [
              inputs.blink-cmp.packages.${pkgs.system}.default
              typst-preview
              lsp-progress
            ];
            general = with pkgs.vimPlugins; [
              nvim-autopairs
              nvim-lspconfig
              which-key-nvim
              telescope-nvim
              markdown-preview-nvim
              render-markdown-nvim
              rose-pine
              nvim-web-devicons
              oil-nvim
              telescope-ui-select-nvim
              harpoon2
              toggleterm-nvim
              trouble-nvim
              lualine-nvim
              mini-ai
              mini-hipatterns
              mini-surround
              mini-notify
              mini-starter
              mini-trailspace
              cellular-automaton-nvim
              indent-blankline-nvim
              mini-bufremove
              neogit
              gitsigns-nvim
              diffview-nvim
              barbecue-nvim
              undotree
              conform-nvim
              neocord
              rustaceanvim
              crates-nvim
              haskell-tools-nvim
              vim-wakatime
              lsp_lines-nvim
              vim-sleuth
              typescript-tools-nvim
            ];
          };

          # shared libraries to be added to LD_LIBRARY_PATH
          # variable available to nvim runtime
          sharedLibraries = {
            general = with pkgs; [
              # libgit2
            ];
          };
        };
      packageDefinitions = {
        pde =
          { pkgs, ... }:
          {
            settings = {
              wrapRc = true;
              aliases = [
                "vim"
                "vi"
              ];
            };
            categories = {
              general = true;
              gitPlugins = true;
              customPlugins = true;
              bin = {
                websocat = "${pkgs.websocat}/bin/websocat";
                tinymist = "${pkgs.tinymist}/bin/tinymist";
              };
              nixdExtras = {
                nixpkgs = inputs.nixpkgs.outPath;
                flake-path = inputs.self.outPath;
                system = pkgs.system;
              };
            };
          };
      };
      defaultPackageName = "pde";
    in
    forEachSystem (
      system:
      let
        nixCatsBuilder = utils.baseBuilder luaPath {
          inherit
            nixpkgs
            system
            dependencyOverlays
            extra_pkg_config
            ;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        pkgs = import nixpkgs { inherit system; };
        
      in
      {
        packages = utils.mkAllWithDefault defaultPackage;

        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [ defaultPackage ] ++ (with pkgs; [ lua-language-server ]);
          };
        };

      }
    )
    // {
      overlays = utils.makeOverlays luaPath {
        inherit nixpkgs dependencyOverlays extra_pkg_config;
      } categoryDefinitions packageDefinitions defaultPackageName;

      nixosModules.default = utils.mkNixosModules {
        inherit
          defaultPackageName
          dependencyOverlays
          luaPath
          categoryDefinitions
          packageDefinitions
          extra_pkg_config
          nixpkgs
          ;
      };
      homeModule = utils.mkHomeModules {
        inherit
          defaultPackageName
          dependencyOverlays
          luaPath
          categoryDefinitions
          packageDefinitions
          extra_pkg_config
          nixpkgs
          ;
      };
      inherit utils;
      inherit (utils) templates;
    };

}
