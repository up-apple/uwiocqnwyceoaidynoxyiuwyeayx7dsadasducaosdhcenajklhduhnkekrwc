# QUICKSTART - ZeroOS Microkernel

## ⚡ 30 segundos para probar el microkernel

### 1️⃣ Compilar y Verificar
```bash
cd /Users/joel/os/zeroOS
./build.sh
```

✅ **Resultado esperado**: El kernel se compila y se ejecuta, mostrando:
- Inicialización del núcleo seguro
- Subsistema criptográfico listo
- Proceso mínimo compartimentado
- Estado OPERATIONAL

### 2️⃣ Ejecutar en QEMU (Opcional)
Si tienes QEMU instalado:
```bash
brew install qemu    # Si no lo tienes
./qemu-run.sh
```

## 📚 Documentación

| Documento | Contenido |
|-----------|----------|
| `README.md` | Visión general y características |
| `docs/ARCHITECTURE.md` | Diseño técnico del sistema |
| `docs/SECURITY_MODEL.md` | Modelo de seguridad detallado |

## 🏗️ Estructura del Código

```
src/
├── main.rs              ← Punto de entrada
├── kernel/              ← Núcleo del sistema
│   ├── memory.rs        (Gestión de memoria)
│   ├── scheduler.rs     (Planificador)
│   └── isolation.rs     (Aislamiento)
├── crypto/              ← Criptografía
│   └── pqcrypto.rs      (Post-cuántica)
└── process/             ← Gestión de procesos
    └── mod.rs
```

## 🔧 Comandos Útiles

```bash
# Compilar solamente
cargo build --release

# Compilar para x86_64 Linux
cargo build --release --target x86_64-unknown-linux-gnu

# Ver warnings y sugerencias
cargo clippy --release

# Ejecutar tests
cargo test --release

# Build verbose (ver detalles)
cargo build --release --verbose
```

## 🔒 Seguridad: Características Clave

✅ **Memory Safety**: Rust sin unsafe innecesario  
✅ **Compartimentación**: Cada proceso aislado  
✅ **Post-Quantum**: Preparado para CRYSTALS  
✅ **Auditoría**: Logging criptográfico  
✅ **Encriptación**: Integral y por defecto  

## 🐛 Verificación de Funcionamiento

El script `build.sh` verifica automáticamente:

1. ✓ Compilación exitosa
2. ✓ Kernel ejecutable
3. ✓ Inicialización de módulos
4. ✓ Estado OPERATIONAL

```bash
$ ./build.sh

[1/3] Compilando... ✓
[2/3] Ejecutando...

╔══════════════════════════════════════════════════════╗
║      ZeroOS Microkernel (Hypersecurity Focused)      ║
║   Bare-metal kernel with quantum-safe cryptography   ║
╚══════════════════════════════════════════════════════╝

[KERNEL INITIALIZATION]
├─ Initializing secure kernel... ✓
├─ Initializing crypto subsystem... ✓
├─ Spawning minimal process... ✓
└─ Kernel ready

Status: OPERATIONAL ✓

[3/3] Verificaciones finales... ✓
```

## 🚀 Próximos Pasos

1. **Leer documentación**: Ver `docs/ARCHITECTURE.md`
2. **Explorar código**: Empezar por `src/main.rs`
3. **Entender seguridad**: Leer `docs/SECURITY_MODEL.md`
4. **Contribuir**: Implementar más módulos seguridad

## 📞 Troubleshooting

### ❌ "command not found: cargo"
Instala Rust: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

### ❌ "qemu-system-aarch64: command not found"
Instala QEMU: `brew install qemu`

### ❌ "target not found: x86_64-unknown-linux-gnu"
Instala target: `rustup target add x86_64-unknown-linux-gnu`

---

**Versión**: 0.1.0  
**Estado**: ✅ Funcional  
**Última actualización**: 17-11-2025
