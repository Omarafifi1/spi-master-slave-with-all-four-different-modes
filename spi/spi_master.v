module master #(parameter data_width=8)(
    input [data_width-1:0]m_din,
    input miso,CPHA,CPOL,rst_n,clk,
    input done_tick,
    output  mosi,
    output reg slave_select,
    output reg s_clk
    
);

reg [data_width-1:0]data_reg1,data_reg2;
reg mosi_1,mosi_2;
wire s_clk_idle_state;



assign s_clk_idle_state=(!CPOL)?0:1;
assign mosi=(CPOL ~^ CPHA)?mosi_1:mosi_2;

//-----------------------------------------------------
always @(posedge clk , negedge rst_n) begin
    if(!rst_n)begin
        s_clk <=s_clk_idle_state;
        slave_select<=1;
    end
    else if(done_tick) begin
        s_clk <=s_clk_idle_state;
        slave_select<=1;
    end
    else begin
        s_clk <=~s_clk;
        slave_select<=0;
    end
end

//-----------------------------------------------------
always @(negedge s_clk ,negedge rst_n) begin
    if(!rst_n) begin
        data_reg1<=m_din; 
        mosi_2<=data_reg2[0];  
    end 
    else begin
        case ({CPOL,CPHA})  
        1,2: 
            mosi_2<=data_reg2[0];                      
        0,3:
            begin
            if(!done_tick)  
            data_reg1<={miso,data_reg1[data_width-1:1]}; 
            end
        endcase
    end
end
//-----------------------------------------------------
always @(posedge s_clk ,negedge rst_n) begin   
    if(!rst_n)begin
        data_reg2<=m_din;
        mosi_1<=data_reg1[0];   
    end
    else begin 
       case ({CPOL,CPHA})  ///// sampling
        0,3: 
            mosi_1<=data_reg1[0];                      
        1,2:begin
            if(!done_tick) 

            data_reg2<={miso,data_reg2[data_width-1:1]}; 
            end
        endcase
    end
end


endmodule
