`include "riscv_define.v"
module inst_mem(
//input                           clk,
//input                           rstn,
input       [`CPU_WIDTH-1:0]    inst_addr,
output  reg [`CPU_WIDTH-1:0]    inst
);

reg     [`CPU_WIDTH-1:0]    inst_mem    [0:`INST_MEM_ADDR_DEPTH-1];
initial
begin
    $readmemh("D:/RISC-V/myriscv/core/inst.txt", inst_mem);
end
//always@(posedge clk or negedge rstn)
always@(*)
begin
/*    if(!rstn)
        inst = 0;
    else*/
        inst = inst_mem[inst_addr[`INST_MEM_ADDR_WIDTH+2-1:2]];
end
endmodule
