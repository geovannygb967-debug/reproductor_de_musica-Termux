#!/data/data/com.termux/files/usr/bin/bash
trap '' SIGINT SIGTERM
if ! grep -q "alias music=" ~/.bashrc 2>/dev/null; then
    echo "alias music='bash music.sh'" >> ~/.bashrc
    echo "Este script se a guardado reinicia Termux y Pon music para ejecutarlo"
fi
if ! command -v figlet >/dev/null 2>&1 || ! command -v play-audio >/dev/null 2>&1; then
    pkg install figlet play-audio -y
fi

ROJO_FUERTE='\033[1;31m'
VERDE_FUERTE='\033[1;32m'
AZUL_REY='\033[1;34m'
MORADO_FUERTE='\033[1;35m'
AMARILLO_FUERTE='\033[1;33m'
NARANJA_FUERTE='\033[38;5;208m'

ROJO_OSCURO='\033[0;31m'
VERDE_OSCURO='\033[0;32m'
AZUL_OSCURO='\033[0;34m'
MORADO_OSCURO='\033[0;35m'
AMARILLO_OSCURO='\033[0;33m'
NARANJA_OSCURO='\033[38;5;202m'

RESET='\033[0m'
ROJO='\033[1;31m'

MUSIC_DIR="/storage/emulated/0/Music"
[ ! -d "$MUSIC_DIR" ] && termux-setup-storage

TEMA_FIGLET=$AZUL_REY
TEMA_NOMBRES=$VERDE_FUERTE
TEMA_NUMEROS=$ROJO
TEMA_PROMPT=$NARANJA_OSCURO

mostrar_menu() {
    clear
    echo -e "${TEMA_FIGLET}"
    figlet -f standard "Music"
    echo -e "${RESET}"
    
    mapfile -t canciones < <(find "$MUSIC_DIR" -type f \( \
    -iname "*.mp3" -o -iname "*.mp4" -o -iname "*.m4a" -o -iname "*.m4b" -o -iname "*.m4p" -o \
    -iname "*.wav" -o -iname "*.wave" -o -iname "*.flac" -o -iname "*.ogg" -o -iname "*.oga" -o \
    -iname "*.opus" -o -iname "*.obb" -o -iname "*.aac" -o -iname "*.aiff" -o -iname "*.aif" -o \
    -iname "*.aifc" -o -iname "*.wma" -o -iname "*.wv" -o -iname "*.ape" -o -iname "*.ac3" -o \
    -iname "*.dts" -o -iname "*.tta" -o -iname "*.mka" -o -iname "*.mpc" -o -iname "*.ra" -o \
    -iname "*.rm" -o -iname "*.au" -o -iname "*.snd" -o -iname "*.voc" -o -iname "*.amr" -o \
    -iname "*.awb" -o -iname "*.caf" -o -iname "*.3gp" -o -iname "*.3g2" -o -iname "*.mid" -o \
    -iname "*.midi" -o -iname "*.kar" -o -iname "*.mod" -o -iname "*.s3m" -o -iname "*.xm" -o \
    -iname "*.it" -o -iname "*.spx" -o -iname "*.dss" -o -iname "*.dvf" -o -iname "*.msv" -o \
    -iname "*.oga" -o -iname "*.tak" -o -iname "*.dsf" -o -iname "*.dff" -o -iname "*.m4r" \
    \) 2>/dev/null)
    
    total=${#canciones[@]}
    echo -e "${TEMA_FIGLET}                                         [$total]${RESET}\n"
    
    if [ $total -eq 0 ]; then
        echo -e "${ROJO}No hay canciones en $MUSIC_DIR${RESET}"
        exit 1
    fi
    
    printf "${TEMA_NUMEROS}%6s${RESET} - ${TEMA_NOMBRES}%s${RESET}\n" "0" "exit"
    for i in "${!canciones[@]}"; do
        nombre=$(basename "${canciones[$i]}")
        printf "${TEMA_NUMEROS}%6d${RESET} - ${TEMA_NOMBRES}%s${RESET}\n" $((i+1)) "$nombre"
    done
    echo ""
}

menu_themes() {
    clear
    echo -e "${MORADO_FUERTE}"
    figlet -f standard "Theme"
    echo -e "${RESET}"
    echo ""
    echo -e "${ROJO_FUERTE}1  - Rojo fuerte${RESET}"
    echo -e "${VERDE_FUERTE}2  - Verde fuerte${RESET}"
    echo -e "${AZUL_REY}3  - Azul rey${RESET}"
    echo -e "${MORADO_FUERTE}4  - Morado fuerte${RESET}"
    echo -e "${AMARILLO_FUERTE}5  - Amarillo fuerte${RESET}"
    echo -e "${NARANJA_FUERTE}6  - Naranja fuerte${RESET}"
    echo -e "${ROJO_OSCURO}7  - Rojo oscuro${RESET}"
    echo -e "${VERDE_OSCURO}8  - Verde oscuro${RESET}"
    echo -e "${AZUL_OSCURO}9  - Azul oscuro${RESET}"
    echo -e "${MORADO_OSCURO}10 - Morado oscuro${RESET}"
    echo -e "${AMARILLO_OSCURO}11 - Amarillo oscuro${RESET}"
    echo -e "${NARANJA_OSCURO}12 - Naranja oscuro${RESET}"
    echo ""
    echo -ne "${VERDE_FUERTE}thema: ${RESET}"
    read tema_opcion
    
    case $tema_opcion in
        1) TEMA_FIGLET=$ROJO_FUERTE; TEMA_NOMBRES=$ROJO_FUERTE ;;
        2) TEMA_FIGLET=$VERDE_FUERTE; TEMA_NOMBRES=$VERDE_FUERTE ;;
        3) TEMA_FIGLET=$AZUL_REY; TEMA_NOMBRES=$AZUL_REY ;;
        4) TEMA_FIGLET=$MORADO_FUERTE; TEMA_NOMBRES=$MORADO_FUERTE ;;
        5) TEMA_FIGLET=$AMARILLO_FUERTE; TEMA_NOMBRES=$AMARILLO_FUERTE ;;
        6) TEMA_FIGLET=$NARANJA_FUERTE; TEMA_NOMBRES=$NARANJA_FUERTE ;;
        7) TEMA_FIGLET=$ROJO_OSCURO; TEMA_NOMBRES=$ROJO_OSCURO ;;
        8) TEMA_FIGLET=$VERDE_OSCURO; TEMA_NOMBRES=$VERDE_OSCURO ;;
        9) TEMA_FIGLET=$AZUL_OSCURO; TEMA_NOMBRES=$AZUL_OSCURO ;;
        10) TEMA_FIGLET=$MORADO_OSCURO; TEMA_NOMBRES=$MORADO_OSCURO ;;
        11) TEMA_FIGLET=$AMARILLO_OSCURO; TEMA_NOMBRES=$AMARILLO_OSCURO ;;
        12) TEMA_FIGLET=$NARANJA_OSCURO; TEMA_NOMBRES=$NARANJA_OSCURO ;;
        *) TEMA_FIGLET=$AZUL_REY; TEMA_NOMBRES=$VERDE_FUERTE ;;
    esac
}

while true; do
    mostrar_menu
    echo -ne "${TEMA_PROMPT}opción: ${RESET}"
    read opcion
    
    if [[ "$opcion" == "0" ]]; then
        clear
        exit 0
    fi
    
    if [[ "$opcion" == "theme" ]]; then
        menu_themes
        continue
    fi
    
    if ! [[ "$opcion" =~ ^[0-9]+$ ]] || [ "$opcion" -lt 1 ] || [ "$opcion" -gt "$total" ]; then
        echo -e "${ROJO}Opción inválida${RESET}"
        sleep 1
        continue
    fi
    
    archivo="${canciones[$((opcion-1))]}"
    clear
    echo -e "${TEMA_FIGLET}"
    figlet -f small "Reproduciendo"
    echo -e "${RESET}"
    echo -e "${TEMA_NOMBRES}Ahora: $(basename "$archivo")${RESET}\n"
    play-audio "$archivo"
done