`include "riscv_define.v"
module memtoreg(
    input   [`CPU_WIDTH-1:0]        mem_data,
    input   [`CPU_WIDTH-1:0]        alu_result,
    input                           memtoreg,

    output  [`CPU_WIDTH-1:0]        reg_wdata
);

assign reg_wdata = memtoreg ? mem_data : alu_result;

endmodule
