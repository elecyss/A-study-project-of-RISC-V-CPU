`timescale 1ns/1ns;
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
    #10 rstn = 1;
    #1000
    $finish;
end


myriscv U_myriscv(
    .clk(clk),
    .rstn(rstn)
);


endmodule

