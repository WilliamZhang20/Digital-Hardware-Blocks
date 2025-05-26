module eq_n
#( 
    parameter N =4
)
(
input logic [N -1:0] a , b ,
output logic eq
);
    logic [N -1:0] tmp ;

    // Number of modules instantiated dependent on the parameter
    generate
        // variable within generate clause = genvar
        genvar i;
        for ( i = 0; i < N ; i = i + 1)
            xnor gen_u ( tmp [ i ] , a [ i ] , b [ i ]) ; // Tells if equal
    endgenerate

    // And-parallel reduction assignment
    // Ands all bits of tmp to get the output
    // So, only if all bits equal, then both a and b are equal
    assign eq = & tmp ;
endmodule
