#include "Vbasic_gates.h"
#include "verilated.h"
#include <iostream>
// Test run successfully...

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);

    Vbasic_gates* dut = new Vbasic_gates;

    // Test all combinations of (a, b)
    for (int a = 0; a <= 1; ++a) {
        for (int b = 0; b <= 1; ++b) {
            dut->a = a;
            dut->b = b;

            dut->eval(); // Evaluate DUT

            // Expected values
            int and_exp  = a & b;
            int or_exp   = a | b;
            int nand_exp = ~(a & b) & 1;
            int nor_exp  = ~(a | b) & 1;
            int xor_exp  = a ^ b;
            int xnor_exp = ~(a ^ b) & 1;

            bool pass = (dut->and_out == and_exp) &&
                        (dut->or_out == or_exp) &&
                        (dut->nand_out == nand_exp) &&
                        (dut->nor_out == nor_exp) &&
                        (dut->xor_out == xor_exp) &&
                        (dut->xnor_out == xnor_exp);

            if (!pass) {
                std::cout << "Test failed for a=" << a << ", b=" << b << "\n";
                std::cout << "Outputs: and=" << dut->and_out
                          << " or=" << dut->or_out
                          << " nand=" << dut->nand_out
                          << " nor=" << dut->nor_out
                          << " xor=" << dut->xor_out
                          << " xnor=" << dut->xnor_out << "\n";
                return 1;
            }
        }
    }

    std::cout << "All basic gate tests passed!\n";

    delete dut;
    return 0;
}