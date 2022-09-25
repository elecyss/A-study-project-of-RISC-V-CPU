`include "./riscv_define.v"
module imm_gen(
    input       [`IMM_WIDTH-1:0]        imm_i,

    output   [`CPU_WIDTH-1:0]       imm_gen
);

parameter GEN_WIDTH = `CPU_WIDTH-`IMM_WIDTH;

genvar  i;
generate for(i=0;i<GEN_WIDTH;i=i+1)
begin:imm
    assign imm_gen[`IMM_WIDTH+i:`IMM_WIDTH] = imm_i[`IMM_WIDTH-1];
end        
endgenerate

assign imm_gen[`IMM_WIDTH-1:0] = imm_i[`IMM_WIDTH-1:0];

endmodule

