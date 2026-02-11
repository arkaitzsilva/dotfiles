# Enable GPU support
final: prev: {
  btop = prev.btop.overrideAttrs(finalAttrs: prevAttrs: {
    cmakeFlags = (prevAttrs.cmakeFlags or []) ++ [
      (prev.lib.cmakeBool "BTOP_GPU" true)
      (prev.lib.cmakeBool "BTOP_STATIC" false)
    ];

    nativeBuildInputs =
      (prevAttrs.nativeBuildInputs or [])
      ++ [ prev.autoAddDriverRunpath ];
  });
}
