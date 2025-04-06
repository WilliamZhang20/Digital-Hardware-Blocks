#include "Vadder.h" // Include the generated header
#include "verilated.h"
#include <iostream>

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    Vadder *top = new Vadder;

    top->a = 5;
    top->b = 10;
    top->eval(); // Evaluate the design

    std::cout << "a: " << static_cast<int>(top->a) << std::endl;
    std::cout << "b: " << static_cast<int>(top->b) << std::endl;
    std::cout << "sum: " << static_cast<int>(top->sum) << std::endl;

    top->a = 20;
    top->b = 30;
    top->eval();

    std::cout << "a: " << static_cast<int>(top->a) << std::endl;
    std::cout << "b: " << static_cast<int>(top->b) << std::endl;
    std::cout << "sum: " << static_cast<int>(top->sum) << std::endl;

    top->final();
    delete top;
    return 0;
}