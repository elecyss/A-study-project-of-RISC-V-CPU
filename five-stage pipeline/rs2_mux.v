`include "./riscv_define.v"
module rs2_mux(
    input   [`CPU_WIDTH-1:0]            rs2_ex,
    input   [`CPU_WIDTH-1:0]            rs2_m,
    input   [`CPU_WIDTH-1:0]            rs2_wb,
    input   [`FORWARD_CTRL_WIDTH-1:0]   forward_2,

    output  reg  [`CPU_WIDTH-1:0]       rs2_fwd
);

always@(*)
begin
    case(forward_2)
        `FORWARD_CTRL_WIDTH'b00: rs2_fwd = rs2_ex;
        `FORWARD_CTRL_WIDTH'b10: rs2_fwd = rs2_m;
        `FORWARD_CTRL_WIDTH'b01: rs2_fwd = rs2_wb;
        default: rs2_fwd = rs2_fwd;
    endcase
end

endmodule
