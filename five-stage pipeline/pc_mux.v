`include "./riscv_define.v"
module pc_mux(
    input                           branch,
    input                           zero,
    input        [`CPU_WIDTH-1:0]   pc_add4,
    input        [`CPU_WIDTH-1:0]   pc_shift,

    output  reg  [`CPU_WIDTH-1:0]   pc_nxt
);

assign choose = branch & zero;

always@(*)
begin
    if(choose)
        pc_nxt = pc_shift;
    else
        pc_nxt = pc_add4;
end

endmodule

