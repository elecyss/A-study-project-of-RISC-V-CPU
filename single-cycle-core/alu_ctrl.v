`include "riscv_define.v"
module alu_ctrl(
    input   [`ALU_OP_WIDTH-1:0]         alu_op,
    input   [`FUNCT3_WIDTH-1:0]         funct3,
    input   [`FUNCT7_WIDTH-1:0]         funct7,

    output  reg [`ALU_CTRL_WIDTH-1:0]   alu_ctrl
);

wire    [`FUNCT3_WIDTH +`FUNCT7_WIDTH -1:0]    funct;
assign funct = {funct7,funct3};
always@(*)
begin
    if(alu_op == 2'b00)
        alu_ctrl = `ADD;
    else if(alu_op[0])
        alu_ctrl = `SUB;
    else if(funct == 10'd0)
        alu_ctrl = `ADD;
    else if(funct[8])
        alu_ctrl = `SUB;
    else if(funct3[0])
        alu_ctrl = `AND;
    else
        alu_ctrl = `OR;
end
endmodule
