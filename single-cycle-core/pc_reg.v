`include "riscv_define.v"

module pc_reg(
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
endmodule
