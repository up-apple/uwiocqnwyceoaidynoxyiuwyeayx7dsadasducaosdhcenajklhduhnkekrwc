# ZeroOS - Microkernel Ultra-Seguro

> **Microkernel Rust enfocado en hiperseguridad, compartimentación extrema y criptografía post-cuántica**

## 🎯 Visión

Crear un microkernel minimalista que sirva como base ultra-segura para sistemas operativos.

## 📋 Características

### ✅ Implementado
- Estructura modular compilable
- Kernel skeleton funcional
- Scripts de build y verificación
- Subsistema de criptografía preparado
- Gestión de procesos minimalista

### 🔄 En Desarrollo
- Encriptación de IPC
- Compartimentación extrema
- Validación de syscalls
- Post-quantum crypto

## 🚀 Inicio Rápido

### Compilar y Verificar
```bash
./build.sh
```

### Ejecutar en QEMU
```bash
./qemu-run.sh
```

## 📁 Estructura
```
zeroOS/
├── src/kernel/     # Núcleo seguro
├── src/crypto/     # Criptografía post-cuántica
├── src/process/    # Gestión de procesos
├── docs/          # Documentación técnica
├── build.sh       # Script de compilación
└── qemu-run.sh    # Script para QEMU
```

## 🔒 Seguridad

**Principios**:
- Menor privilegio
- Defensa en profundidad
- Encriptación integral
- Post-quantum ready

Ver [docs/SECURITY_MODEL.md](docs/SECURITY_MODEL.md) para detalles.

## 📚 Documentación

- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) - Arquitectura
- [docs/SECURITY_MODEL.md](docs/SECURITY_MODEL.md) - Modelo de seguridad

---

**Estado**: 🟡 Prototipo Inicial | **Versión**: 0.1.0