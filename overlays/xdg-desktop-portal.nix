# Remove unnecessary geoclue & flatpak dependencies
final: prev: {
  xdg-desktop-portal =
    prev.xdg-desktop-portal.overrideAttrs(finalAttrs: prevAttrs: {
      buildInputs = builtins.filter (p: p != prev.geoclue2 && p != prev.flatpak) (prevAttrs.buildInputs or []);
 
      mesonFlags = (prevAttrs.mesonFlags or []) ++ [
        "-Dgeoclue=disabled"
        "-Dtests=disabled"
        "-Dinstalled-tests=false"
        "-Ddocumentation=disabled"
        "-Dsystemd=enabled"
        "-Dgudev=auto"
        "-Dflatpak-interfaces=disabled"
      ];

      preFixup = ''
        mkdir -p $installedTests
      '';
 });
}
