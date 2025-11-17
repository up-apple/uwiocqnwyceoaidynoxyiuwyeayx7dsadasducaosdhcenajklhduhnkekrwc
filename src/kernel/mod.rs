pub mod memory;
pub mod scheduler;
pub mod isolation;

pub fn init() {
    memory::init();
    scheduler::init();
    isolation::init();
}
