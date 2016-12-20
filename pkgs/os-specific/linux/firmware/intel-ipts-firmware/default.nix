{ stdenv, fetchgit }:

stdenv.mkDerivation {
  name = "intel-ipts-firmware";

  # src = {
  #   ipts_desc = ./iaPreciseTouchDescriptor.bin;
  #   vendor_desc = ./SurfaceTouchServicingDescriptorMSHW0078.bin;
  #   vendor_kernel = ./SurfaceTouchServicingKernelSKLMSHW0078.bin;
  #   config = ./SurfaceTouchServicingSFTConfigMSHW0078.bin;
  #   # ./SurfaceTouchServicingTouchBlobMSHW0078.bin;
  # };

  src = ./bins;

  # phases = [ "unpackPhase" "installPhase" ];
  phases = [ "installPhase" ];

  unpackPhase =
    ''
    echo $src
    ls $src
    '';

  installPhase = ''
    ls
    mkdir -p $out/lib/firmware/intel/ipts
    ln -s $src/iaPreciseTouchDescriptor.bin $out/lib/firmware/intel/ipts/
    ln -s $src/SurfaceTouchServicingDescriptorMSHW0078.bin $out/lib/firmware/intel/ipts/
    ln -s $src/SurfaceTouchServicingKernelSKLMSHW0078.bin $out/lib/firmware/intel/ipts/
    ln -s $src/SurfaceTouchServicingSFTConfigMSHW0078.bin $out/lib/firmware/intel/ipts/
    ln -s $out/lib/firmware/intel/ipts/iaPreciseTouchDescriptor.bin $out/lib/firmware/intel/ipts/intel_desc.bin
    ln -s $out/lib/firmware/intel/ipts/SurfaceTouchServicingDescriptorMSHW0078.bin $out/lib/firmware/intel/ipts/vendor_desc.bin
    ln -s $out/lib/firmware/intel/ipts/SurfaceTouchServicingKernelSKLMSHW0078.bin $out/lib/firmware/intel/ipts/vendor_kernel.bin
    ln -s $out/lib/firmware/intel/ipts/SurfaceTouchServicingSFTConfigMSHW0078.bin $out/lib/firmware/intel/ipts/config.bin
  '';

  meta = with stdenv.lib; {
    description = "Firmware for Intel IPTS";
    license = licenses.unfreeRedistributableFirmware;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}
