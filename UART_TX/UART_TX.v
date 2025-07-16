module UART_TX(
    input clk,
    input rst,
    input par_typ,
    input par_en,
    input data_valid,
    input [7:0] p_data,
    output TX_data,
    output busy
);
    wire ser_en;
    wire ser_done;
    FSM fsm1(
        .clk(clk),
        .rst(rst)
        .data_valid(data_valid),
        .ser_done(ser_done),
        .ser_en(ser_en),
        .par_en(par_en),
        .mux_sel(mux_sel),
        .busy(busy)
    );
    serializer serializer1(
        .clk(clk),
        .rst(rst)
        .p_data(p_data),
        .ser_data(ser_data),
        .ser_done(ser_done),
        .ser_en(ser_en)
    );
    parity_calc parity_calc1(
        .clk(clk),
        .rst(rst),
        .p_data(p_data),
        .data_valid(data_valid),
        .par_typ(par_typ),
        .par_bit(par_bit)
    ); 

endmodule