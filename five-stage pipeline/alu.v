`include "./riscv_define.v"
module alu(
    input   [`CPU_WIDTH-1:0]        data_in_1,
    input   [`CPU_WIDTH-1:0]        data_in_2,
    input   [`ALU_CTRL_WIDTH-1:0]     alu_ctrl,

    output  reg [`CPU_WIDTH-1:0]        alu_result,
    output                          zero
);

wire    [`CPU_WIDTH-1:0]    data_in_2_f;
assign data_in_2_f = ~data_in_2 + 1;

always@(*)
begin
    alu_result = 0;
    case(alu_ctrl)
    `AND: alu_result = data_in_1 | data_in_2;
    `OR: alu_result = data_in_1 & data_in_2;
    `ADD: alu_result = data_in_1 + data_in_2;
    `SUB: alu_result = data_in_1 + data_in_2_f;
    endcase
end

assign zero = &(~alu_result);

endmodule

