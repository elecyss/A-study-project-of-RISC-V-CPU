`include "./riscv_define.v"
module if_id(
    input                           clk,
    input                           rstn,
    input   [`CPU_WIDTH-1:0]        inst_i,
    input   [`CPU_WIDTH-1:0]        pc_trans_i,
    input                           hold_flag,
    input                           jump_flag,

    output  [`OPCODE_WIDTH-1:0]     opcode_o,
    output  [`REG_ADDR_WIDTH-1:0]   read_1_addr_o,
    output  [`REG_ADDR_WIDTH-1:0]   read_2_addr_o,
    output  [`REG_ADDR_WIDTH-1:0]   wreg_addr_o,
    output  [`IMM_WIDTH-1:0]        imm_o,
    output  [`FUNCT3_WIDTH-1:0]     funct3_o,
    output  [`FUNCT7_WIDTH-1:0]     funct7_o,
    output  [`CPU_WIDTH-1:0]        pc_trans_o
);

reg  [`OPCODE_WIDTH-1:0]     opcode;
reg  [`REG_ADDR_WIDTH-1:0]   read_1_addr;
reg  [`REG_ADDR_WIDTH-1:0]   read_2_addr;
reg  [`REG_ADDR_WIDTH-1:0]   wreg_addr;
reg  [`IMM_WIDTH-1:0]        imm;
reg  [`FUNCT3_WIDTH-1:0]     funct3;
reg  [`FUNCT7_WIDTH-1:0]     funct7;
reg  [`CPU_WIDTH-1:0]        pc_trans;


always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        opcode <= `OPCODE_WIDTH'd0;
    else if(jump_flag)
        opcode <= `OPCODE_WIDTH'd0;
    else if(hold_flag)
        opcode <= opcode;
    else
        opcode <= inst_i[6:0];
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        read_1_addr <= `REG_ADDR_WIDTH'd0;
    else if(jump_flag)
        read_1_addr <= `REG_ADDR_WIDTH'd0;
    else if(hold_flag)
        read_1_addr <= read_1_addr;
    else
        read_1_addr <= inst_i[19:15];
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        read_2_addr <= `REG_ADDR_WIDTH'd0;
    else if(jump_flag)
        read_2_addr <= `REG_ADDR_WIDTH'd0;
    else if(hold_flag)
        read_2_addr <= read_2_addr;
    else
        read_2_addr <= inst_i[24:20];
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        wreg_addr <= `REG_ADDR_WIDTH'd0;
    else if(jump_flag)
        wreg_addr <= `REG_ADDR_WIDTH'd0;
    else if(hold_flag)
        wreg_addr <= wreg_addr;
    else
        wreg_addr <= inst_i[11:7];
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        funct3 <= `FUNCT3_WIDTH'd0;
    else if(jump_flag)
        funct3 <= `FUNCT3_WIDTH'd0;
    else if(hold_flag)
        funct3 <= funct3;
    else
        funct3 <= inst_i[14:12];
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        funct7 <= `FUNCT7_WIDTH'd0;
    else if(jump_flag)
        funct7 <= `FUNCT7_WIDTH'd0;
    else if(hold_flag)
        funct7 <= funct7;
    else
        funct7 <= inst_i[31:25];
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        pc_trans <= `CPU_WIDTH'd0;
    else if(jump_flag)
        pc_trans <= `CPU_WIDTH'd0;
    else if(hold_flag)
        pc_trans <= pc_trans;
    else
        pc_trans <= pc_trans_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        imm <= `IMM_WIDTH'd0;
    else if(jump_flag)
        imm <= `IMM_WIDTH'd0;
    else if(hold_flag)
        imm <= imm;
    else if(~inst_i[5])
        imm <= inst_i[31:20];
    else if(inst_i[6])
        imm <= {inst_i[31], inst_i[7], inst_i[30:25], inst_i[11:8]};
    else
        imm <= {inst_i[31:25], inst_i[11:7]};
end

assign opcode_o = opcode;
assign read_1_addr_o = read_1_addr;
assign read_2_addr_o = read_2_addr;
assign wreg_addr_o = wreg_addr;
assign imm_o = imm;
assign funct3_o = funct3;
assign funct7_o = funct7;
assign pc_trans_o = pc_trans;

endmodule
