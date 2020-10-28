import chisel3._

class ProgramCounter extends Module {
  val io = IO(new Bundle {
    val stop = Input(Bool())
    val jump = Input(Bool())
    val branch = Input(Bool())
    val run = Input(Bool())
    val programCounterOffset= Input(SInt(8.W))
    val programCounterJump = Input(UInt(16.W))
    val programCounter = Output(UInt(16.W))
  })

  //Implement this module here (respect the provided interface, since it used by the tester)

  val cnt=RegInit(0.U(16.W))

  when(io.stop || !io.run ){
    //keep value
    cnt:=cnt
  }.elsewhen(io.branch){
    //offset
    when(io.programCounterOffset<0.S){
      cnt:=cnt-(~io.programCounterOffset).asUInt()-1.U
    }.otherwise{
      cnt:=cnt+io.programCounterOffset.asUInt()
    }
  }.elsewhen(io.jump){
    //set value
    cnt:= io.programCounterJump
  }.otherwise {
    //increment
    cnt:=cnt+1.U
  }

  io.programCounter := cnt
}