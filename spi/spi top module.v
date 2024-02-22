module spi #(parameter data_width=8)(
input rst_n,CPHA,CPOL,clk,
input [data_width-1:0]m_din,s_din,
output done_tick
);

wire mosi,miso;
wire slave_select;
wire s_clk;

master ms(

.m_din(m_din),
.mosi(mosi),
.slave_select(slave_select),
.s_clk(s_clk),
.miso(miso),
.done_tick(done_tick),
.CPHA(CPHA),
.CPOL(CPOL),
.rst_n(rst_n),
.clk(clk)
);

slave sl(

.s_din(s_din),
.mosi(mosi),
.slave_select(slave_select),
.s_clk(s_clk),
.done_tick(done_tick),
.miso(miso),
.CPHA(CPHA),
.CPOL(CPOL),
.rst_n(rst_n)
);

counter cn(
.s_clk(s_clk),
.rst_n(rst_n),
.done_tick(done_tick),
.CPHA(CPHA),
.CPOL(CPOL)
);

endmodule
