`include "riscv_define.v"
module alu_mux(
    input   [`CPU_WIDTH-1:0]        reg_data,
    input   [`CPU_WIDTH-1:0]        imm_gen,
    input                           alus_rc,

    output  [`CPU_WIDTH-1:0]        alu_i
);
assign alu_i = alus_rc ? imm_gen : reg_data;
endmodule

