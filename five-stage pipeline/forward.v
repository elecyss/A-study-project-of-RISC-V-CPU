`include "./riscv_define.v"
module forward(
    input   [`REG_ADDR_WIDTH-1:0]       rd_addr_m,
    input   [`REG_ADDR_WIDTH-1:0]       rd_addr_wb,
    input   [`REG_ADDR_WIDTH-1:0]       rs1_addr,
    input   [`REG_ADDR_WIDTH-1:0]       rs2_addr,

    output  reg [`FORWARD_CTRL_WIDTH-1:0]   forward_1,
    output  reg [`FORWARD_CTRL_WIDTH-1:0]   forward_2
);
wire empty_n1, empty_n2;
assign empty_n1 = |rs1_addr;
assign empty_n2 = |rs2_addr;
always@(*)
begin
    forward_1 = `FORWARD_CTRL_WIDTH'b00;
    if((rd_addr_m == rs1_addr) && empty_n1)
        forward_1 = `FORWARD_CTRL_WIDTH'b10;
    else if((rd_addr_wb == rs1_addr) && empty_n1)
        forward_1 = `FORWARD_CTRL_WIDTH'b01;
    else
        forward_1 = `FORWARD_CTRL_WIDTH'b00;
end

always@(*)
begin
    forward_2 = `FORWARD_CTRL_WIDTH'b00;
    if((rd_addr_m == rs2_addr) && empty_n2)
        forward_2 = `FORWARD_CTRL_WIDTH'b10;
    else if((rd_addr_wb == rs2_addr) && empty_n2)
        forward_2 = `FORWARD_CTRL_WIDTH'b01;
    else
        forward_2 = `FORWARD_CTRL_WIDTH'b00;
end

endmodule

