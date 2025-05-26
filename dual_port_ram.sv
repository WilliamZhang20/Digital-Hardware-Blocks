module dual_port_ram
#(
    parameter DATA_N = 32,
    parameter SIZE = 128
)
(
    input logic clk,
    input logic we0, we1,
    input logic [$clog2(SIZE)-1:0] addr0, addr1, // Call ceiling log2
    input logic [DATA_N-1:0] w0_data, w1_data,
    output logic [DATA_N-1:0] r0_data, r1_data
);

    logic [DATA_N-1:0] ram [0:SIZE-1];

    // Initialize RAM content from file
    initial begin
        $readmemb("init_file.mem", ram); // calls to read from the file!
    end

    always_ff @(posedge clk) begin
        if (we0 && !(we1 && addr0 == addr1))
            ram[addr0] <= w0_data;

        // Due to the nonblocking assignment, the r0_data will see the OLD value of ram[addr0]
        // Synchronous RAM typically outputs the stored data before the new data is written on the clock edge.
        r0_data <= ram[addr0];
    end

    always_ff @(posedge clk) begin
        if (we1)
            ram[addr1] <= w1_data;
        r1_data <= ram[addr1];
    end

endmodule