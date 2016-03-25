
# === {{CMD}} ...
install-valgrind () {
  local TMP="$THIS_DIR/tmp"
  mkdir -p "$TMP"

  local PREFIX="$THIS_DIR/progs"
  mkdir -p "$PREFIX"

  cd "$TMP"

  local URL="http://valgrind.org$(wget --quiet -O-  http://valgrind.org/downloads/current.html | grep tar.bz2 | head -n 1 | grep -Po "\"\K(.+?)(?=\">val.+)")"
  local FILE="$(basename "$URL")"
  local BASE="$(basename "$FILE" .tar.bz2)"

  if [[ ! -s "$FILE" ]] || ! md5sum "$FILE"; then
    rm -f "$FILE"
    # 1) Download it (use wget if you don't have curl)
    curl -O http://valgrind.org/downloads/$FILE
  fi

  md5sum "$FILE"

  if [[ ! -d "$BASE" ]]; then
    tar -xjvf "$FILE"
    cd $BASE
    ./configure --prefix="$PREFIX"
    make
    make install
    bash_setup GREEN "=== {{Installed}} to: $PREFIX"
    return 0
  fi

  bash_setup BOLD "=== {{Already installed}} to: $PREFIX"

} # === end function


