#!/bin/bash

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}╔═════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     ZEROKERNEL - QEMU Emulator Script              ║${NC}"
echo -e "${BLUE}╚═════════════════════════════════════════════════════╝${NC}\n"

# Verificar si QEMU está instalado
echo -e "${YELLOW}[*] Verificando QEMU...${NC}"
QEMU_CMD=""

if command -v qemu-system-aarch64 &> /dev/null; then
    echo -e "${GREEN}[✓] QEMU aarch64 disponible${NC}"
    QEMU_CMD="qemu-system-aarch64"
elif command -v qemu-system-arm &> /dev/null; then
    echo -e "${GREEN}[✓] QEMU arm disponible${NC}"
    QEMU_CMD="qemu-system-arm"
elif command -v qemu-system-x86_64 &> /dev/null; then
    echo -e "${GREEN}[✓] QEMU x86_64 disponible${NC}"
    QEMU_CMD="qemu-system-x86_64"
else
    echo -e "${RED}[✗] QEMU no encontrado${NC}"
    echo -e "${YELLOW}Instalar con: brew install qemu${NC}"
    exit 1
fi

KERNEL_BIN="$PROJECT_DIR/target/release/zeroos"

if [ ! -f "$KERNEL_BIN" ]; then
    echo -e "${YELLOW}[*] Compilando kernel...${NC}"
    cd "$PROJECT_DIR"
    cargo build --release 2>&1 || {
        echo -e "${RED}[✗] Error en compilación${NC}"
        exit 1
    }
fi

echo -e "\n${YELLOW}[*] Iniciando emulador QEMU...${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════${NC}\n"

# Para macOS: El binario Mach-O se ejecuta sin QEMU (es nativo ARM64)
# QEMU sería para emular x86 o ARM en archivos ELF
if [ "$(uname)" = "Darwin" ]; then
    echo -e "${YELLOW}[*] Ejecutando en macOS (arquitectura nativa)...${NC}"
    echo -e "${YELLOW}[*] El kernel ARM64 se ejecutará nativamente${NC}\n"
    "$KERNEL_BIN"
    STATUS=$?
else
    # En Linux, usar QEMU si está disponible
    if [ "$QEMU_CMD" = "qemu-system-aarch64" ]; then
        $QEMU_CMD \
            -machine virt \
            -cpu cortex-a57 \
            -m 256M \
            -smp 1 \
            -nographic 2>/dev/null || true
    elif [ "$QEMU_CMD" = "qemu-system-arm" ]; then
        $QEMU_CMD \
            -machine virt \
            -m 256M \
            -smp 1 \
            -nographic 2>/dev/null || true
    else
        # x86_64
        $QEMU_CMD \
            -machine pc \
            -m 256M \
            -smp 1 \
            -nographic 2>/dev/null || true
    fi
    STATUS=$?
fi

echo -e "\n${BLUE}════════════════════════════════════════════════════${NC}"
if [ $STATUS -eq 0 ]; then
    echo -e "${GREEN}[✓] Ejecución completada${NC}"
else
    echo -e "${YELLOW}[*] Ejecución finalizada (código: $STATUS)${NC}"
fi
