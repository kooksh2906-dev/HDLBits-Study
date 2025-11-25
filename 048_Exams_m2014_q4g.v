module top_module (
    input in1,
    input in2,
    input in3,
    output out
);
    
    wire in12;

    assign in12 = ~(in1^in2);
    assign out = in12^in3;
 
endmodule