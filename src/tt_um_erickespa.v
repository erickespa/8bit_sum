`default_nettype none

module tt_um_erickespa (
    input  wire [7:0] ui_in,    // Dedicated inputs (A)
    output wire [7:0] uo_out,   // Dedicated outputs (sum[7:0])
    input  wire [7:0] uio_in,   // IOs: Input path (B)
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Internal wires
  wire [8:0] sum;  // 9 bits to hold overflow

  // Perform 8-bit addition
  assign sum = ui_in + uio_in;

  // Assign the lower 8 bits of the result to output
  assign uo_out = sum[7:0];

  // Optionally: use the 9th bit as overflow indication on a GPIO output
  assign uio_out = {7'b0, sum[8]};  // overflow bit on uio_out[0]
  assign oio_out[7:1] = 0; 
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
