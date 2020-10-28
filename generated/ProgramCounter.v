module ProgramCounter(
  input         clock,
  input         reset,
  input         io_stop,
  input         io_jump,
  input         io_branch,
  input         io_run,
  input  [7:0]  io_programCounterOffset,
  input  [15:0] io_programCounterJump,
  output [15:0] io_programCounter
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] cnt; // @[ProgramCounter.scala 16:18]
  wire  _T = ~io_run; // @[ProgramCounter.scala 18:19]
  wire  _T_1 = io_stop | _T; // @[ProgramCounter.scala 18:16]
  wire  _T_2 = $signed(io_programCounterOffset) < 8'sh0; // @[ProgramCounter.scala 23:33]
  wire [7:0] _T_5 = ~io_programCounterOffset; // @[ProgramCounter.scala 24:49]
  wire [15:0] _GEN_4 = {{8'd0}, _T_5}; // @[ProgramCounter.scala 24:15]
  wire [15:0] _T_7 = cnt - _GEN_4; // @[ProgramCounter.scala 24:15]
  wire [15:0] _T_9 = _T_7 - 16'h1; // @[ProgramCounter.scala 24:51]
  wire [7:0] _T_10 = io_programCounterOffset; // @[ProgramCounter.scala 26:46]
  wire [15:0] _GEN_5 = {{8'd0}, _T_10}; // @[ProgramCounter.scala 26:15]
  wire [15:0] _T_12 = cnt + _GEN_5; // @[ProgramCounter.scala 26:15]
  wire [15:0] _T_14 = cnt + 16'h1; // @[ProgramCounter.scala 33:13]
  assign io_programCounter = cnt; // @[ProgramCounter.scala 36:21]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cnt = _RAND_0[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      cnt <= 16'h0;
    end else if (!(_T_1)) begin
      if (io_branch) begin
        if (_T_2) begin
          cnt <= _T_9;
        end else begin
          cnt <= _T_12;
        end
      end else if (io_jump) begin
        cnt <= io_programCounterJump;
      end else begin
        cnt <= _T_14;
      end
    end
  end
endmodule
