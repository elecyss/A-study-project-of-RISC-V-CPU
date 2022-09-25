`include "riscv_define.v"
module inst_split(
    input   [`CPU_WIDTH-1:0]        inst,

    output  [`OPCODE_WIDTH-1:0]     opcode,
    output  [`REG_ADDR_WIDTH-1:0]   read_1_addr,
    output  [`REG_ADDR_WIDTH-1:0]   read_2_addr,
    output  [`REG_ADDR_WIDTH-1:0]   write_addr,
    output  reg [`IMM_WIDTH-1:0]        imm_i,
    output  [`FUNCT3_WIDTH-1:0]     funct3,
    output  [`FUNCT7_WIDTH-1:0]     funct7
);

assign opcode = inst[6:0];
assign read_1_addr = inst[19:15];
assign read_2_addr = inst[24:20];
assign write_addr = inst[11:7];
assign funct3 = inst[14:12];
assign funct7 = inst[31:25];

always@(*)
begin
    if(~inst[5])
        imm_i = inst[31:20];
    else if(inst[6])
        imm_i = {inst[31], inst[7], inst[30:25], inst[11:8]};
    else
        imm_i = {inst[31:25], inst[11:7]};
end
endmodule
