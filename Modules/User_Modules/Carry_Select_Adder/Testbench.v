`include "Fast_Low_Power_Carry_Select_Adder.v"

module Testbench;

    reg [15:0] A;
    reg [15:0] B;
    reg Cin;
    wire [15:0] Sum;
    wire Cout;

    Fast_Low_Power_Carry_Select_Adder #(.LEN(16)) uut 
    (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        $dumpfile("CSA.vcd");
        $dumpvars(0, Testbench);

        // Test case 1
        A = 16'b1010101010101010;
        B = 16'b0101010101010101;
        Cin = 0;
        #10;
        $display("Test case 1:");
        $display("A = %d", A);
        $display("B = %d", B);
        $display("Cin = %d", Cin);
        $display("Sum = %d", Sum);
        $display("Cout = %d", Cout);
        #10;

        // Test case 2
        A = 16'b1010101010101010;
        B = 16'b0101010101010101;
        Cin = 1;
        #10;
        $display("Test case 1:");
        $display("A = %d", A);
        $display("B = %d", B);
        $display("Cin = %d", Cin);
        $display("Sum = %b", Sum);
        $display("Cout = %d", Cout);
        #10;
        $finish;

    end

endmodule