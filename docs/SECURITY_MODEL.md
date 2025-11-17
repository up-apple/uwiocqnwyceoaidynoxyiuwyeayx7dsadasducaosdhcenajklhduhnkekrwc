# Modelo de Seguridad - ZeroOS Microkernel

## Principios Fundamentales

### 1. Menor Privilegio (Principle of Least Privilege)
- Cada proceso obtiene **exactamente** los permisos necesarios
- Validación de capacidad en **cada syscall**
- Revocación automática al terminar el proceso
- Sin herencia de privilegios

### 2. Defensa en Profundidad
```
Capa 1: Validación de Entrada
    ↓ (Type-safe Rust)
Capa 2: Verificación de Capacidad
    ↓ (Encriptación)
Capa 3: Aislamiento de Recurso
    ↓ (Sandbox)
Capa 4: Auditoría Criptográfica
```

### 3. Encriptación Integral
- **Datos en reposo**: AES-256 (post-cuántico)
- **Datos en tránsito**: CRYSTALS-Kyber (IPC)
- **Integridad**: CRYSTALS-Dilithium (firmas)
- **Derivación de claves**: HKDF-SHA3

## Amenazas Mitigadas

### Amenaza: Buffer Overflow
**Mitigación**: 
- Memory safety de Rust (compile-time)
- Bounds checking en acceso a arreglos
- Stack guard pages
- Heap canaries

### Amenaza: Escalada de Privilegios
**Mitigación**:
- Verificación de capacidad en cada syscall
- No modelo DAC (Discretionary Access Control)
- Capabilities-based security
- Auditoría de intentos fallidos

### Amenaza: Robo de Datos
**Mitigación**:
- Encriptación por defecto
- Llaves por proceso
- Secure deletion de datos sensibles
- Encriptación de paging

### Amenaza: Corrupción de Integridad
**Mitigación**:
- Firmas criptográficas en metadatos
- Verificación de integridad periódica
- Hash de código ejecutable
- IPC auditado y firmado

### Amenaza: Ataque Cuántico
**Mitigación**:
- Algoritmos post-cuánticos NIST-estandarizados
- Cristales-Kyber para encriptación
- CRYSTALS-Dilithium para firmas
- Preparado para transición criptográfica

## Interfaces de Seguridad

### Syscall Encriptada
```rust
pub struct SecureSyscall {
    id: u32,
    nonce: [u8; 12],           // IV para AEAD
    payload: Vec<u8>,          // Datos encriptados
    hmac: [u8; 32],            // Autenticación
    signature: [u8; 4096],     // Firma post-cuántica
}
```

### Aislamiento de Proceso
```rust
pub struct ProcessCapability {
    process_id: u32,
    allowed_syscalls: BitSet,  // Whitelist de syscalls
    memory_limit: u64,         // Límite de memoria
    cpu_quota: u32,            // Quota de CPU (%)
    io_devices: Vec<DeviceId>, // Dispositivos permitidos
    key_material: [u8; 32],    // Clave criptográfica única
}
```

## Criptografía Post-Cuántica

### CRYSTALS-Kyber (Encriptación)
- **Nivel de seguridad**: 3 (equivalente a AES-192)
- **Tamaño de clave pública**: 1184 bytes
- **Tamaño de clave privada**: 2400 bytes
- **Tamaño de ciphertext**: 1568 bytes
- **Uso**: Encriptación de IPC, derivación de sesiones

### CRYSTALS-Dilithium (Firmas Digitales)
- **Nivel de seguridad**: 3
- **Tamaño de clave pública**: 1952 bytes
- **Tamaño de clave privada**: 4000 bytes
- **Tamaño de firma**: 3293 bytes
- **Uso**: Autenticación de procesos, integridad de código

### SHAKE256 (Derivación de Claves)
- **Salida variable**: configurable (256-512 bits)
- **Uso**: HKDF para derivación de claves de sesión

## Auditoría y Logging

### Evento de Auditoría
```rust
pub struct AuditEvent {
    timestamp: Timestamp,
    process_id: u32,
    syscall_id: u32,
    result: Result<u64, ErrorCode>,
    parameters: Vec<u64>,
    signature: [u8; 4096],  // Firma Dilithium
}
```

### Requisitos de Auditoría
- Todas las operaciones privilegiadas auditadas
- Logs encriptados y firmados
- Imposible modificar logs históricos
- Replicación de logs en almacenamiento seguro

## Gestión de Secretos

### Ciclo de Vida de Claves
1. **Generación**: CSPRNG (Crypto Secure RNG)
2. **Almacenamiento**: Encriptación en memoria
3. **Rotación**: Automática periódicamente
4. **Destrucción**: Overwrite seguro (DoD 5220.22-M)

### Protección de Memoria
- Claves nunca en texto plano
- Páginas de memoria locked (MLock)
- Clearing automático de memoria sensible
- Hardware-backed storage si disponible

## Evaluación de Vulnerabilidades

### Superficie de Ataque
| Componente | LOC | Criticidad | Mitigación |
|-----------|-----|-----------|------------|
| Kernel Core | ~500 | CRÍTICA | Formal verification |
| Crypto Layer | ~800 | CRÍTICA | Libreswan/liboqs |
| Scheduler | ~300 | ALTA | Fuzzing |
| Memory | ~400 | ALTA | Valgrind + ASAN |

### Herramientas de Validación
- `cargo clippy` - Análisis estático
- `cargo miri` - Interpretador simbólico
- `AddressSanitizer` - Detección de memoria
- AFL++ - Fuzzing de syscalls

## Cumplimiento Normativo

- **NIST SP 800-175B**: Post-quantum crypto
- **OWASP ASVS Level 4**: Secure coding
- **CWE Top 25**: Todas las mitigaciones
- **EAL5 Common Criteria**: Target de auditoría

## Restricciones Conocidas

1. **Hardware específico**: Comportamiento de cache
2. **Timing attacks**: Posible en PQC
3. **Side channels**: Requiere hardening adicional
4. **Quantum resistance**: Depende de problemas hard

## Roadmap de Seguridad

- [ ] Formal verification del kernel core
- [ ] Fuzzing exhaustivo de syscalls
- [ ] Auditoría de seguridad independiente
- [ ] Hardware security module (HSM) integration
- [ ] Secure boot y measured boot
- [ ] DMA attack mitigation (IOMMU)

---

**Clasificación**: PÚBLICO
**Revisión última**: 17-11-2025
**Próxima revisión**: 31-12-2025
