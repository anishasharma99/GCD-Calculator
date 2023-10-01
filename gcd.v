module gcd (clk, reset, start, in1, in2, gcd, done);
    input clk, reset, start;
    input [15:0] in1, in2;
    output reg [15:0] gcd;
    output reg done;
    
    reg [15:0] inA, inB, swap;
    parameter loadInput = 4'b0000, swapAB = 4'b0010, 
              loopContinue = 4'b0100, loopEnd = 4'b1000;
    reg [3:0] pres_state, next_state;
    
    always @ (posedge clk) 
        begin
            if(reset) begin 
                pres_state <= loadInput; 
                end
            else begin 
                pres_state <= next_state; 
                end
        end
        
    always @ (*) 
        begin
            case (pres_state)
                loadInput : begin 
                    if(start) begin 
                        inA = in1; 
                        inB = in2; 
                        next_state = swapAB; 
                        end
                    else begin 
                        next_state = loadInput; 
                        end   
                    end 
                swapAB : begin 
                    if(inA>inB) begin 
                        inA = inA-inB; 
                        next_state = loopContinue; 
                        end  
                    else if (inB>inA) begin 
                        swap=inA; 
                        inA=inB; 
                        inB=swap; 
                        next_state = loopContinue; 
                        end
                    else begin 
                        next_state = loopEnd; 
                        end
                    end
                loopContinue : begin 
                    next_state = swapAB; 
                    end
                loopEnd : begin 
                    next_state = loadInput; 
                    end
                default : 
                    next_state = loadInput;
            endcase
        end
        
    always @ (posedge clk)
        begin
            case (pres_state) 
                loadInput : begin 
                    done=0; 
                    end
                swapAB : begin 
                    done=0; 
                    end
                loopEnd : begin 
                    done=1; 
                    gcd = inA; 
                    end
            endcase
        end
endmodule