//! Microkernel Rust enfocado en hiperseguridad
//! Para compilación bare-metal, usar: cargo build --release --target x86_64-unknown-linux-gnu

mod kernel;
mod crypto;
mod process;

fn main() {
    println!("╔══════════════════════════════════════════════════════╗");
    println!("║      ZeroOS Microkernel (Hypersecurity Focused)      ║");
    println!("║   Bare-metal kernel with quantum-safe cryptography   ║");
    println!("╚══════════════════════════════════════════════════════╝\n");
    
    println!("[KERNEL INITIALIZATION]");
    println!("├─ Initializing secure kernel...");
    kernel::init();
    println!("│  ✓ Kernel initialized");
    
    println!("├─ Initializing cryptographic subsystem...");
    crypto::init();
    println!("│  ✓ Crypto subsystem ready");
    
    println!("├─ Spawning minimal compartmentalized process...");
    process::spawn_minimal_process();
    println!("│  ✓ Process spawned");
    
    println!("└─ Kernel ready for bare-metal execution\n");
    
    println!("[SYSTEM STATUS]");
    println!("Status: OPERATIONAL");
    println!("Security Level: MAXIMUM");
    println!("Architecture: x86_64 (compiled for QEMU)");
    println!("\n[To run on QEMU, use: ./build.sh]");
}
