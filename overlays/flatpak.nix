# Remove gtk related dependencies
final: prev: {
  flatpak = prev.flatpak.overrideAttrs (prevAttrs: {
    withDconf = false;
    withGtkDoc = false;
    withIntrospection = false;

    postInstall = ''
      ${prevAttrs.postInstall or ""}
      rm -f $out/share/flatpak/triggers/gtk-icon-cache.trigger
    '';
  });
}
