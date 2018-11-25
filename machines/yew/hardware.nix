{ lib, staging, ... }:

{
  imports = [ <nixpkgs/nixos/modules/profiles/qemu-guest.nix> ];

  config = lib.mkIf (!staging) {
    boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_blk" ];
    boot.kernelModules = [ "kvm-intel" ];
    fileSystems."/" = { device = "/dev/vda1"; fsType = "ext4"; };
    nix.maxJobs = 1;

    boot.loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/vda";
    };
  };
}