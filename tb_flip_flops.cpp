#include "Vflip_flop_wrapper.h"
#include "verilated.h"

// Clock period (adjust as needed)
#define CLOCK_PERIOD 10 // arbitrary units

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);

    Vflip_flop_wrapper *dut = new Vflip_flop_wrapper;

    uint64_t sim_time = 0;
    bool clk = 0;

    // Apply reset
    dut->reset = 1;
    dut->t = 0;
    dut->j = 0;
    dut->k = 0;

    while (sim_time < 200) { // Run for 200 units
        // Toggle clock
        clk = !clk;
        dut->clk = clk;

        dut->eval(); // Evaluate DUT

        // Rising edge logic
        if (clk) {
            if (sim_time == 20) {
                dut->reset = 0; // Deassert reset after some time
            }
            if (sim_time == 30) {
                dut->t = 1; // Set T high (for T flip-flop)
            }
            if (sim_time == 50) {
                dut->t = 0; // Clear T
            }
            if (sim_time == 70) {
                dut->j = 1; // Set J high (for JK flip-flop)
            }
            if (sim_time == 90) {
                dut->k = 1; // Set K high too (toggle behavior)
            }
            if (sim_time == 110) {
                dut->j = 0; // Clear J
            }
            if (sim_time == 130) {
                dut->k = 0; // Clear K
            }

            // Print state
            printf("[Time %4lld] T=%d J=%d K=%d | Q_T=%d Q_JK=%d\n",
                sim_time,
                dut->t, dut->j, dut->k,
                dut->q_t, dut->q_jk
            );
        }

        // Sim time advances half a clock each toggle
        sim_time += CLOCK_PERIOD / 2;
    }

    dut->final();
    delete dut;
    return 0;
}
