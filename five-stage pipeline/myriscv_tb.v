`timescale 1ns/10ps;
module myriscv_tb;

reg clk;
reg rstn;

initial
begin
    clk = 0;
    forever
    begin
        #5 clk = ~clk;
    end
end

initial
begin
    rstn = 0;
    #5 rstn = 1;
    #150
    $finish;
end


myriscv U_myriscv(
    .clk(clk),
    .rstn(rstn)
);
initial begin
$fsdbDumpfile("tb.fsdb");
$fsdbDumpvars(0,myriscv);
end

endmodule

