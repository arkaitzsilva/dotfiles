{ pkgs, lib, ... }:

let
  acpiOverride = pkgs.stdenv.mkDerivation {
    name = "acpi-dsdt-override";
    CPIO_PATH = "kernel/firmware/acpi";

    src = ./acpi/dsdt.aml;

    nativeBuildInputs = [ pkgs.cpio ];

    unpackPhase = "true";

    installPhase = ''
      mkdir -p $CPIO_PATH
      cp $src $CPIO_PATH/dsdt.aml
      find kernel | cpio -H newc --create > acpi_override
      cp acpi_override $out
    '';
  };
in
{
  boot.initrd.prepend = [ (toString acpiOverride) ];
  boot.kernelParams = [ "acpi_override=1" ];
}
