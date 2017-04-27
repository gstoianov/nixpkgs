{ stdenv, fetchgit, perl, buildLinux, ... } @ args:

import ./generic.nix (args // rec {
  version = "4.11-rc6";
  modDirVersion = "4.11.0-rc6";
  extraMeta.branch = "4.11";

  src = fetchgit {
    url = "https://gitlab.com/jimdigriz/linux.git";
    rev = "ecb33b94";
    sha256 = "0nq7xnfb32jhn47r044wfbz7sjld1264s6y0a74pnj0m2qdj2r5w";
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
