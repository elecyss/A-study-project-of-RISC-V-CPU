`include "riscv_define.v"
module add_4(
    input   [`CPU_WIDTH-1:0]        pc_o,

    output  [`CPU_WIDTH-1:0]        pc_add4
);
assign pc_add4 = pc_o + 4;
endmodule

