`include "./riscv_define.v"
module registers(
    input   [`REG_ADDR_WIDTH-1:0]   read_1_addr,
    input   [`REG_ADDR_WIDTH-1:0]   read_2_addr,

    input                           write_en,
    input   [`REG_ADDR_WIDTH-1:0]   write_addr,
    input   [`CPU_WIDTH-1:0]        write_data,

    output  reg [`CPU_WIDTH-1:0]        read_1_data,
    output  reg [`CPU_WIDTH-1:0]        read_2_data
);

reg [`CPU_WIDTH-1:0]    registers    [`REG_QUAN-1:0];

always@(*)
begin
    if(write_en && (write_addr != `CPU_WIDTH'd0))
        registers[write_addr] <= write_data;
end

always@(*)
begin
    if(read_1_addr == `CPU_WIDTH'd0)
        read_1_data = `CPU_WIDTH'd0;
    else
        read_1_data = registers[read_1_addr];
end

always@(*)
begin
    if(read_2_addr == `CPU_WIDTH'd0)
        read_2_data = `CPU_WIDTH'd0;
    else
        read_2_data = registers[read_2_addr];
end

/*integer i; 
initial
begin
    for (i=0; i<`REG_QUAN; i=i+1) 
        registers[i] = 32'd0; 
end*/

/*genvar   i;
		generate for(i=0;i<32;i=i+1)
		begin
		     always @(posedge clk or negedge rstn)begin
			     if(~rstn)
				    registers[i] <= 32'd0;
				 else if(write_en && (write_addr != `CPU_WIDTH'b0))
				    registers[write_addr] <= write_data;
			 end
		end
		endgenerate*/
      

/*genvar i;
generate for(i=0; i<`REG_QUAN; i=i+1)
begin: re
    always@(*)
    begin
        registers[i] = 32'b0;
        if(write_en && (write_addr != `CPU_WIDTH'b0))
            registers[write_addr] = write_data;
    end
end
endgenerate*/
/*always@(*)
begin
    if(write_en && (write_addr != `CPU_WIDTH'b0))
        registers[write_addr] <= write_data;
end*/


endmodule

