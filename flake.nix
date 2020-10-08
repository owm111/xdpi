{
  description = "X11 DPI information retrieval";
  outputs = { self, nixpkgs }:
    let
      overlay = final: prev: {
        xdpi = final.gcc49Stdenv.mkDerivation {
          pname = "xdpi";
          version = "2015-10-25";
          src = self;
          buildInputs = [ final.xorg.libX11 final.xorg.libXrandr final.xorg.libXinerama ];
          makeFlags = "xcb=0";
          installPhase = "install -Dvm755 -t $out/bin xdpi";
        };
      };
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ overlay ];
      };
      pkg = pkgs.xdpi;
    in {
      inherit overlay;
      packages.x86_64-linux.xdpi = pkg;
      defaultPackage.x86_64-linux = pkg;
    };
}
