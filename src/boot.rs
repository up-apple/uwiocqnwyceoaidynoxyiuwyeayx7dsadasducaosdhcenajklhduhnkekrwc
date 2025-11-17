//! Bootloader para bare-metal

/// Punto de entrada del kernel para QEMU
#[no_mangle]
pub extern "C" fn _start() -> ! {
    unsafe {
        kernel_main()
    }
}

extern "C" {
    fn kernel_main() -> !;
}


