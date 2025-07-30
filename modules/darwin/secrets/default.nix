{...}: {
  # Use the same secrets (agenix) module for darwin as we have already configured
  # for nixos as its functionality is not system-dependent.

  imports = [../../nixos/secrets];
}
