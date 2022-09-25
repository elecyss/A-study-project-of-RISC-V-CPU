`include "./riscv_define.v"
module jump_ctrl(
    input                           branch,
    input                           zero,

    output                          jump_flag
);

assign jump_flag = branch & zero;
endmodule
