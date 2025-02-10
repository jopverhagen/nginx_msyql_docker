#!/bin/bash

CONTAINER_NAME="forge_stack"

function start() {
    echo "Containers starten..."
    docker compose up -d
}

function stop() {
    echo "Containers stoppen..."
    docker compose down
}

function prune() {
    echo "⚠️ WAARSCHUWING: Dit verwijdert ALLE containers, volumes en netwerken!"
    read -p "Weet je zeker dat je een volledige reset wilt uitvoeren? (ja/nee): " confirm
    if [[ "$confirm" == "ja" ]]; then
        echo "Alle containers en volumes stoppen en verwijderen..."
        docker compose down -v

        echo "Alle ongebruikte Docker data verwijderen..."
        docker system prune -af


        echo "Volledige reset voltooid! ✅"
    else
        echo "Prune geannuleerd."
    fi
}

function menu() {
    echo "Kies een optie:"
    echo "1) Start containers"
    echo "2) Stop containers"
    echo "3) Prune (VOLLEDIGE RESET)"
    echo "4) Exit"
    
    read -p "Maak een keuze: " choice
    case $choice in
        1) start ;;
        2) stop ;;
        3) prune ;;
        4) exit 0 ;;
        *) echo "Ongeldige keuze!"; menu ;;
    esac
}

menu
