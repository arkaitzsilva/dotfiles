final: prev: {
  nvidia-vaapi-driver =
    prev.nvidia-vaapi-driver.overrideAttrs(finalAttrs: prevAttrs: {
      buildInputs =
        builtins.filter (pkg: pkg != prev.gst_all_1.gst-plugins-bad) prevAttrs.buildInputs;
    });
}
