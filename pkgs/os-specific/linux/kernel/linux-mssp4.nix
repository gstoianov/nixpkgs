{ stdenv, fetchgit, perl, buildLinux, ... } @ args:

import ./generic.nix (args // rec {
  version = "4.9-rc8";
  modDirVersion = "4.9.0-rc8";
  extraMeta.branch = "4.9";

  src = fetchgit {
    url = "https://gitlab.com/jimdigriz/linux.git";
    rev = "8c15950";
    sha256 = "1jdizw25n4vmfipks7fwqiv1if20qkvxhzjmpqlfy1p111wgcm34";
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
