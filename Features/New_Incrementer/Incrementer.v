module Incrementer
#(
    parameter LEN = 32
)
(
    input   [LEN - 1 : 0]   value,
    output  [LEN - 1 : 0]   result
);
    localparam COUNT = LEN / 4;
    `define SLICE  [(i * 4) + 3 : (i * 4)]

    wire [COUNT - 1 : 0] carry_chain;
    
    Incrementer_Unit IU_1 
    (
        .value(value[3 : 0]),
        .result(result[3 : 0]),
        .Cout(carry_chain[0])
    );

    wire [3 : 0] incrementer_unit_result [1 : COUNT];
    wire [COUNT - 1 : 1] incrementer_unit_carry_out;

    genvar i;
    generate
        for (i = 1; i < COUNT; i = i + 1)
        begin

            Incrementer_Unit IU
            (
                .value(value`SLICE),
                .result(incrementer_unit_result[i]),
                .Cout(incrementer_unit_carry_out[i])
            );

            Mux_2to1 MUX
            (
                .data_in_1({1'b0, value`SLICE}),
                .data_in_2({incrementer_unit_carry_out[i], incrementer_unit_result[i]}),
                .select(carry_chain[i - 1]),
                .data_out({carry_chain[i], result`SLICE})
            );
        end
        if (COUNT * 4 < LEN)
            assign result[LEN - 1 : (COUNT * 4)] = value[LEN - 1 : (COUNT * 4)] + carry_chain[COUNT - 1]; 
    endgenerate
endmodule

module Incrementer_Unit 
(
    input  [3 : 0] value,
    output [4 : 1] result,
    output Cout
);

    assign result[1] = ~value[0];
    assign result[2] = value[1] ^ value[0];
    wire   C1   = value[1] & value[0];
    wire   C2   = value[2] & value[3];
    wire   Cout   = C1 & C2;
    wire   C3   = C1 & value[2];
    assign result[3] = value[2] ^ C1;
    assign result[4] = value[3] ^ C3;
endmodule

module Mux_2to1
#(
    parameter LEN = 5
) 
(
    input [LEN - 1 : 0] data_in_1,        
    input [LEN - 1 : 0] data_in_2,        
    input select,                   

    output reg [LEN - 1: 0] data_out            
);

    always @(*) 
    begin
        case (select)
            1'b0: begin data_out = data_in_1; end
            1'b1: begin data_out = data_in_2; end
            default: begin data_out = {LEN{1'bz}}; end
        endcase
    end
endmodule