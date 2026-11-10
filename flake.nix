{
  description = "iSponsorBlockTV Python development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          python = pkgs.python3;
          pythonEnv = python.withPackages (ps: with ps; [
            aiohttp
            appdirs
            async-cache
            pychromecast
            pyytlounge
            rich-click
            rich
            ssdp
            textual-slider
            textual
            xmltodict
            zeroconf
            yarl
          ]);
        in
        {
          default = pkgs.mkShell {
            packages = [ pythonEnv ];
          };
        });
    };
}
