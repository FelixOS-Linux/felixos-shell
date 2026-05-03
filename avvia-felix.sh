#!/bin/bash

# Ottieni il percorso assoluto della cartella corrente
ROOT_DIR=$(pwd)
INSTALL_DIR="$ROOT_DIR/install"

echo "🚀 Avvio di FelixOS Shell..."
echo "📂 Directory: $INSTALL_DIR"

# 1. Imposta i percorsi per le librerie e i file JS compilati
export LD_LIBRARY_PATH="$INSTALL_DIR/lib:$INSTALL_DIR/lib/gnome-shell"
export GI_TYPELIB_PATH="$INSTALL_DIR/lib:$INSTALL_DIR/lib/gnome-shell"
export GNOME_SHELL_JS="$INSTALL_DIR/share/gnome-shell/js"
export XDG_DATA_DIRS="$INSTALL_DIR/share:/usr/share"

# 2. Trucchi per farlo girare in una finestra dentro KDE (Backend X11)
export MUTTER_BACKEND=x11
export MUTTER_DEBUG_DUMMY_MODE_SPECS=1280x720

# 3. Pulisci le variabili di sessione che causano l'errore EBUSY
# Usiamo dbus-run-session per creare un bus isolato
echo "🛠️  Tentativo di avvio isolato..."

dbus-run-session -- env -u SESSION_MANAGER -u DBUS_SESSION_BUS_ADDRESS \
    "$INSTALL_DIR/bin/gnome-shell" \
    --wayland \
    --display-server \
    --unsafe-mode \
    --virtual-monitor 1280x720
