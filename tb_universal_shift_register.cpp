#include "Vuniversal_shift_register.h"
#include "verilated.h"
#include <iostream>
// Successful testing completed...
#define CLOCK_PERIOD 10

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);

    // Device under test => universal shift register
    Vuniversal_shift_register* dut = new Vuniversal_shift_register;

    vluint64_t sim_time = 0;

    // Reset clock
    dut->rst = 1;
    dut->clk = 0;
    dut->eval();
    sim_time += CLOCK_PERIOD / 2;

    dut->clk = 1; // posedge
    dut->eval();
    sim_time += CLOCK_PERIOD / 2;

    dut->rst = 0;

    // Load input signals
    dut->load_en = 1;
    dut->load_data = 0xA5; // 0b10100101
    dut->shift_en = 0;
    dut->left_en = 0;
    dut->right_en = 0;
    dut->left_in = 0;
    dut->right_in = 0;

    for(int i=0; i<2; i++) {
        dut->clk = !dut->clk;
        dut->eval();
        sim_time += CLOCK_PERIOD / 2;
    }

    dut->load_en = 0; // stop loading
    
    dut->shift_en = 1;
    dut->left_en = 0;
    dut->right_en = 1;
    dut->right_in = 1;

    for (int i = 0; i < 10; i++) {
        dut->clk = 0;
        dut->eval();
        sim_time += CLOCK_PERIOD / 2;

        dut->clk = 1;
        dut->eval();
        sim_time += CLOCK_PERIOD / 2;

        std::cout << "Time: " << sim_time
                  << " q=" << std::hex << static_cast<int>(dut->q)
                  << " left_out=" << static_cast<int>(dut->left_out)
                  << " right_out=" << static_cast<int>(dut->right_out)
                  << std::endl;
    }

    delete dut;
    return 0;
}