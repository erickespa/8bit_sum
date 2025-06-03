`default_nettype none

module tt_um_erickespa (
    input  wire [7:0] ui_in,    // inputs A
    output wire [7:0] uo_out,   // outputs ULA
    input  wire [7:0] uio_in,   // IOs: Input B
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Internal wires
  wire [8:0] sum;  
    wire [7:0] rest;
    wire [7:0] opand;
    wire [7:0] opor;
    wire [7:0] izq;
    wire [7:0] dere;
    wire [2:0] ula = uio_in[7:5];  //utilice los ultimos 3 bits de B como entradas a la ULA por que ya no hay mas entradas.
    reg [7:0] result;

  //suma
  assign sum = ui_in + uio_in[4:0];
  //resta
  assign rest = ui_in - uio_in[4:0];
  //and
  assign opand = ui_in & uio_in[4:0];
  //or
  assign opor = ui_in | uio_in[4:0];
  //shift izq
    assign izq = {ui_in[6:0], 1'b0};
    //shift derecha
    assign dere = {1'b0, ui_in[7:1]};
    

      always @(*) begin
    case (ula)
      3'b000: result = sum[7:0];
      3'b001: result = rest;
      3'b010: result = opand;
      3'b011: result = opor;
      3'b100: result = izq;
      3'b101: result = dere;
         default: result = 8'b00000000;
    endcase
  end


        //asignar flags
wire carry = sum[8] & ~ula[1];
wire zero = ~|result;
wire negative = result[7];
wire overflow = (~ula[1]) & (ui_in[7] ^ result[7]) & ~(ula[0] ^ ui_in[7] ^ uio_in[4]);
  
 assign uo_out = result;
  assign uio_out = {4'b0000, carry, overflow, negative, zero};
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
