module top_module(
    input clk, reset, wr_1, rd_1, wr_2, rd_2, wr_out, rd_out, go,
    input [15:0] in_1, in_2,
    output valid, full_1, full_2, full_out, empty_1, empty_2, empty_out,
    output [15:0] result );
    
    wire [15:0] in1, in2, out1;
    
    FIFO in1_f1 (.clk(clk), .reset(reset), .rd(rd_1), .wr(wr_1), .data_in(in_1), .data_out(in1), 
    .full(full_1), .empty(empty_1));
    
    FIFO in2_f2 (.clk(clk), .reset(reset), .rd(rd_2), .wr(wr_2), .data_in(in_2), .data_out(in2), 
        .full(full_2), .empty(empty_2));
    
    gcd g1 (.clk(clk), .reset(reset), .in1(in1), .in2(in2), .start(go), .gcd(out1), 
        .done(valid));
    
    FIFO out_f3 (.clk(clk), .reset(reset),  .rd(rd_out), .wr(wr_out), .data_in(out1), .data_out(result), 
                .full(full_out), .empty(empty_out));              

endmodule
