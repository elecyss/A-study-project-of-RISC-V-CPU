`include "./riscv_define.v"
module add_shift(
    input   [`CPU_WIDTH-1:0]        pc_o,
    input   [`CPU_WIDTH-1:0]        imm_gen,

    output  [`CPU_WIDTH-1:0]        pc_shift
);

wire    [`CPU_WIDTH-1:0]        imm_shift;
assign imm_shift = imm_gen << 2;

assign pc_shift = pc_o + imm_shift;

endmodule
