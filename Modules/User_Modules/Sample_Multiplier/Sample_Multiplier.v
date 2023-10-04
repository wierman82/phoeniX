module Sample_Multiplier 
(
    input CLK,
    input [31 : 0] input_1, 
    input [31 : 0] input_2, 
    input [7  : 0] accuracy, 
    output busy, 
    output reg [31 : 0] result
);
    reg [31 : 0] output_mul;

    always @(posedge CLK) begin
        assign result = output_mul;
        if (accuracy == 0)
        begin 
            output_mul = input_1 * input_2;
        end
        else if (accuracy == 1)
        begin 
            output_mul = (input_1 * input_2) - 1;
        end
        else if (accuracy == 2)
        begin 
            output_mul = (input_1 * input_2) - 2;
        end
        // No accuracy control logic in multiplier
        else begin 
            output_mul = input_1 * input_2;
        end
    end
    
endmodule