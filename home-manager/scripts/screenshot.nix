pkgs: let
  notify-send = "${pkgs.libnotify}/bin/notify-send";
  slurp = "${pkgs.slurp}/bin/slurp";
  wayshot = "${pkgs.wayshot}/bin/wayshot";
  swappy = "${pkgs.swappy}/bin/swappy";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
in
  pkgs.writeShellScript "screenshot" ''
    SCREENSHOTS="$HOME/Imágenes/Pantallazos"
    NOW=$(date +%Y-%m-%d_%H-%M-%S)
    TARGET="$SCREENSHOTS/$NOW.png"

    mkdir -p $SCREENSHOTS

    if [[ -n "$1" ]]; then
        ${wayshot} -f $TARGET
    else
        ${wayshot} -f $TARGET -s "$(${slurp})"
    fi

    ${wl-copy} < $TARGET

    RES=$(${notify-send} \
        -a "Pantallazo" \
        -i "image-x-generic-symbolic" \
        -h string:image-path:$TARGET \
        -A "file=Mostrar en destino" \
        -A "view=Ver" \
        -A "edit=Editar" \
        "Nuevo pantallazo" \
        $TARGET)

    case "$RES" in
        "file") xdg-open "$SCREENSHOTS" ;;
        "view") xdg-open $TARGET ;;
        "edit") ${swappy} -f $TARGET ;;
        *) ;;
    esac
  ''