; ModuleID = 'prog.opt.o'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32"
target triple = "i386-pc-linux-gnu"

@.str = private constant [8 x i8] c"in_data\00"
@.str1 = private constant [9 x i8] c"out_data\00"

define void @maxDaemon() noreturn nounwind {
  br label %1

; <label>:1                                       ; preds = %1, %0
  %2 = tail call i32 @read_uint32(i8* getelementptr inbounds ([8 x i8]* @.str, i32 0, i32 0)) nounwind
  %3 = tail call i32 @read_uint32(i8* getelementptr inbounds ([8 x i8]* @.str, i32 0, i32 0)) nounwind
  %4 = icmp ugt i32 %2, %3
  %5 = select i1 %4, i32 %2, i32 %3
  tail call void @write_uint32(i8* getelementptr inbounds ([9 x i8]* @.str1, i32 0, i32 0), i32 %5) nounwind
  br label %1
}

declare i32 @read_uint32(i8*)

declare void @write_uint32(i8*, i32)
