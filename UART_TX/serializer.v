module serializer(
    input           clk,
    input           rst,
    input   [7:0]   p_data,
    input           ser_en,
    output          ser_done,
    output          ser_data
);
    reg [7:0] data_received;
    reg received;
    reg [3:0] nbits;
    assign ser_done = (nbits == 4'd8);
    assign ser_data = data_received[7];


    always@(posedge clk or negedge rst) begin
        if(~rst) begin
            data_received = 8'd0;
            received = 0;
        end
        else if(ser_en) begin
            data_received = p_data;
            received = 1;
        end
        else begin
            data_received = 8'd0;
            received = 0;
        end
    end

    always@(posedge clk) begin
        if(received) begin
            data_received = data_received << 1 ;
            nbits = nbits +  1 ;
        end
        else begin
            data_received = 8'd0;
            nbits = 4'd0;
        end
    end

endmodule