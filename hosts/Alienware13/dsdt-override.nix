{ pkgs, lib, ... }:

let
  acpiOverride = pkgs.stdenv.mkDerivation {
    name = "acpi-dsdt-override";
    cpio_path = "kernel/firmware/acpi";

    src = ./acpi/dsdt-a11.aml;

    nativeBuildInputs = [ pkgs.cpio ];

    unpackPhase = "true";

    installPhase = ''
      mkdir -p $cpio_path
      cp $src $cpio_path/dsdt.aml
      find kernel | cpio -H newc --create > acpi_override
      cp acpi_override $out
    '';
  };
in
{
  boot.initrd.prepend = [ (toString acpiOverride) ];
  boot.kernelParams = [ "acpi_override=1" ];
}
