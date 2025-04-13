//Given a module that consumes a data bus, its job is to output the position of bit(s) that has value 1’b1. 
//It should be bubble free, and the vld_o shall be de-asserted when job is done.

//input: 0101   valid 1
//ouput: 20     valid 11
module one_addr_detect#(parameter N = 4)(
input                       clk,
input                       rst_n,
input       [N-1:0]         data,
input                       vld_i,
output  reg [$clog2(N)-1:0] addr,
output  reg                 vld_o
);

localparam WIDTH = $clog2(N);

reg [WIDTH-1:0]     cnt;

integer i;

//starting from MSB to LSB, use cnt to represent the location that has been detected
//only output one's address
//number of one = number of clk when vld_o is high
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        addr    <= 0;
        vld_o   <= 0;
        cnt     <= N - 1;
    end
    else if(vld_i || cnt < N - 1)begin
            addr    <= ONE_ADDR(data, cnt);
            cnt     <= ONE_ADDR(data, cnt) ? ONE_ADDR(data, cnt) - 1 : N - 1;
            vld_o   <= data[ONE_ADDR(data, cnt)];
    end
    else begin
        addr    <= addr;
        cnt     <= N - 1;
        vld_o   <= 0;
    end
end

//function to find next one's address
function [WIDTH-1:0]    ONE_ADDR;
    input   [N-1:0]         data;
    input   [WIDTH-1:0]     cnt;
    reg                     vld;
    integer                 i;
    begin
        ONE_ADDR = 0;
        vld = 0;
        for (i = cnt; i <= cnt; i = i - 1) begin
            if(data[i] && !vld)begin
                ONE_ADDR = i;
                vld = 1;
            end
            else begin
                ONE_ADDR = ONE_ADDR;
                vld = vld;
            end
        end
    end
endfunction

endmodule