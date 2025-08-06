{
  pkgs,
  config,
  ...
} @ all: {
  elements.secrets = {
    rekeyPath = "christopher_molybdenum";
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHl33DPxxzxrNNjM8rL4ktAj4ExzCyGiU8rKog0csxNA";
  };

  elements.kitty.enable = true;

  home.packages = with pkgs; [
    _elements.to-s3
    _elements.connect-to-mercury
  ];
}
