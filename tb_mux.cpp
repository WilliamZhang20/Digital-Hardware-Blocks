#include "Vmux.h"         // Include the Verilated model
#include "verilated.h"         // Include Verilator library
#include <iostream>
// test run successfully...

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);

    Vmux *dut = new Vmux; // Instantiate DUT (Device Under Test)

    // Test all combinations of (a, b, sel)
    for (int a = 0; a <= 1; ++a) {
        for (int b = 0; b <= 1; ++b) {
            for (int sel = 0; sel <= 1; ++sel) {
                dut->a = a;
                dut->b = b;
                dut->sel = sel;

                dut->eval(); // Evaluate the model

                int expected = sel ? b : a;
                if (dut->out != expected) {
                    std::cout << "Test failed: a=" << a 
                              << ", b=" << b 
                              << ", sel=" << sel 
                              << " => out=" << dut->out 
                              << " (expected " << expected << ")\n";
                    return 1; // Fail if any mismatch
                }
            }
        }
    }

    std::cout << "All tests passed!\n";

    delete dut;
    return 0;
}
