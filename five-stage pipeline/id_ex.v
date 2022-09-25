`include "./riscv_define.v"
module id_ex(
    input                           clk,
    input                           rstn,
    input   [`WB_CTRL-1:0]          wb_i,
    input   [`M_CTRL-1:0]           m_i,
    input   [`EX_CTRL-1:0]          ex_i,
    input   [`CPU_WIDTH-1:0]        read_1_data_i,
    input   [`CPU_WIDTH-1:0]        read_2_data_i,
    input   [`CPU_WIDTH-1:0]        imm_gen_i,
    input   [`FUNCT3_WIDTH-1:0]     funct3_i,
    input   [`FUNCT7_WIDTH-1:0]     funct7_i,
    input   [`REG_ADDR_WIDTH-1:0]   wreg_addr_i,
    input   [`CPU_WIDTH-1:0]        pc_trans_i,
    input   [`REG_ADDR_WIDTH-1:0]   rs1_i,
    input   [`REG_ADDR_WIDTH-1:0]   rs2_i,
    input                           hold_flag,
    input                           jump_flag,

    output  [`WB_CTRL-1:0]          wb_o,
    output  [`M_CTRL-1:0]           m_o,
    output                          alus_rc_o,
    output  [`ALU_OP_WIDTH-1:0]      alu_op_o,
    output  [`CPU_WIDTH-1:0]        read_1_data_o,
    output  [`CPU_WIDTH-1:0]        read_2_data_o,
    output  [`CPU_WIDTH-1:0]        imm_gen_o,
    output  [`FUNCT3_WIDTH-1:0]     funct3_o,
    output  [`FUNCT7_WIDTH-1:0]     funct7_o,
    output  [`REG_ADDR_WIDTH-1:0]   wreg_addr_o,
    output  [`CPU_WIDTH-1:0]        pc_trans_o,
    output  [`REG_ADDR_WIDTH-1:0]   rs1_o,
    output  [`REG_ADDR_WIDTH-1:0]   rs2_o
);

reg     [`WB_CTRL-1:0]          wb;
reg     [`M_CTRL-1:0]           m;
reg                             alus_rc;
reg     [`ALU_OP_WIDTH-1:0]      alu_op;
reg     [`CPU_WIDTH-1:0]        read_1_data;
reg     [`CPU_WIDTH-1:0]        read_2_data;
reg     [`CPU_WIDTH-1:0]        imm_gen;
reg     [`FUNCT3_WIDTH-1:0]     funct3;
reg     [`FUNCT7_WIDTH-1:0]     funct7;
reg     [`REG_ADDR_WIDTH-1:0]   wreg_addr;
reg     [`CPU_WIDTH-1:0]        pc_trans;
reg     [`REG_ADDR_WIDTH-1:0]   rs1;
reg     [`REG_ADDR_WIDTH-1:0]   rs2;

wire hold;
assign hold = hold_flag | jump_flag;

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        wb <= `WB_CTRL'd0;
    else if(hold)
        wb <= `WB_CTRL'd0;
    else
        wb <= wb_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        m <= `M_CTRL'd0;
    else if(hold)
        m <= `WB_CTRL'd0;
    else
        m <= m_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        alus_rc <= 0;
    else if(hold)
        alus_rc <= `WB_CTRL'd0;
    else
        alus_rc <= ex_i[2];
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        alu_op <= `ALU_OP_WIDTH'd0;
    else if(hold)
        alu_op <= `WB_CTRL'd0;
    else
        alu_op <= ex_i[1:0];
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        read_1_data <= `CPU_WIDTH'd0;
    else
        read_1_data <= read_1_data_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        read_2_data <= `CPU_WIDTH'd0;
    else
        read_2_data <= read_2_data_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        imm_gen <= `CPU_WIDTH'd0;
    else
        imm_gen <= imm_gen_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        funct3 <= `FUNCT3_WIDTH'd0;
    else
        funct3 <= funct3_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        funct7 <= `FUNCT7_WIDTH'd0;
    else
        funct7 <= funct7_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        wreg_addr <= `REG_ADDR_WIDTH'd0;
    else
        wreg_addr <= wreg_addr_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        pc_trans <= `CPU_WIDTH'd0;
    else
        pc_trans <= pc_trans_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        rs1 <= `REG_ADDR_WIDTH'd0;
    else
        rs1 <= rs1_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        rs2 <= `REG_ADDR_WIDTH'd0;
    else
        rs2 <= rs2_i;
end

assign wb_o = wb;
assign m_o = m;
assign alus_rc_o = alus_rc;
assign alu_op_o = alu_op;
assign read_1_data_o = read_1_data;
assign read_2_data_o = read_2_data;
assign imm_gen_o = imm_gen;
assign funct3_o = funct3;
assign funct7_o = funct7;
assign wreg_addr_o = wreg_addr;
assign pc_trans_o = pc_trans;
assign rs1_o = rs1;
assign rs2_o = rs2;

endmodule

