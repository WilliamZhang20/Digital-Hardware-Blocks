// 32 x32 register file
module reg_file
#(
    parameter DATA_N = 32 ,
    parameter SIZE = 32
)
(
    input logic clk , wr_en ,
    input logic [ $clog2 ( SIZE ) -1:0] w_addr , r0_addr , r1_addr ,
    input logic [DATA_N-1:0] w_data,
    output logic [DATA_N-1:0] r0_data, r1_data
);

    // Memory storage in the module
    logic [ DATA_N -1:0] regs [0: SIZE -1];

    // Synchronous writes
    always_ff @ ( posedge clk )
        if ( wr_en )
            regs [ w_addr ] <= w_data ;

    // Asynchronous Reads in continuous assignment (write-reads are quick)
    assign r0_data = regs [ r0_addr ];
    assign r1_data = regs [ r1_addr ];

endmodule
