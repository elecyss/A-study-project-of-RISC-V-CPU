`include "riscv_define.v"
module myriscv(
    input                           clk,
    input                           rstn
);

//pc_reg
wire    [`CPU_WIDTH-1:0]    pc_o;

//inst_mem
wire    [`CPU_WIDTH-1:0]    inst;

//inst_split
wire    [`OPCODE_WIDTH-1:0]     opcode;
wire    [`REG_ADDR_WIDTH-1:0]   read_1_addr;
wire    [`REG_ADDR_WIDTH-1:0]   read_2_addr;
wire    [`REG_ADDR_WIDTH-1:0]   write_addr;
wire    [`IMM_WIDTH-1:0]        imm_i;
wire    [`FUNCT3_WIDTH-1:0]     funct3;
wire    [`FUNCT7_WIDTH-1:0]     funct7;

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
wire                            branch;
wire                            mem_read;
wire                            memtoreg;
wire    [`ALU_OP_WIDTH-1:0]     alu_op;
wire                            mem_write;
wire                            alus_rc;
wire                            reg_write;

//add_shift
wire    [`CPU_WIDTH-1:0]        pc_shift;

//pc_add4
wire    [`CPU_WIDTH-1:0]        pc_add4;

//pc_mux
wire    [`CPU_WIDTH-1:0]        pc_nxt;

pc_reg U_pc_reg(
    .pc_nxt(pc_nxt),
    .clk(clk),
    .rstn(rstn),
    .pc_o(pc_o)
);

inst_mem U_inst_mem(
    .inst_addr(pc_o),
    .inst(inst)
);

inst_split U_inst_split(
    .inst(inst),
    .opcode(opcode),
    .read_1_addr(read_1_addr),
    .read_2_addr(read_2_addr),
    .write_addr(write_addr),
    .imm_i(imm_i),
    .funct3(funct3),
    .funct7(funct7)
);

registers U_registers(
    .clk(clk),
    .rstn(rstn),
    .read_1_addr(read_1_addr),
    .read_2_addr(read_2_addr),
    .write_addr(write_addr),
    .write_data(reg_wdata),
    .write_en(reg_write),
    .read_1_data(read_1_data),
    .read_2_data(read_2_data)
);

alu_mux U_alu_mux(
    .reg_data(read_2_data),
    .imm_gen(imm_gen),
    .alu_i(alu_i),
    .alus_rc(alus_rc)
);

alu U_alu(
    .data_in_1(read_1_data),
    .data_in_2(alu_i),
    .zero(zero),
    .alu_result(alu_result),
    .alu_ctrl(alu_ctrl)
);

data_mem U_data_mem(
    .clk(clk),
//    .rstn(rstn),
    .addr(alu_result),
    .wdata(read_2_data),
    .read_en(mem_read),
    .write_en(mem_write),
    .rdata(rdata)
);

memtoreg U_memtoreg(
    .mem_data(rdata),
    .alu_result(alu_result),
    .reg_wdata(reg_wdata),
    .memtoreg(memtoreg)
);

imm_gen U_imm_gen(
    .imm_i(imm_i),
    .imm_gen(imm_gen)
);

alu_ctrl U_alu_ctrl(
    .funct3(funct3),
    .funct7(funct7),
    .alu_ctrl(alu_ctrl),
    .alu_op(alu_op)
);

cpu_ctrl U_cpu_ctrl(
    .opcode(opcode),
    .branch(branch),
    .mem_read(mem_read),
    .memtoreg(memtoreg),
    .alu_op(alu_op),
    .mem_write(mem_write),
    .alus_rc(alus_rc),
    .reg_write(reg_write)
);

add_4 U_add_4(
    .pc_o(pc_o),
    .pc_add4(pc_add4)
);

add_shift U_add_shift(
    .pc_o(pc_o),
    .imm_gen(imm_gen),
    .pc_shift(pc_shift)
);

pc_mux U_pc_mux(
    .pc_add4(pc_add4),
    .pc_shift(pc_shift),
    .pc_nxt(pc_nxt),
    .branch(branch),
    .zero(zero)
);

endmodule





