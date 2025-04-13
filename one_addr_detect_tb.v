`timescale 1ns/1ns

module one_addr_detect_tb();
localparam N = 5;
localparam WIDTH = $clog2(N);
localparam FREQ = 10;

reg                 clk;
reg                 rst_n;
reg  [N-1:0]        data;
reg                 vld_i;
wire [WIDTH-1:0]    addr;
wire                vld_o;
integer             i;
always #(FREQ/2) clk <= !clk;

initial begin
    clk <= 1;
    rst_n <= 1;
    data <= 0;
    vld_i <= 0;
    @(posedge clk)
    rst_n <= 0;
    @(posedge clk)
    rst_n <= 1;
    
    //thoroughly test data from 0 to {N{1'b1}}
    for(i = 0; i < {N{1'b1}}; i = i + 1)begin
        @(posedge clk)
        data <= data + 1;
        vld_i <= 1;
        @(posedge clk)
        vld_i <= 0;

        @(negedge vld_o);
    end

    // @(posedge clk)
    // data <= 5'b11111;
    // vld_i <= 1;
    // @(posedge clk)
    // vld_i <= 0;
    // @(negedge vld_o);
    
    $finish;
end

one_addr_detect #(.N(N))
uut(
.clk(clk),
.rst_n(rst_n),
.data(data),
.vld_i(vld_i),
.addr(addr),
.vld_o(vld_o)
);


endmodule