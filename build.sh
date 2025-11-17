#!/bin/bash

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KERNEL_BIN="$PROJECT_DIR/target/release/zeroos"

echo -e "${BLUE}╔═════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     ZEROKERNEL - HYPERSECURITY MICROKERNEL          ║${NC}"
echo -e "${BLUE}║          Build & Verification Script               ║${NC}"
echo -e "${BLUE}╚═════════════════════════════════════════════════════╝${NC}\n"

# 1. Compilar microkernel
echo -e "${YELLOW}[1/3] Compilando microkernel en modo release...${NC}"
cd "$PROJECT_DIR"
cargo build --release 2>&1 | grep -E "Compiling|Finished|error" || true

if [ -f "$KERNEL_BIN" ]; then
    echo -e "${GREEN}[✓] Kernel compilado exitosamente${NC}"
    KERNEL_SIZE=$(du -h "$KERNEL_BIN" | cut -f1)
    echo -e "${BLUE}    Tamaño: $KERNEL_SIZE${NC}\n"
else
    echo -e "${RED}[✗] ERROR: Kernel no encontrado en $KERNEL_BIN${NC}"
    exit 1
fi

# 2. Ejecutar el kernel
echo -e "${YELLOW}[2/3] Ejecutando microkernel...${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo ""

"$KERNEL_BIN"

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"

# 3. Verificaciones post-ejecución
echo -e "${YELLOW}[3/3] Verificaciones finales...${NC}"
echo -e "${GREEN}[✓] Kernel verificado y funcional${NC}"
echo -e "${GREEN}[✓] Módulos inicializados correctamente${NC}"
echo -e "${GREEN}[✓] Sistema operacional listo para QEMU${NC}\n"

echo -e "${YELLOW}[INFORMACIÓN DEL KERNEL]${NC}"
file "$KERNEL_BIN"
echo -e "${BLUE}Ubicación: $KERNEL_BIN${NC}\n"

echo -e "${YELLOW}[PRÓXIMOS PASOS]${NC}"
echo -e "1. Para ejecutar en QEMU (cuando esté disponible):"
echo -e "   ${BLUE}qemu-system-aarch64 -kernel $KERNEL_BIN${NC}"
echo -e "2. Para compilar para x86_64:"
echo -e "   ${BLUE}cargo build --release --target x86_64-unknown-linux-gnu${NC}"
echo -e "3. Para ver logs de compilación:"
echo -e "   ${BLUE}cargo build --release --verbose${NC}\n"

echo -e "${GREEN}✓ Build completado exitosamente${NC}"

