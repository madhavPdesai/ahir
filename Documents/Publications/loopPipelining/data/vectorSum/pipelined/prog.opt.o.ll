; ModuleID = 'prog.opt.o'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32"
target triple = "i386-pc-linux-gnu"

@.str = private constant [13 x i8] c"in_data_pipe\00"
@A = common global [64 x float] zeroinitializer, align 4
@B = common global [64 x float] zeroinitializer, align 4
@C = common global [64 x float] zeroinitializer, align 4
@.str1 = private constant [14 x i8] c"out_data_pipe\00"

define void @getData() nounwind {
bb.nph:
  br label %0

; <label>:0                                       ; preds = %0, %bb.nph
  %idx.01 = phi i32 [ 0, %bb.nph ], [ %2, %0 ]
  %scevgep2 = getelementptr [64 x float]* @B, i32 0, i32 %idx.01
  %scevgep = getelementptr [64 x float]* @A, i32 0, i32 %idx.01
  %1 = tail call float @read_float32(i8* getelementptr inbounds ([13 x i8]* @.str, i32 0, i32 0)) nounwind
  store float %1, float* %scevgep, align 4
  store float %1, float* %scevgep2, align 4
  %2 = add nsw i32 %idx.01, 1
  %exitcond1 = icmp eq i32 %2, 64
  br i1 %exitcond1, label %._crit_edge, label %0

._crit_edge:                                      ; preds = %0
  ret void
}

declare float @read_float32(i8*)

define void @sendResult() nounwind {
bb.nph:
  br label %0

; <label>:0                                       ; preds = %0, %bb.nph
  %idx.01 = phi i32 [ 0, %bb.nph ], [ %2, %0 ]
  %scevgep = getelementptr [64 x float]* @C, i32 0, i32 %idx.01
  %1 = load float* %scevgep, align 4
  tail call void @write_float32(i8* getelementptr inbounds ([14 x i8]* @.str1, i32 0, i32 0), float %1) nounwind
  %2 = add nsw i32 %idx.01, 1
  %exitcond1 = icmp eq i32 %2, 64
  br i1 %exitcond1, label %._crit_edge, label %0

._crit_edge:                                      ; preds = %0
  ret void
}

declare void @write_float32(i8*, float)

define void @vectorSum() noreturn nounwind {
; <label>:0
  br label %sendResult.exit

sendResult.exit.loopexit:                         ; preds = %_vectorSum_.exit
  br label %sendResult.exit.backedge

sendResult.exit:                                  ; preds = %sendResult.exit.backedge, %0
  %idx.01.i = phi i32 [ 0, %0 ], [ %idx.01.i.be, %sendResult.exit.backedge ]
  %scevgep.i = getelementptr [64 x float]* @A, i32 0, i32 %idx.01.i
  %scevgep2.i = getelementptr [64 x float]* @B, i32 0, i32 %idx.01.i
  %1 = tail call float @read_float32(i8* getelementptr inbounds ([13 x i8]* @.str, i32 0, i32 0)) nounwind
  store float %1, float* %scevgep.i, align 4
  store float %1, float* %scevgep2.i, align 4
  %2 = add nsw i32 %idx.01.i, 1
  %exitcond.i = icmp eq i32 %2, 64
  br i1 %exitcond.i, label %getData.exit.preheader, label %sendResult.exit.backedge

sendResult.exit.backedge:                         ; preds = %sendResult.exit, %sendResult.exit.loopexit
  %idx.01.i.be = phi i32 [ %2, %sendResult.exit ], [ 0, %sendResult.exit.loopexit ]
  br label %sendResult.exit

getData.exit.preheader:                           ; preds = %sendResult.exit
  br label %getData.exit

getData.exit:                                     ; preds = %getData.exit, %getData.exit.preheader
  %indvar.i = phi i32 [ %indvar.next.i, %getData.exit ], [ 0, %getData.exit.preheader ]
  %scevgep.i1 = getelementptr [64 x float]* @A, i32 0, i32 %indvar.i
  %scevgep2.i2 = getelementptr [64 x float]* @B, i32 0, i32 %indvar.i
  %scevgep3.i = getelementptr [64 x float]* @C, i32 0, i32 %indvar.i
  tail call void @loop_pipelining_on(i32 8) nounwind
  %3 = load float* %scevgep.i1, align 4
  %4 = load float* %scevgep2.i2, align 4
  %5 = fadd float %3, %4
  store float %5, float* %scevgep3.i, align 4
  %indvar.next.i = add i32 %indvar.i, 1
  %exitcond1 = icmp eq i32 %indvar.next.i, 64
  br i1 %exitcond1, label %_vectorSum_.exit.loopexit, label %getData.exit

_vectorSum_.exit.loopexit:                        ; preds = %getData.exit
  br label %_vectorSum_.exit

_vectorSum_.exit:                                 ; preds = %_vectorSum_.exit, %_vectorSum_.exit.loopexit
  %idx.01.i4 = phi i32 [ %7, %_vectorSum_.exit ], [ 0, %_vectorSum_.exit.loopexit ]
  %scevgep.i5 = getelementptr [64 x float]* @C, i32 0, i32 %idx.01.i4
  %6 = load float* %scevgep.i5, align 4
  tail call void @write_float32(i8* getelementptr inbounds ([14 x i8]* @.str1, i32 0, i32 0), float %6) nounwind
  %7 = add nsw i32 %idx.01.i4, 1
  %exitcond = icmp eq i32 %7, 64
  br i1 %exitcond, label %sendResult.exit.loopexit, label %_vectorSum_.exit
}

define void @_vectorSum_() nounwind {
bb.nph:
  br label %0

; <label>:0                                       ; preds = %0, %bb.nph
  %indvar = phi i32 [ 0, %bb.nph ], [ %indvar.next, %0 ]
  %scevgep3 = getelementptr [64 x float]* @C, i32 0, i32 %indvar
  %scevgep2 = getelementptr [64 x float]* @B, i32 0, i32 %indvar
  %scevgep = getelementptr [64 x float]* @A, i32 0, i32 %indvar
  tail call void @loop_pipelining_on(i32 8) nounwind
  %1 = load float* %scevgep, align 4
  %2 = load float* %scevgep2, align 4
  %3 = fadd float %1, %2
  store float %3, float* %scevgep3, align 4
  %indvar.next = add i32 %indvar, 1
  %exitcond1 = icmp eq i32 %indvar.next, 64
  br i1 %exitcond1, label %._crit_edge, label %0

._crit_edge:                                      ; preds = %0
  ret void
}

declare void @loop_pipelining_on(i32)
