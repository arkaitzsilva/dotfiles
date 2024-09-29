#!/bin/sh

# Función para generar el archivo pot
generate_pot() {
    POT_FILE="po/messages.pot"
    POTFILES_FILE="po/POTFILES"

    # Crear o actualizar el archivo pot
    xgettext --language=Shell --from-code=UTF-8 --output="$POT_FILE" --files-from="$POTFILES_FILE"
    echo "Archivo POT actualizado: $POT_FILE"
}

# Función para actualizar archivos po para cada idioma en LINGUAS
update_po() {
    LINGUAS_FILE="po/LINGUAS"
    POT_FILE="po/messages.pot"

    while read -r lang; do
        PO_FILE="po/$lang.po"

        # Si el archivo po no existe, crearlo a partir del pot
        if [ ! -f "$PO_FILE" ]; then
            msginit --locale="$lang" --input="$POT_FILE" --output="$PO_FILE" --no-translator
            echo "Archivo PO generado: $PO_FILE"
        else
            # Si el archivo po existe, actualizarlo con las nuevas cadenas del pot
            msgmerge --update --backup=none "$PO_FILE" "$POT_FILE"
            echo "Archivo PO actualizado: $PO_FILE"
        fi
    done < "$LINGUAS_FILE"
}

# Función para generar archivos mo a partir de los archivos po
generate_mo() {
    LINGUAS_FILE="po/LINGUAS"

    while read -r lang; do
        PO_FILE="po/$lang.po"
        MO_DIR="po/$lang/LC_MESSAGES"
        MO_FILE="$MO_DIR/messages.mo"

        # Crear el directorio si no existe
        mkdir -p "$MO_DIR"

        if [ -f "$PO_FILE" ]; then
            msgfmt --output-file="$MO_FILE" "$PO_FILE"
            echo "Archivo MO generado: $MO_FILE"
        else
            echo "El archivo PO no existe: $PO_FILE"
        fi
    done < "$LINGUAS_FILE"
}

# Ejecutar todas las funciones en orden
main() {
    echo "Generando y actualizando archivo POT..."
    generate_pot

    echo "Actualizando archivos PO..."
    update_po

    echo "Generando archivos MO..."
    generate_mo
}

# Llamar a la función principal
main
