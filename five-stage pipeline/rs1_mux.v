`include "./riscv_define.v"
module rs1_mux(
    input   [`CPU_WIDTH-1:0]            rs1_ex,
    input   [`CPU_WIDTH-1:0]            rs1_m,
    input   [`CPU_WIDTH-1:0]            rs1_wb,
    input   [`FORWARD_CTRL_WIDTH-1:0]   forward_1,

    output  reg [`CPU_WIDTH-1:0]        rs1_fwd
);

always@(*)
begin
    case(forward_1)
        `FORWARD_CTRL_WIDTH'b00: rs1_fwd = rs1_ex;
        `FORWARD_CTRL_WIDTH'b10: rs1_fwd = rs1_m;
        `FORWARD_CTRL_WIDTH'b01: rs1_fwd = rs1_wb;
        default: rs1_fwd = rs1_fwd;
    endcase
end

endmodule
