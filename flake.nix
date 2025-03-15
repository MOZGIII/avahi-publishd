{
  description = "avahi-subdomains";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = { self, nixpkgs }:
    let

      # System types to support.
      supportedSystems =
        [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlay ];
        });

    in {

      # A Nixpkgs overlay.
      overlay = import ./default.nix;

      # Provide some binary packages for selected system types.
      packages = forAllSystems
        (system: { inherit (nixpkgsFor.${system}) avahi-subdomains; });

      # The default package for 'nix build'. This makes sense if the
      # flake provides only one package or there is a clear "main"
      # package.
      defaultPackage =
        forAllSystems (system: self.packages.${system}.avahi-subdomains);

      # A NixOS module.
      nixosModules.default = import ./nix/nixos/modules/default.nix;
    };
}
