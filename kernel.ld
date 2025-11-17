/* Linker script para QEMU x86_64 */

ENTRY(_start)

SECTIONS {
    . = 0x100000;
    
    .text ALIGN(0x1000) : {
        *(.text.boot)
        *(.text*)
        *(.rodata*)
    }
    
    .data ALIGN(0x1000) : {
        *(.data*)
        *(.bss*)
    }
    
    /DISCARD/ : {
        *(.note.GNU-stack)
        *(.gnu_debuglink)
        *(.gnu.lto_*)
    }
}
