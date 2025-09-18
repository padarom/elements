{
  config,
  lib,
  ...
}: {
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.swraid.enable = true;

  networking.useDHCP = lib.mkDefault true;

  virtualisation.virtualbox.guest.enable = true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fileSystems."/mnt/external" = {
    device = "/dev/disk/by-uuid/0fc53086-d326-4663-973c-aa224a3f8589";
    fsType = "ext4";
    options = [
      "nofail"
      "exec"
      "users"
    ];
  };
}
