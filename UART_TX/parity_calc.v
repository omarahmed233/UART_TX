module parity_calc(
    input               clk,
    input               rst,
    input   [7:0]       p_data,
    input               data_valid,
    input               par_en,
    input               par_typ,
    output              par_bit
);

    reg [7:0] data_received;

    always@(posedge clk or negedge rst) begin
        if(~rst) begin
            data_received = 8'd0;
        end
        else if(ser_en && data_valid) begin
            data_received = p_data;
        end else
        data_received = 8'd0;
    end

    always @ (posedge clk or negedge rst) begin
        if(~rst) begin
            par_bit <= 'b0 ;
        end
        else begin
            if (par_en) begin
	            case(par_typ)
	                1'b0 : par_bit <= ^data_received  ;     
	                1'b1 : par_bit <= ~^data_received ;  
                    default : par_bit = 0;    	                		
	            endcase       	 
	        end
        end
    end 

endmodule

// 1 - avoid latches

// 2 - data_valid is asserted for only one clk cycle
