module slave #(parameter data_width=8)(
    input [data_width-1:0]s_din,
    input slave_select,mosi,
    input s_clk,rst_n,
    input CPHA,CPOL,
    input done_tick,
    output miso
);


reg [data_width-1:0]data_reg1,data_reg2;
reg miso_1,miso_2;

assign miso=(CPOL ~^ CPHA)?miso_1:miso_2;

//-----------------------------------------------------
always @(negedge s_clk ,negedge rst_n) begin
    if(!rst_n)begin
        data_reg1<=s_din;
        miso_2<=data_reg2[0];
    end    
    else if(!slave_select) begin    
        case ({CPOL,CPHA})  
        1,2: 
            miso_2<=data_reg2[0];                      
        0,3:
            begin
            if(!done_tick)  
            data_reg1<={mosi,data_reg1[data_width-1:1]}; 
            end
        endcase
    end
end


//-----------------------------------------------------
always @(posedge s_clk ,negedge rst_n) begin   
    if(!rst_n)begin
        data_reg2<=s_din;
        miso_1<=data_reg1[0];   
    end
    else if(!slave_select) begin 
       case ({CPOL,CPHA})  
        0,3: 
            miso_1<=data_reg1[0];                      
        1,2:begin
            if(!done_tick)  
            data_reg2<={mosi,data_reg2[data_width-1:1]};
            end
        endcase
    end
end

endmodule
