# Arquitectura del Microkernel ZeroOS

## Visión General

ZeroOS es un microkernel ultra-seguro escrito en Rust, diseñado para máxima seguridad mediante:
- **Compartimentación extrema** de procesos
- **Criptografía post-cuántica** integrada
- **Aislamiento de memoria** seguro
- **Superficie de ataque mínima**

## Componentes Principales

### 1. Kernel Core (`/kernel`)
El corazón del sistema, responsable de:

#### `memory.rs` - Gestión Segura de Memoria
- Aislamiento de espacios de memoria por proceso
- Protección contra buffer overflows
- Validación de límites de memoria
- Encriptación de heap seguro

#### `scheduler.rs` - Planificador de Procesos Minimalista
- Procesos con privilegios mínimos
- Preemción segura
- Context switching con validación

#### `isolation.rs` - Compartimentación Extrema
- Sandboxing de procesos
- Separación de capacidades
- Restricción de syscalls
- Aislamiento de recursos (CPU, memoria, I/O)

### 2. Subsistema Criptográfico (`/crypto`)

#### `pqcrypto.rs` - Criptografía Post-Cuántica
- Algoritmos resistentes a computadoras cuánticas
- Primitivas criptográficas para:
  - Encriptación de datos en reposo
  - Autenticación de procesos
  - Derivación de claves

### 3. Gestión de Procesos (`/process`)

#### Procesos Minimalistas
- Cada proceso ejecuta **una sola tarea**
- Comunicación IPC encriptada
- Validación de permisos en cada operación
- Límites de recursos estrictos

## Modelo de Seguridad

### Principio de Menor Privilegio
```
User Space Process
    ↓ (Syscall - Validado)
Kernel Boundary (Validación Criptográfica)
    ↓ (Capacidad Verificada)
Kernel Service (Compartimentado)
    ↓ (Operación Acotada)
Hardware (Modo Kernel - Sandbox)
```

### Defensa en Profundidad
1. **Validación de entrada** en cada límite
2. **Separación de privilege** estricta
3. **Encriptación de datos** en tránsito
4. **Integridad verificable** de código

## Compilación y Ejecución

### Compilar el Kernel
```bash
# Compilación estándar (arquitectura nativa)
cargo build --release

# Compilación para x86_64 Linux (QEMU)
cargo build --release --target x86_64-unknown-linux-gnu
```

### Ejecutar Verificación
```bash
# Script de build y verificación
./build.sh
```

### Ejecutar en QEMU
```bash
# Si QEMU está instalado
./qemu-run.sh
```

## Especificaciones de Seguridad

| Aspecto | Implementación |
|--------|----------------|
| **Lenguaje** | Rust (Memory Safety) |
| **Panic Handling** | abort (no unwind) |
| **Stack Guard** | Habilitado |
| **Control Flow Guard** | Planeado |
| **Encriptación** | Post-cuántica |
| **Aislamiento** | Procesos con UID único |
| **Auditoría** | Logs criptográficamente firmados |

## Roadmap de Implementación

### Fase 1: Base Segura (EN PROGRESO)
- [x] Estructura modular
- [x] Skeleton de kernel
- [x] Compilación bare-metal
- [ ] Implementar memory.rs completo
- [ ] Implementar scheduler.rs con preemption
- [ ] Implementar isolation.rs

### Fase 2: Criptografía Post-Cuántica
- [ ] Integrar libreswan/liboqs
- [ ] Encriptación de datos
- [ ] Autenticación de procesos
- [ ] Derivación de claves

### Fase 3: Pruebas y Verificación
- [ ] Fuzzing de syscalls
- [ ] Análisis formal de seguridad
- [ ] Verificación en QEMU/HW real
- [ ] Auditoría de seguridad

## Restricciones de Diseño

### Minimalismo Extremo
- Kernel: ~1000 LOC objetivo
- sin libc (no-std)
- Sin dependencias innecesarias
- Sin driver bloat

### Seguridad Primero
- Todas las operaciones validadas
- Encriptación default
- Comunicación IPC encriptada
- Auditoría completa

## Extensión del OS

Para construir un SO completo sobre este microkernel:

1. **System Services Layer**: Servicios críticos (filesystem, networking)
2. **Device Drivers**: Aislados en procesos separados
3. **User Applications**: Máximo aislamiento

Cada componente es un proceso separado, encriptado, auditado.

## Referencias y Estándares

- NIST Post-Quantum Cryptography Standards
- OWASP Secure Coding Practices
- CWE Top 25 Mitigations
- seL4 Microkernel Security Model

---

**Última actualización**: 17 de noviembre de 2025
**Versión**: 0.1.0
**Estado**: Prototipo Inicial
