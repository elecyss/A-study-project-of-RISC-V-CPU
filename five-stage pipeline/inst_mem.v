//----------------------------------------------------------
//Filename        :inst_mem.v
//Created         :2022-08-21
//Last Modified   :2022-08-21 15:45
//Description     :Instruction memory
//----------------------------------------------------------

`include "./riscv_define.v"
module inst_mem(
//input                           clk,
//input                           rstn,
input       [`CPU_WIDTH-1:0]    inst_addr,
output  reg [`CPU_WIDTH-1:0]    inst
);

reg     [`CPU_WIDTH-1:0]    inst_mem    [0:`INST_MEM_ADDR_DEPTH-1];
initial
begin
    $readmemh("./inst.txt", inst_mem);
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
