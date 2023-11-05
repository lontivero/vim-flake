{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim = {
      url = "github:neovim/neovim/stable?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, flake-utils, neovim }:
  let
    overlayFlakeInputs = prev: final: {
      neovim = neovim.packages.x86_64-linux.neovim;
    };

    overlayMyNeovim = prev: final: {
      myNeovim = import ./overlay/default.nix {
        pkgs = final;
      };
    };

    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [ overlayFlakeInputs overlayMyNeovim ];
    };
  in {
      packages.x86_64-linux.default = pkgs.myNeovim;
      apps.x86_64-linux.default = {
        type = "app";
        program = "${pkgs.myNeovim}/bin/nvim";
      };
    };
}
