
module spi_tb;
parameter data_width=8;

reg rst_n,CPHA,CPOL,clk;
reg [data_width-1:0]m_din,s_din;
wire done_tick;

spi dut(

   .CPHA(CPHA),
   .CPOL(CPOL),
   .rst_n(rst_n),
   .done_tick(done_tick),
   .m_din(m_din),
   .s_din(s_din),
   .clk(clk)
);

localparam T=10;
always
begin
  clk=0;
  #(T/2);
  clk=1;
  #(T/2);  
end
initial begin

    m_din=8'b01100110;
    s_din=8'b10101011;
    CPHA=0;
    CPOL=0;
    rst_n=0;
    #2;
    rst_n=1;
    #1000;
    CPHA=1;
    CPOL=0;
    rst_n=0;
    #2;
    rst_n=1;
    #1000;
    CPHA=0;
    CPOL=1;
    rst_n=0;
    #2;
    rst_n=1;
    #1000;
    CPHA=1;
    CPOL=1;
    rst_n=0;
    #2;
    rst_n=1;
    #1000;
    $stop;
   
    end

endmodule
