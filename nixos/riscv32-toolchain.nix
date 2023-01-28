# Nix Shell for a riscv32 toolchain (compiler, assembler, linker, debugger etc)

with import <nixpkgs> {
  crossSystem = {
    config = "riscv32-unknown-linux-gnu";
  };
};
mkShell {
  nativeBuildInputs = with buildPackages; [ gcc gdb ];
  buildInputs = [  ];
}
