module carrySelectAdder_testBench;
reg [15:0] a;
reg [15:0] b;
reg cin;
wire [15:0] sum;
wire [2:0] inc;
wire carry;


carrySelectAdder sl (sum[15:0],carry,a[15:0],b[15:0],cin,inc[2:0]);

initial 
begin
$display("Cin         A                   B                 Sum          Final Carry     Inner Carries");
$monitor("%b \t %b \t %b \t %b \t       %b     \t      %b \t %b \t %b",cin,a,b,sum,carry,inc[2],inc[1],inc[0]);

cin=1'b0;
a = 16'b1001010110010101;
b = 16'b1001010111110101;
#10
cin=1'b1;
a = 16'b1111010110010101;
b = 16'b1000001011010101;
#10
cin=1'b0;
a = 16'b1010100001100010;
b = 16'b0011111111111111;
#10
cin=1'b0;
a = 16'b1111000000111111;
b = 16'b1111111111000000;
#10
cin=1'b1;
a = 16'b1010101011100010;
b = 16'b0001010100011101;

end
endmodule
