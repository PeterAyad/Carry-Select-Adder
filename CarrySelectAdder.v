module multiplexer2x1_4 (X, I0, I1, S);
   output [3:0] X;   
   input [3:0]  I1;  
   input [3:0]  I0;  
   input S; 
   assign X = (S == 1'b0) ? I0 : I1;
endmodule

module multiplexer2x1_1 (X, I0, I1, S);
   output X;   
   input I1;  
   input I0;  
   input S; 
   assign X = (S == 1'b0) ? I0 : I1;
endmodule

module halfAdder(S,Cout,A,B);
    output S;
    output Cout;
    input A;
    input B;
    xor(S,A,B);
    and(Cout,A,B);
endmodule

module fullAdder(S, Cout, A, B, Cin);
   output S;
   output Cout;
   input  A;
   input  B;
   input  Cin;
   wire   C1;
   wire   C2;
   wire   S1;
   halfAdder h1 (S1,C1,A,B);
   halfAdder h2 (S,C2,S1,Cin);     
   or(Cout, C1, C2);
endmodule 

module rippleCarryAdder(S, C, A, B, Cin);
   output [3:0] S;
   output 	C; 
   input [3:0] 	A; 
   input [3:0] 	B; 
   input 	Cin; 
 	
   wire 	C0;
   wire 	C1;
   wire 	C2;
	
   fullAdder f0(S[0], C0, A[0], B[0], Cin);
   fullAdder f1(S[1], C1, A[1], B[1], C0);
   fullAdder f2(S[2], C2, A[2], B[2], C1);
   fullAdder f3(S[3], C, A[3], B[3], C2);  
endmodule

module carrySelectAdder(S, C, A, B,cin,innerCarry);
   output [15:0] S;  
   output 	C;  
   output [2:0] innerCarry;
   input [15:0] 	A;  
   input [15:0] 	B; 
   input cin;

   wire [11:0] 	S0; 
   wire [11:0] 	S1; 

   wire 	C1;  
   wire 	C2; 
   wire 	C4; 
   wire 	C5;
   wire 	C7; 
   wire 	C8; 
   
   rippleCarryAdder R1 (S[3:0], innerCarry[0], A[3:0], B[3:0], cin);

   rippleCarryAdder R2_1 (S0[3:0], C1, A[7:4], B[7:4], 1'b0);     
   rippleCarryAdder R2_2 (S1[3:0], C2, A[7:4], B[7:4], 1'b1);     
   multiplexer2x1_4 mux2 (S[7:4], S0[3:0], S1[3:0], innerCarry[0]);  

   multiplexer2x1_1 mc2 (innerCarry[1],C1,C2,innerCarry[0]);

   rippleCarryAdder R3_1 (S0[7:4], C4, A[11:8], B[11:8], 1'b0);     
   rippleCarryAdder R3_2 (S1[7:4], C5, A[11:8], B[11:8], 1'b1);     
   multiplexer2x1_4 mux3 (S[11:8], S0[7:4], S1[7:4], innerCarry[1]);  

   multiplexer2x1_1 mc3 (innerCarry[2],C4,C5,innerCarry[1]);

   rippleCarryAdder R4_1 (S0[11:8], C7, A[15:12], B[15:12], 1'b0);     
   rippleCarryAdder R4_2 (S1[11:8], C8, A[15:12], B[15:12], 1'b1);     
   multiplexer2x1_4 mux4 (S[15:12], S0[11:8], S1[11:8], innerCarry[2]);
   
   multiplexer2x1_1 mc4 (C,C7,C8,innerCarry[2]);

endmodule