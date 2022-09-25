
`define CPU_WIDTH 32

//inst_mem
`define INST_MEM_ADDR_WIDTH 10
`define INST_MEM_ADDR_DEPTH 1024 //2^10=1024

//registers
`define REG_ADDR_WIDTH 5
`define REG_QUAN 32

//imm_gen
`define IMM_WIDTH 12

//ALU
`define ALU_CTRL_WIDTH 4
`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define SUB 4'b0110

//data_mem
`define DATA_MEM_ADDR_WIDTH 10
`define DATA_MEM_ADDR_DEPTH 1024

//alu_ctrl
`define ALU_OP_WIDTH 2
`define FUNCT3_WIDTH 3
`define FUNCT7_WIDTH 7

//cpu_ctrl
`define OPCODE_WIDTH 7
`define R_OPCODE 7'b0110011
`define I_OPCODE 7'b0000011
`define S_OPCODE 7'b0100011
`define B_OPCODE 7'b1100011
