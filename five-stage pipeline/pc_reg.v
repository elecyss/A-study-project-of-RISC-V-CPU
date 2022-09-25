`include "./riscv_define.v"
//multi-cycle design
module pc_reg(
    input                           clk,
    input                           rstn,
    input                           jump_flag,
    input       [`CPU_WIDTH:0]      jump_addr,
    input                           hold_flag,

    output      [`CPU_WIDTH:0]      pc_o
);

reg     [`CPU_WIDTH:0]      pc_reg;

always@(posedge clk or rstn)
begin
    if(!rstn)
        pc_reg <= 0; //CPU RESET ADDR
    else if(jump_flag)
        pc_reg <= jump_addr;
    else if(hold_flag)
        pc_reg <= pc_reg;
    else
        pc_reg <= pc_reg + 3'h4;
end

assign pc_o = pc_reg;

endmodule


//single cycle design
/*module pc_reg(
    input                           clk,
    input                           rstn,
    input        [`CPU_WIDTH-1:0]   pc_nxt,

    output  reg  [`CPU_WIDTH-1:0]   pc_o
);

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        pc_o <= 0;
    else
        pc_o <= pc_nxt;
end
endmodule*/
