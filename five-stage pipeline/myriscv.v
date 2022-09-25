`include "./riscv_define.v"
module myriscv(
    input                           clk,
    input                           rstn
);

//pc_reg
wire    [`CPU_WIDTH-1:0]    pc_o;

//inst_mem
wire    [`CPU_WIDTH-1:0]    inst;

//if_id
wire    [`OPCODE_WIDTH-1:0]     opcode_if;
wire    [`REG_ADDR_WIDTH-1:0]   read_1_addr_if;
wire    [`REG_ADDR_WIDTH-1:0]   read_2_addr_if;
wire    [`REG_ADDR_WIDTH-1:0]   wreg_addr_if;
wire    [`IMM_WIDTH-1:0]        imm_if;
wire    [`FUNCT3_WIDTH-1:0]     funct3_if;
wire    [`FUNCT7_WIDTH-1:0]     funct7_if;
wire    [`CPU_WIDTH-1:0]        pc_trans_if;

//registers
wire    [`CPU_WIDTH-1:0]        read_1_data;
wire    [`CPU_WIDTH-1:0]        read_2_data;

//alu_mux
wire    [`CPU_WIDTH-1:0]        alu_i;

//alu
wire                            zero;
wire    [`CPU_WIDTH-1:0]        alu_result;

//data_mem
wire    [`CPU_WIDTH-1:0]        rdata;

//memtoreg_mux
wire    [`CPU_WIDTH-1:0]        reg_wdata;

//imm_gen
wire    [`CPU_WIDTH-1:0]        imm_gen;

//alu_ctrl
wire    [`ALU_CTRL_WIDTH-1:0]   alu_ctrl;

//cpu_ctrl
wire    [1:0]   wb;
wire    [2:0]   m;
wire    [2:0]   ex;

//add_shift
wire    [`CPU_WIDTH-1:0]        pc_shift;

//pc_add4
//wire    [`CPU_WIDTH-1:0]        pc_add4;

//pc_mux
//wire    [`CPU_WIDTH-1:0]        pc_nxt;

//id_ex
wire  [`WB_CTRL-1:0]          wb_ex;
wire  [`M_CTRL-1:0]           m_ex;
wire                          alus_rc_ex;
wire  [`ALU_OP_WIDTH-1:0]     alu_op_ex;
wire  [`CPU_WIDTH-1:0]        read_1_data_ex;
wire  [`CPU_WIDTH-1:0]        read_2_data_ex;
wire  [`CPU_WIDTH-1:0]        imm_gen_ex;
wire  [`FUNCT3_WIDTH-1:0]     funct3_ex;
wire  [`FUNCT7_WIDTH-1:0]     funct7_ex;
wire  [`REG_ADDR_WIDTH-1:0]   wreg_addr_ex;
wire  [`CPU_WIDTH-1:0]        pc_trans_ex;
wire  [`REG_ADDR_WIDTH-1:0]   rs1_ex;
wire  [`REG_ADDR_WIDTH-1:0]   rs2_ex;

//ex_mem
wire  [`WB_CTRL-1:0]          wb_m;
wire                          branch_m;
wire                          mem_write_m;
wire                          mem_read_m;
wire  [`CPU_WIDTH-1:0]        alu_result_m;
wire                          zero_m;
wire  [`CPU_WIDTH-1:0]        read_2_data_m;
wire  [`REG_ADDR_WIDTH-1:0]   wreg_addr_m;
wire  [`CPU_WIDTH-1:0]        pc_trans_m;
wire  [`CPU_WIDTH-1:0]        imm_gen_m;

//mem_wb
wire                          reg_write_wb;
wire                          memtoreg_wb;
wire  [`CPU_WIDTH-1:0]        mem_data_wb;
wire  [`CPU_WIDTH-1:0]        alu_result_wb;
wire  [`REG_ADDR_WIDTH-1:0]   wreg_addr_wb;

//forward
wire  [`FORWARD_CTRL_WIDTH-1:0]   forward_1;
wire  [`FORWARD_CTRL_WIDTH-1:0]   forward_2;

//rs1_mux
wire  [`CPU_WIDTH-1:0]        rs1_fwd;

//rs2_mux
wire  [`CPU_WIDTH-1:0]        rs2_fwd;

//hold_ctrl
wire                          hold_flag;
wire                          mem_read;
assign mem_read = m_ex[0];

//jump_ctrl
wire                          jump_flag;

/*
add_4 U_add_4(
    .pc_o(pc_o),
    .pc_add4(pc_add4)
);
*/
add_shift U_add_shift(
    .pc_o(pc_trans_m),
    .imm_gen(imm_gen_m),
    .pc_shift(pc_shift)
);

alu U_alu(
    .data_in_1(rs1_fwd),
    .data_in_2(alu_i),
    .zero(zero),
    .alu_result(alu_result),
    .alu_ctrl(alu_ctrl)
);

alu_ctrl U_alu_ctrl(
    .funct3(funct3_ex),
    .funct7(funct7_ex),
    .alu_ctrl(alu_ctrl),
    .alu_op(alu_op_ex)
);

alu_mux U_alu_mux(
    .reg_data(rs2_fwd),
    .imm_gen(imm_gen_ex),
    .alu_i(alu_i),
    .alus_rc(alus_rc_ex)
);

cpu_ctrl U_cpu_ctrl(
    .opcode(opcode_if),
    .wb(wb),
    .m(m),
    .ex(ex)
);

data_mem U_data_mem(
    .clk(clk),
    .addr(alu_result_m),
    .wdata(read_2_data_m),
    .read_en(mem_read_m),
    .write_en(mem_write_m),
    .rdata(rdata)
);

ex_mem U_ex_mem(
    .clk(clk),
    .rstn(rstn),
    .wb_i(wb_ex),
    .m_i(m_ex),
    .alu_result_i(alu_result),
    .zero_i(zero),
    .read_2_data_i(read_2_data_ex),
    .wreg_addr_i(wreg_addr_ex),
    .pc_trans_i(pc_trans_ex),
    .imm_gen_i(imm_gen_ex),
    .jump_flag(jump_flag),

    .wb_o(wb_m),
    .branch_o(branch_m),
    .mem_write_o(mem_write_m),
    .mem_read_o(mem_read_m),
    .alu_result_o(alu_result_m),
    .zero_o(zero_m),
    .read_2_data_o(read_2_data_m),
    .wreg_addr_o(wreg_addr_m),
    .pc_trans_o(pc_trans_m),
    .imm_gen_o(imm_gen_m)
);

forward U_forward(
    .rd_addr_m(wreg_addr_m),
    .rd_addr_wb(wreg_addr_wb),
    .rs1_addr(rs1_ex),
    .rs2_addr(rs2_ex),

    .forward_1(forward_1),
    .forward_2(forward_2)
);

hold_ctrl U_hold_ctrl(
    .mem_read(mem_read),
    .rs1(read_1_addr_if),
    .rs2(read_2_addr_if),
    .rd(wreg_addr_ex),

    .hold_flag(hold_flag)
);

id_ex U_id_ex(
    .clk(clk),
    .rstn(rstn),
    .wb_i(wb),
    .m_i(m),
    .ex_i(ex),
    .read_1_data_i(read_1_data),
    .read_2_data_i(read_2_data),
    .imm_gen_i(imm_gen),
    .funct3_i(funct3_if),
    .funct7_i(funct7_if),
    .wreg_addr_i(wreg_addr_if),
    .pc_trans_i(pc_trans_if),
    .rs1_i(read_1_addr_if),
    .rs2_i(read_2_addr_if),
    .hold_flag(hold_flag),
    .jump_flag(jump_flag),

    .wb_o(wb_ex),
    .m_o(m_ex),
    .alus_rc_o(alus_rc_ex),
    .alu_op_o(alu_op_ex),
    .read_1_data_o(read_1_data_ex),
    .read_2_data_o(read_2_data_ex),
    .imm_gen_o(imm_gen_ex),
    .funct3_o(funct3_ex),
    .funct7_o(funct7_ex),
    .wreg_addr_o(wreg_addr_ex),
    .pc_trans_o(pc_trans_ex),
    .rs1_o(rs1_ex),
    .rs2_o(rs2_ex)
);

if_id U_if_id(
    .clk(clk),
    .rstn(rstn),
    .inst_i(inst),
    .pc_trans_i(pc_o),
    .hold_flag(hold_flag),
    .jump_flag(jump_flag),

    .opcode_o(opcode_if),
    .read_1_addr_o(read_1_addr_if),
    .read_2_addr_o(read_2_addr_if),
    .wreg_addr_o(wreg_addr_if),
    .imm_o(imm_if),
    .funct3_o(funct3_if),
    .funct7_o(funct7_if),
    .pc_trans_o(pc_trans_if)
);

imm_gen U_imm_gen(
    .imm_i(imm_if),
    .imm_gen(imm_gen)
);

inst_mem U_inst_mem(
    .inst_addr(pc_o),
    .inst(inst)
);

jump_ctrl U_jump_ctrl(
    .branch(branch_m),
    .zero(zero_m),

    .jump_flag(jump_flag)
);

mem_wb U_mem_wb(
    .clk(clk),
    .rstn(rstn),
    .wb_i(wb_m),
    .mem_data_i(rdata),
    .alu_result_i(alu_result_m),
    .wreg_addr_i(wreg_addr_m),
    .reg_write_o(reg_write_wb),
    .memtoreg_o(memtoreg_wb),
    .mem_data_o(mem_data_wb),
    .alu_result_o(alu_result_wb),
    .wreg_addr_o(wreg_addr_wb)
);

memtoreg U_memtoreg(
    .mem_data(mem_data_wb),
    .alu_result(alu_result_wb),
    .reg_wdata(reg_wdata),
    .memtoreg(memtoreg_wb)
);
/*
pc_mux U_pc_mux(
    .pc_add4(pc_add4),
    .pc_shift(pc_shift_m),
    .pc_nxt(pc_nxt),
    .branch(branch_m),
    .zero(zero_m)
);
*/
pc_reg U_pc_reg(
//    .pc_nxt(pc_nxt),
    .clk(clk),
    .rstn(rstn),
    .jump_addr(pc_shift),
    .jump_flag(jump_flag),
    .hold_flag(hold_flag),

    .pc_o(pc_o)
);

registers U_registers(
    .read_1_addr(read_1_addr_if),
    .read_2_addr(read_2_addr_if),
    .write_addr(wreg_addr_wb),
    .write_data(mem_data_wb),
    .write_en(reg_write_wb),
    .read_1_data(read_1_data),
    .read_2_data(read_2_data)
);

rs1_mux U_rs1_mux(
    .rs1_ex(read_1_data_ex),
    .rs1_m(alu_result_m),
    .rs1_wb(reg_wdata),
    .forward_1(forward_1),

    .rs1_fwd(rs1_fwd)
);

rs2_mux U_rs2_mux(
    .rs2_ex(read_2_data_ex),
    .rs2_m(alu_result_m),
    .rs2_wb(reg_wdata),
    .forward_2(forward_2),

    .rs2_fwd(rs2_fwd)
);

endmodule





