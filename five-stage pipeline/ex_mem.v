`include "./riscv_define.v"
module ex_mem(
    input                           clk,
    input                           rstn,
    input   [`WB_CTRL-1:0]          wb_i,
    input   [`M_CTRL-1:0]           m_i,
    input   [`CPU_WIDTH-1:0]        pc_shift_i,
    input   [`CPU_WIDTH-1:0]        alu_result_i,
    input                           zero_i,
    input   [`CPU_WIDTH-1:0]        read_2_data_i,
    input   [`REG_ADDR_WIDTH-1:0]   wreg_addr_i,
    input   [`CPU_WIDTH-1:0]        imm_gen_i,
    input   [`CPU_WIDTH-1:0]        pc_trans_i,
    input                           jump_flag,

    output  [`WB_CTRL-1:0]          wb_o,
    output                          branch_o,
    output                          mem_write_o,
    output                          mem_read_o,
    output  [`CPU_WIDTH-1:0]        pc_shift_o,
    output  [`CPU_WIDTH-1:0]        alu_result_o,
    output                          zero_o,
    output  [`CPU_WIDTH-1:0]        read_2_data_o,
    output  [`REG_ADDR_WIDTH-1:0]   wreg_addr_o,
    output  [`CPU_WIDTH-1:0]        imm_gen_o,
    output  [`CPU_WIDTH-1:0]        pc_trans_o
);

reg  [`WB_CTRL-1:0]          wb;
reg                          branch;
reg                          mem_write;
reg                          mem_read;
reg  [`CPU_WIDTH-1:0]        pc_shift;
reg  [`CPU_WIDTH-1:0]        alu_result;
reg                          zero;
reg  [`CPU_WIDTH-1:0]        read_2_data;
reg  [`REG_ADDR_WIDTH-1:0]   wreg_addr;
reg     [`CPU_WIDTH-1:0]        imm_gen;
reg     [`CPU_WIDTH-1:0]        pc_trans;

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        wb <= `WB_CTRL'd0;
    else if(jump_flag)
        wb <= `WB_CTRL'd0;
    else
        wb <= wb_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        branch <= 0;
    else if(jump_flag)
        branch <= `WB_CTRL'd0;
    else
        branch <= m_i[2];
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        mem_write <= 0;
    else if(jump_flag)
        mem_write <= `WB_CTRL'd0;
    else
        mem_write <= m_i[1];
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        mem_read <= 0;
    else if(jump_flag)
        mem_read <= `WB_CTRL'd0;
    else
        mem_read <= m_i[0];
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        pc_shift <= `CPU_WIDTH'd0;
    else
        pc_shift <= pc_shift_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        alu_result <= `CPU_WIDTH'd0;
    else
        alu_result <= alu_result_i;
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        zero <= 0;
    else
        zero <= zero_i;
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
        wreg_addr <= `REG_ADDR_WIDTH'd0;
    else
        wreg_addr <= wreg_addr_i;
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
        pc_trans <= `CPU_WIDTH'd0;
    else
        pc_trans <= pc_trans_i;
end

assign wb_o = wb;
assign branch_o = branch;
assign mem_write_o = mem_write;
assign mem_read_o = mem_read;
assign pc_shift_o = pc_shift;
assign alu_result_o = alu_result;
assign zero_o = zero;
assign read_2_data_o = read_2_data;
assign wreg_addr_o = wreg_addr;
assign imm_gen_o = imm_gen;
assign pc_trans_o = pc_trans;

endmodule

