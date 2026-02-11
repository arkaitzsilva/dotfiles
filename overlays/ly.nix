# Add language translations
final: prev: {
  ly = prev.ly.overrideAttrs(finalAttrs: prevAttrs: {
    postInstall = (prevAttrs.postInstall or "") + ''
      mkdir -p $out/etc/ly/lang
      cp -v res/lang/*.ini $out/etc/ly/lang/
    '';
  });  
}
