`include "./riscv_define.v"
module mem_wb(
    input                           clk,
    input                           rstn,
    input   [`WB_CTRL-1:0]          wb_i,
    input   [`CPU_WIDTH-1:0]        mem_data_i,
    input   [`CPU_WIDTH-1:0]        alu_result_i,
    input   [`REG_ADDR_WIDTH-1:0]   wreg_addr_i,

    output                          reg_write_o,
    output                          memtoreg_o,
    output  [`CPU_WIDTH-1:0]        mem_data_o,
    output  [`CPU_WIDTH-1:0]        alu_result_o,
    output  [`REG_ADDR_WIDTH-1:0]   wreg_addr_o
);

reg                          reg_write;
reg                          memtoreg;
reg  [`CPU_WIDTH-1:0]        mem_data;
reg  [`CPU_WIDTH-1:0]        alu_result;
reg  [`REG_ADDR_WIDTH-1:0]   wreg_addr;

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        reg_write <= 0;
    else
        reg_write <= wb_i[1];
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        memtoreg <= 0;
    else
        memtoreg <= wb_i[0];
end

always@(posedge clk or negedge rstn)
begin
    if(!rstn)
        mem_data <= `CPU_WIDTH'd0;
    else
        mem_data <= mem_data_i;
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
        wreg_addr <= `REG_ADDR_WIDTH'd0;
    else
        wreg_addr <= wreg_addr_i;
end

assign reg_write_o = reg_write;
assign memtoreg_o = memtoreg;
assign mem_data_o = mem_data;
assign alu_result_o = alu_result;
assign wreg_addr_o = wreg_addr; 

endmodule

