`timescale 1ns / 1ps

module top_module_tb();

reg clk, reset, wr1, rd1, wr2, rd2, wrout, rdout, GO;
reg [15:0] a,b;
wire val,full1,full2,fullOut,emp1,emp2,empOut;
wire [15:0] res;

top_module top(.clk(clk),.reset(reset),.wr_1(wr1),.rd_1(rd1),.wr_2(wr2),.rd_2(rd2),
                .wr_out(wrout),.rd_out(rdout),.go(GO),.in_1(a),.in_2(b),
                .valid(val),.full_1(full1),.full_2(full2),.full_out(fullOut),
                .empty_1(emp1),.empty_2(emp2),.empty_out(empOut),.result(res));
                
initial begin
    a = 0;
    b = 0;
    clk = 0;
    reset = 1;
    wr1 = 0;
    rd1 = 0;
    wr2 = 0;
    rd2 = 0;
    wrout = 0;
    rdout = 0;
    GO = 1;
    end
    
always
#10 clk = ~clk;

initial
begin
#3000;
$finish;
end

initial
begin
#30;
reset = 0;
wr1 = 1;
rd1 = 1;
wr2 = 1;
rd2 = 1;
wrout = 1;
rdout = 1;
a = 16'b0000000000011011;
b = 16'b0000000000001111;
end

endmodule
