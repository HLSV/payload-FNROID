#!/bin/bash
# payload-FNROID - Ferramenta real no Termux
# Autor: Igor (projeto para Hackers do Bem)
# Arquivo único, menu interativo

# Função para checar pacotes e instalar se faltar
check_and_install() {
    if ! command -v $1 &> /dev/null; then
        echo "[*] Instalando $1..."
        pkg install -y $1
    fi
}

# Verifica dependências básicas
check_and_install termux-api
check_and_install python
check_and_install zip

# Menu principal
while true; do
    clear
    echo "==================================="
    echo "     PAYLOAD-FNROID - MENU"
    echo "==================================="
    echo ""
    echo "Escolha o tipo de payload:"
    echo "1) Captura de áudio (microfone)"
    echo "2) Captura de tela (screenshot)"
    echo "3) Selfie com câmera frontal"
    echo "4) Payload especial (coletar info do sistema)"
    echo "0) Sair"
    echo ""
    read -p "Opção: " opcao

    case $opcao in
        1)
            echo "[*] Gravando áudio... (CTRL+C para parar)"
            termux-microphone-record -f audio_payload.wav
            echo "[+] Áudio salvo como audio_payload.wav"
            read -p "Pressione Enter para voltar ao menu..."
            ;;
        2)
            echo "[*] Capturando tela..."
            if command -v screencap >/dev/null 2>&1; then
                screencap -p screenshot_payload.png
                echo "[+] Screenshot salva como screenshot_payload.png (via screencap)"
            elif command -v termux-screenshot >/dev/null 2>&1; then
                termux-screenshot screenshot_payload.png
                echo "[+] Screenshot salva como screenshot_payload.png (via termux-screenshot)"
            else
                echo "[!] Nenhum método de captura disponível."
                echo "    - Para usar sem root, instale Termux:API:"
                echo "      pkg install termux-api"
                echo "    - Para usar com root, execute pelo shell do Android:"
                echo "      adb shell ou su, depois screencap -p /sdcard/screenshot.png"
            fi
            read -p "Pressione Enter para voltar ao menu..."
            ;;
        3)
            echo "[*] Tirando selfie..."
            termux-camera-photo -c 1 selfie_payload.jpg
            echo "[+] Selfie salva como selfie_payload.jpg"
            read -p "Pressione Enter para voltar ao menu..."
            ;;
        4)
            echo "[*] Coletando informações do sistema..."
            uname -a > info_sistema.txt
            date >> info_sistema.txt
            termux-battery-status >> info_sistema.txt
            termux-wifi-connectioninfo >> info_sistema.txt
            echo "[+] Informações salvas em info_sistema.txt"
            read -p "Pressione Enter para voltar ao menu..."
            ;;
        0)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "[!] Opção inválida!"
            read -p "Pressione Enter para voltar ao menu..."
            ;;
    esac
done
