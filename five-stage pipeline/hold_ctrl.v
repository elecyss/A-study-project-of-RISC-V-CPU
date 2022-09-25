`include "./riscv_define.v"
module hold_ctrl(
    input                           mem_read,
    input   [`REG_ADDR_WIDTH-1:0]   rs1,
    input   [`REG_ADDR_WIDTH-1:0]   rs2,
    input   [`REG_ADDR_WIDTH-1:0]   rd,

    output                          hold_flag
);

wire valid;
assign valid = |rd;

wire eq_1, eq_2;
assign eq_1 = (rs1 == rd) ? 1'b1 : 1'b0;
assign eq_2 = (rs2 == rd) ? 1'b1 : 1'b0;

assign hold_flag = valid & mem_read & (eq_1 | eq_2);

endmodule
