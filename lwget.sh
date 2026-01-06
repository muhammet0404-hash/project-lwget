URL="$1"
DATA_FOLDER="lwget_data"
COADA="$DATA_FOLDER/coada.txt"
DESCARCAT="$DATA_FOLDER/descarcat.txt"

mkdir -p "$DATA_FOLDER"
touch "$COADA" "$DESCARCAT"

if ! grep -qx "$URL" "$DESCARCAT"; then
    echo " Download HTML: $URL"

    FISIER="index1.html"
    wget -q -O "$FISIER" "$URL"

    echo "$URL" >> "$DESCARCAT"

    grep -oE 'href="([^"#]+)"' "$FISIER" \
        | cut -d'"' -f2 \
        | grep -E '^https?://' >> "$COADA"
else
    echo " Deja descărcat: $URL"
fi

sort -u "$COADA" -o "$COADA"

echo "Link-uri salvate pentru nivelul următor:"
cat "$COADA"

