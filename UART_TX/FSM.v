module FSM(
    input               clk
    input               rst,
    input               data_valid,
    input               ser_done,
    input               par_en,
    output              ser_en,
    output      [1:0]   mux_sel,
    output              busy
);

    localparam  IDLE = 0,
                start = 1,
                Data = 2,
                parity = 3,
                stop = 4;

    reg [2:0] state,next;

    always@(posedge clk or negedge rst)  begin
        if(~rst)
            state <= IDLE ;
        else
            state <= next ;
    end 

    always@(*) begin
        case(state)
            IDLE    : next = data_valid ? start : IDLE ;
            start   : next = Data ;
            Data    : next = next = ser_done ? (par_en ? parity : stop) : Data ;
            parity  : next = stop ;
            stop    : next = IDLE ;
            default : next = IDLE ;
        endcase
    end

    always@(*) begin
        case(state)
            IDLE : begin
                mux_sel = 2'b00 ;
                busy = 0 ;
                ser_en = 0 ;
            end
            start : begin
                busy = 1;
                mux_sel = 2'b00;
                ser_en = 0;
            end
            Data : begin
                busy = 1;
                mux_sel = 2'b10;
                ser_en = 1;
            end
            parity : begin
                busy = 1;
                mux_sel = 2'b11
                ser_en = 0;
            end
        endcase
    end



endmodule