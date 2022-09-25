`include "riscv_define.v"
module data_mem(
input                           clk,
//input                           rstn,
input       [`CPU_WIDTH-1:0]    addr,
input       [`CPU_WIDTH-1:0]    wdata,
input                           write_en,
input                           read_en,

output  reg [`CPU_WIDTH-1:0]    rdata
);

reg     [`CPU_WIDTH-1:0]    data_mem    [0:`DATA_MEM_ADDR_DEPTH-1];
initial
begin
    $readmemh("D:/RISC-V/myriscv/core/data.txt", data_mem);
end
//always@(posedge clk or negedge rstn)
always@(*)
begin
    if(read_en)
        rdata = data_mem[addr[`DATA_MEM_ADDR_WIDTH+2-1:2]];
end
always@(posedge clk)
begin
    if(write_en)
        data_mem[addr[`DATA_MEM_ADDR_WIDTH+2-1:2]] = wdata;
end
endmodule

