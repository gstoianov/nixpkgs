{ stdenv, fetchgit, perl, buildLinux, ... } @ args:

import ./generic.nix (args // rec {
  version = "4.9";
  modDirVersion = "4.9.0";
  extraMeta.branch = "4.9";

  src = fetchgit {
    url = "https://gitlab.com/jimdigriz/linux.git";
    rev = "8181ead45d71172fa9b31f5593e91eb3cc632cbe";
    sha256 = "0q2l95mcligpdwx424qcndxrzg0rp980amqadm95vn55p797qzj1";
  };

  extraConfig =
    ''
    INTEL_IPTS m
    BLK_DEV_NVME y
    MODULE_SIG n
    '';
    # SYSTEM_TRUSTED_KEYRING n

  kernelPatches = args.kernelPatches;

  features.iwlwifi = true;
  features.efiBootStub = true;
  features.needsCifsUtils = true;
  features.canDisableNetfilterConntrackHelpers = true;
  features.netfilterRPFilter = true;
} // (args.argsOverride or {}))
