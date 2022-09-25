`include "riscv_define.v"
module cpu_ctrl(
    input   [`OPCODE_WIDTH-1:0]     opcode,

    output  reg                        branch,
    output  reg                        mem_read,
    output  reg                        memtoreg,
    output  reg [`ALU_OP_WIDTH-1:0]     alu_op,
    output  reg                        mem_write,
    output  reg                        alus_rc,
    output  reg                        reg_write
);

always@(*)
begin
            branch = 0;
            mem_read = 0;
            memtoreg = 0;
            alu_op = 2'b00;
            mem_write = 0;
            alus_rc = 0;
            reg_write = 0;
    case(opcode)
        `R_OPCODE:begin
            branch = 0;
            mem_read = 0;
            memtoreg = 0;
            alu_op = 2'b10;
            mem_write = 0;
            alus_rc = 0;
            reg_write = 1;
        end
        `I_OPCODE:begin
            branch = 0;
            mem_read = 1;
            memtoreg = 1;
            alu_op = 2'b00;
            mem_write = 0;
            alus_rc = 1;
            reg_write = 1;
        end
        `S_OPCODE:begin
            branch = 0;
            mem_read = 0;
            memtoreg = 0;
            alu_op = 2'b00;
            mem_write = 1;
            alus_rc = 1;
            reg_write = 0;
        end
        `B_OPCODE:begin
            branch = 1;
            mem_read = 0;
            memtoreg = 0;
            alu_op = 2'b01;
            mem_write = 0;
            alus_rc = 0;
            reg_write = 0;
        end
    endcase
end

endmodule

