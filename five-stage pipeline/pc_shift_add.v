`include "./riscv_define.v"
module pc_shift_add(
    input   [`CPU_WIDTH-1:0]        imm,
    input   [`CPU_WIDTH-1:0]        pc_o,

    output  [`CPU_WIDTH-1:0]        pc_shift
);
wire [`CPU_WIDTH-1:0]   imm_shift;
assign imm_shift = imm << 1;

assign pc_shift = imm_shift + pc_o;

endmodule
