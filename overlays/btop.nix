# Enable GPU support
final: prev: {
  btop = prev.btop.overrideAttrs (oldAttrs: {
    cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [
      (prev.lib.cmakeBool "BTOP_GPU" true)
      (prev.lib.cmakeBool "BTOP_STATIC" false)
    ];

    nativeBuildInputs =
      (oldAttrs.nativeBuildInputs or [])
      ++ [ prev.autoAddDriverRunpath ];
  });
}
