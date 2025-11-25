module A (input x, input y, output z);
    assign z = (x^y) & x;
endmodule    
    
module B (input x, input y, output z);
    assign z = ~(x^y); 
endmodule

module top_module (input x, input y, output z);

    wire	z3,z2,z1,z0,z_01,z_23;
    
    A IA1(.z(z0),.x(x),.y(y));
    B IB1(.z(z1),.x(x),.y(y));
    A IA2(.z(z2),.x(x),.y(y));
    B IB2(.z(z3),.x(x),.y(y));
    
    assign z_01 = z0|z1;
    assign z_23 = z2&z3;
    assign z = z_01^z_23;
    
endmodule