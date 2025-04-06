#include "Vasync_reset.h"
#include "verilated.h"
#include <iostream>
#include <cassert>

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);

    Vasync_reset* dut = new Vasync_reset;

    dut->clk = 0;
    dut->reset_n = 1; // disable reset
    dut->eval();

    auto tick = [&](int cycles=1) {
        for (int i = 0; i < cycles; ++i) {
            dut->clk = 0; dut->eval();
            dut->clk = 1; dut->eval();
        }
    };
    std::cout << "Starting test...\n";
    // Part 1 - activate reset
    dut->reset_n = 0;
    dut->eval();
    std::cout << "Part 1: reset_sync = " << (int)dut->reset_sync << "\n";
    assert((int)dut->reset_sync == 1);

    // Part 2 - release reset
    dut->reset_n = 1; // Deassert reset
    dut->eval(); // eval async logic
    std::cout << "Part 2: reset_sync = " << (int)dut->reset_sync << "\n";
    assert(dut->reset_sync == 1);

    tick();
    std::cout << "Part 3: reset_sync = " << (int)dut->reset_sync << "\n";
    assert(dut->reset_sync == 1); // should still be 1

    tick(1);
    std::cout << "Part 4: reset_sync = " << (int)dut->reset_sync << "\n";
    assert(dut->reset_sync == 0); // should finally go to 0

    delete dut;
    return 0;
}