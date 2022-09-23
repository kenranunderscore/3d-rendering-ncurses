{
  description = "Trying out ncurses rendering";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      devShells.x86_64-linux.default =
        pkgs.mkShell { buildInputs = with pkgs; [ ncurses nim nimlsp ]; };
    };
}
