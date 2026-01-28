{pkgs,...}:{
environment.systemPackages = with pkgs; [
rnix-lsp
];

home.packages = with pkgs; [
  neovim
  git
  ripgrep
  fd
  nodejs
];
}

