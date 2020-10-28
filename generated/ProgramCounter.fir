;buildInfoPackage: chisel3, version: 3.3.2, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit ProgramCounter : 
  module ProgramCounter : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip stop : UInt<1>, flip jump : UInt<1>, flip branch : UInt<1>, flip run : UInt<1>, flip programCounterOffset : SInt<8>, flip programCounterJump : UInt<16>, programCounter : UInt<16>}
    
    reg cnt : UInt<16>, clock with : (reset => (reset, UInt<16>("h00"))) @[ProgramCounter.scala 16:18]
    node _T = eq(io.run, UInt<1>("h00")) @[ProgramCounter.scala 18:19]
    node _T_1 = or(io.stop, _T) @[ProgramCounter.scala 18:16]
    when _T_1 : @[ProgramCounter.scala 18:28]
      cnt <= cnt @[ProgramCounter.scala 20:8]
      skip @[ProgramCounter.scala 18:28]
    else : @[ProgramCounter.scala 21:24]
      when io.branch : @[ProgramCounter.scala 21:24]
        node _T_2 = lt(io.programCounterOffset, asSInt(UInt<1>("h00"))) @[ProgramCounter.scala 23:33]
        when _T_2 : @[ProgramCounter.scala 23:38]
          node _T_3 = not(io.programCounterOffset) @[ProgramCounter.scala 24:17]
          node _T_4 = asSInt(_T_3) @[ProgramCounter.scala 24:17]
          node _T_5 = asUInt(_T_4) @[ProgramCounter.scala 24:49]
          node _T_6 = sub(cnt, _T_5) @[ProgramCounter.scala 24:15]
          node _T_7 = tail(_T_6, 1) @[ProgramCounter.scala 24:15]
          node _T_8 = sub(_T_7, UInt<1>("h01")) @[ProgramCounter.scala 24:51]
          node _T_9 = tail(_T_8, 1) @[ProgramCounter.scala 24:51]
          cnt <= _T_9 @[ProgramCounter.scala 24:10]
          skip @[ProgramCounter.scala 23:38]
        else : @[ProgramCounter.scala 25:16]
          node _T_10 = asUInt(io.programCounterOffset) @[ProgramCounter.scala 26:46]
          node _T_11 = add(cnt, _T_10) @[ProgramCounter.scala 26:15]
          node _T_12 = tail(_T_11, 1) @[ProgramCounter.scala 26:15]
          cnt <= _T_12 @[ProgramCounter.scala 26:10]
          skip @[ProgramCounter.scala 25:16]
        skip @[ProgramCounter.scala 21:24]
      else : @[ProgramCounter.scala 28:22]
        when io.jump : @[ProgramCounter.scala 28:22]
          cnt <= io.programCounterJump @[ProgramCounter.scala 30:8]
          skip @[ProgramCounter.scala 28:22]
        else : @[ProgramCounter.scala 31:15]
          node _T_13 = add(cnt, UInt<1>("h01")) @[ProgramCounter.scala 33:13]
          node _T_14 = tail(_T_13, 1) @[ProgramCounter.scala 33:13]
          cnt <= _T_14 @[ProgramCounter.scala 33:8]
          skip @[ProgramCounter.scala 31:15]
    io.programCounter <= cnt @[ProgramCounter.scala 36:21]
    
