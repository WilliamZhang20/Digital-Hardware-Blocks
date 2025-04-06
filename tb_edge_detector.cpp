#include "Vedge_detector.h"
#include "verilated.h"
#include <iostream>

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    // device under test
    Vedge_detector* dut = new Vedge_detector;

    // initial state of module
    dut->clk = 0;
    dut->reset = 1;
    dut->data_in = 0;
    dut->eval();

    dut->reset = 0;
    // lambda to click a clock
    auto tick = [&](int cycles = 1) {
        for(int i=0; i<cycles; i++) {
            dut->clk = 0; dut->eval();
            dut->clk = 1; dut->eval();
        }
    };

    // No rising edge on data
    tick();
    std::cout << "rising_edge = " << (int)dut->rising_edge << ", falling_edge = " << (int)dut->falling_edge << "\n";
    
    dut->data_in = 1;
    tick(); // trigger change in output @ clock
    std::cout << "rising_edge = " << (int)dut->rising_edge << ", falling_edge = " << (int)dut->falling_edge << "\n";

    tick();
    // should hold
    std::cout << "rising_edge = " << (int)dut->rising_edge << ", falling_edge = " << (int)dut->falling_edge << "\n";

    dut->data_in = 0; // falling edge of data
    tick();
    std::cout << "rising_edge = " << (int)dut->rising_edge << ", falling_edge = " << (int)dut->falling_edge << "\n";

    delete dut;
    return 0;
}