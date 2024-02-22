module counter #(parameter data_width=8,counter_width=4)(
    input s_clk,rst_n,
    input CPHA,CPOL,
    output done_tick
    
);
reg [counter_width-1:0]counter;
wire counter_s_clk;


assign done_tick=(counter==data_width)?1:0;
assign counter_s_clk=(CPHA ^ CPOL) ? s_clk : !s_clk;

always @(posedge counter_s_clk,negedge rst_n ) begin
    if(!rst_n)
    counter<=0;
    else if(!done_tick)
    counter<=counter+1'b1;
end

endmodule