module @jit___call attributes {stream.resources = #stream.resource_config<{max_allocation_size = 4294967296, min_buffer_offset_alignment = 4096, max_buffer_range = 4294967296, min_buffer_range_alignment = 4096, index_bits = 32, alias_mutable_bindings = 1, memory_model = Unified}>, vm.toplevel} {
  vm.module public @jit___call {
    vm.global.ref private mutable @__device_0 : !vm.ref<!hal.device>
    vm.global.ref private mutable @__device_0_executable_0_main_dispatch_0 : !vm.ref<!hal.executable>
    vm.global.ref private mutable @__main_memoize_result_0_device_0 : !vm.ref<!hal.command_buffer>
    vm.rodata private @_utf8_hal_device_id_C6650FF277232B5A {alignment = 1 : i64} "hal.device.id"
    vm.rodata private @_utf8_torq_CA9D0E4109F294D6 {alignment = 1 : i64} "torq"
    vm.rodata private @_utf8_hal_executable_format_E03EECB63A2AAF52 {alignment = 1 : i64} "hal.executable.format"
    vm.rodata private @_utf8_torq_fb_91DD22BC77C173EE {alignment = 1 : i64} "torq-fb"
    vm.rodata private @main_dispatch_0_torq_fb {alignment = 16 : i64, mime_type = "application/x-flatbuffers"} dense<"0x0C000000534E5055000000003EFAFFFF24000000500000003C0000009400000010000000080000000200000000000000000000001B0000006D61696E5F64697370617463685F305F656C656D656E7477697365000300000048000000300000001C000000050000009C0400005C0200003C0200002002000000010000BAFAFFFF020000000040900004000000D8FAFFFF01000000003090000400000001000000FAFAFFFF0020900004000000010000000500000090000000780000004C00000030000000040000004AFBFFFF080000000300000042FBFFFF04000000020000000B000000000000000C0000000000000072FBFFFF080000000200000064FBFFFF80020000010100008AFBFFFF080000000300000082FBFFFF040000000200000005000000000000000600000000000000B2FBFFFF0800000002000000B6FBFFFF01000000C6FBFFFF0800000001000000E6FBFFFF010000000C1410001800000010000000080000004800000000000000000000000000000018FCFFFF0C00100008010000040000000801000080000E100000004001000000000A00000000000000000101000000000100005101000001010000550200014515210000E10A000000A820080000000004001F10E8050004FFFFFFFF0F0000000000010000000000040000000000000000000000000000000406000200000000100600080000000000000000000000001C060044000000000200010000000000000000010000000000000000B064800400010000000000000000000000000080FFFFFF7F000006001F0100001F0100001F0100E0180500A301000000000000000200000008000000010000C038000000080500A10100008000000000100500A10100008000000000000500A20100000000000000010000C00000000034FDFFFF08001000020000000400000002000000010100004CFDFFFF00001000080000000400000008000000000000000100000068FDFFFF8C16100028020000040000002802000000010C10000004000000000002000000080500000200001008001000010000000000000000000000000000000000000000000000080003100100000004000000040000000400006000010C10000004000000000008000000100500000800001000001000010000000000000000000000000000000000000000000000080003100100000004000000040000000400006000010C10000004000000000004000000180500000400001000209000010000000000000000000000000000000000000000000000080003100100000004000000040000000400006000010C10000004000000000004000000200500000400001000309000010000000000000000000000000000000000000000000000080003100100000004000000040000000400006000010C100000040000000000BC00000000000000BC000010F817100001000000000000000000000000000000000000000000000008000310010000000400000004000000040000600000007000010C1000000400000000000801000028050000080100100C001000010000000000000000000000000000000000000000000000080003100100000004000000040000000400006000020110280500010800031001000000100000001000000000000060080003100100000000000000000000001000006030010B10000004000400000000050000040000100040900001000000000000000000000000000000000000000000000008000310010000000800000008000000080000E0A4FFFFFF0C14100048000000040000004800000000010C1000000400000000006C010000800200006C0100108C16100001000000000000000000000000000000000000000000000008000310010000000400000004000000040000E00A001000040008000C0014001C0004000000080000000C0010001400180008000900080004000C00050000000000000004000600080004000E000A00040000000000080009000E000D0000000400000008000C000E0011000400080000000C0010000C0010000400080000000C0012002000040008000C001000140018001C00"> : vector<1504xi8>
    vm.func private @__main_memoize_apply() -> !vm.ref<!hal.command_buffer> attributes {inlining_policy = #util.inline.never} {
      %c13 = vm.const.i32 13
      %c28 = vm.const.i32 28
      %c2 = vm.const.i32 2
      %null = vm.const.ref.zero : !vm.ref<!hal.buffer>
      %c1 = vm.const.i32 1
      %c3 = vm.const.i32 3
      %zero = vm.const.i32.zero
      %c4 = vm.const.i64 4
      %zero_0 = vm.const.i64.zero
      %c-1 = vm.const.i64 -1
      %__device_0 = vm.global.load.ref @__device_0 : !vm.ref<!hal.device>
      %__device_0_executable_0_main_dispatch_0 = vm.global.load.ref @__device_0_executable_0_main_dispatch_0 : !vm.ref<!hal.executable>
      %ref = vm.call @hal.command_buffer.create(%__device_0, %zero, %c3, %c-1, %c3) : (!vm.ref<!hal.device>, i32, i32, i64, i32) -> !vm.ref<!hal.command_buffer>
      vm.call.variadic @hal.command_buffer.dispatch(%ref, %__device_0_executable_0_main_dispatch_0, %zero, %c1, %c1, %c1, %zero_0, [], [(%zero, %zero, %null, %zero_0, %c4), (%zero, %c1, %null, %zero_0, %c4), (%zero, %c2, %null, %zero_0, %c4)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32, i64, i32 ..., tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
      vm.call @hal.command_buffer.execution_barrier(%ref, %c28, %c13, %zero_0) : (!vm.ref<!hal.command_buffer>, i32, i32, i64) -> ()
      vm.call @hal.command_buffer.finalize(%ref) : (!vm.ref<!hal.command_buffer>) -> ()
      vm.return %ref : !vm.ref<!hal.command_buffer>
    }
    vm.import private @hal.buffer.assert(%buffer : !vm.ref<!hal.buffer>, %message : !vm.buffer, %allocator : !vm.ref<!hal.allocator>, %minimum_length : i64, %memory_types : i32, %buffer_usage : i32)
    vm.import private @hal.buffer_view.create(%buffer : !vm.ref<!hal.buffer>, %source_offset : i64, %source_length : i64, %element_type : i32, %encoding_type : i32, %shape : i64 ...) -> !vm.ref<!hal.buffer_view> attributes {nosideeffects}
    vm.import private @hal.buffer_view.assert(%buffer_view : !vm.ref<!hal.buffer_view>, %message : !vm.buffer, %element_type : i32, %encoding_type : i32, %shape : i64 ...)
    vm.import private @hal.buffer_view.buffer(%buffer_view : !vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer> attributes {nosideeffects}
    vm.import private @hal.command_buffer.create(%device : !vm.ref<!hal.device>, %modes : i32, %command_categories : i32, %queue_affinity : i64, %binding_capacity : i32) -> !vm.ref<!hal.command_buffer> attributes {minimum_version = 6 : i32}
    vm.import private @hal.command_buffer.finalize(%command_buffer : !vm.ref<!hal.command_buffer>)
    vm.import private @hal.command_buffer.execution_barrier(%command_buffer : !vm.ref<!hal.command_buffer>, %source_stage_mask : i32, %target_stage_mask : i32, %flags : i64)
    vm.import private @hal.command_buffer.dispatch(%command_buffer : !vm.ref<!hal.command_buffer>, %executable : !vm.ref<!hal.executable>, %entry_point : i32, %workgroup_x : i32, %workgroup_y : i32, %workgroup_z : i32, %flags : i64, %constants : i32 ..., %bindings : tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
    vm.import private @hal.device.allocator(%device : !vm.ref<!hal.device>) -> !vm.ref<!hal.allocator> attributes {nosideeffects}
    vm.import private @hal.device.query.i64(%device : !vm.ref<!hal.device>, %category : !vm.buffer, %key : !vm.buffer) -> (i32, i64) attributes {nosideeffects}
    vm.import private @hal.device.queue.alloca(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %wait_fence : !vm.ref<!hal.fence>, %signal_fence : !vm.ref<!hal.fence>, %pool : i64, %memory_types : i32, %buffer_usage : i32, %allocation_size : i64, %flags : i64) -> !vm.ref<!hal.buffer>
    vm.import private @hal.device.queue.execute.indirect(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %wait_fence : !vm.ref<!hal.fence>, %signal_fence : !vm.ref<!hal.fence>, %command_buffer : !vm.ref<!hal.command_buffer>, %flags : i64, %binding_table : tuple<!vm.ref<!hal.buffer>, i64, i64> ...)
    vm.import private @hal.devices.count() -> i32 attributes {nosideeffects}
    vm.import private @hal.devices.get(%index : i32) -> !vm.ref<!hal.device> attributes {nosideeffects}
    vm.import private @hal.executable.create(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %executable_format : !vm.buffer, %executable_data : !vm.buffer, %constants : !vm.buffer) -> !vm.ref<!hal.executable> attributes {nosideeffects}
    vm.import private @hal.fence.create(%device : !vm.ref<!hal.device>, %flags : i64) -> !vm.ref<!hal.fence>
    vm.import private @hal.fence.await(%timeout_millis : i32, %flags : i64, %fences : !vm.ref<!hal.fence> ...) -> i32 attributes {vm.yield}
    vm.rodata private @_utf8_input0_DCE99660CEB3F6B {alignment = 1 : i64} "input0"
    vm.rodata private @_utf8_tensor_FC1814BC4A58F22A {alignment = 1 : i64} "tensor"
    vm.rodata private @_utf8_input1_B898B726583C85DA {alignment = 1 : i64} "input1"
    vm.func private @main(%arg0: !vm.ref<!hal.buffer_view>, %arg1: !vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer_view> attributes {iree.reflection = {iree.abi.declaration = "sync func @main(%input0: tensor<i32>, %input1: tensor<i32>) -> (%output0: tensor<i32>)"}} {
      %c16 = vm.const.i32 16
      %c1 = vm.const.i32 1
      %c268435488 = vm.const.i32 268435488
      %c3075 = vm.const.i32 3075
      %c48 = vm.const.i32 48
      %c4 = vm.const.i64 4
      %zero = vm.const.i64.zero
      %c-1 = vm.const.i64 -1
      %null = vm.const.ref.zero : !vm.ref<!hal.fence>
      %c-1_0 = vm.const.i32 -1
      %__device_0 = vm.global.load.ref @__device_0 : !vm.ref<!hal.device>
      %__main_memoize_result_0_device_0 = vm.global.load.ref @__main_memoize_result_0_device_0 : !vm.ref<!hal.command_buffer>
      %_utf8_input0_DCE99660CEB3F6B = vm.const.ref.rodata @_utf8_input0_DCE99660CEB3F6B : !vm.buffer
      vm.call.variadic @hal.buffer_view.assert(%arg0, %_utf8_input0_DCE99660CEB3F6B, %c268435488, %c1, []) : (!vm.ref<!hal.buffer_view>, !vm.buffer, i32, i32, i64 ...)
      %ref = vm.call @hal.buffer_view.buffer(%arg0) {nosideeffects} : (!vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer>
      %ref_1 = vm.call @hal.device.allocator(%__device_0) {nosideeffects} : (!vm.ref<!hal.device>) -> !vm.ref<!hal.allocator>
      %_utf8_tensor_FC1814BC4A58F22A = vm.const.ref.rodata @_utf8_tensor_FC1814BC4A58F22A : !vm.buffer
      vm.call @hal.buffer.assert(%ref, %_utf8_tensor_FC1814BC4A58F22A, %ref_1, %c4, %c16, %c3075) : (!vm.ref<!hal.buffer>, !vm.buffer, !vm.ref<!hal.allocator>, i64, i32, i32) -> ()
      %_utf8_input1_B898B726583C85DA = vm.const.ref.rodata @_utf8_input1_B898B726583C85DA : !vm.buffer
      vm.call.variadic @hal.buffer_view.assert(%arg1, %_utf8_input1_B898B726583C85DA, %c268435488, %c1, []) : (!vm.ref<!hal.buffer_view>, !vm.buffer, i32, i32, i64 ...)
      %ref_2 = vm.call @hal.buffer_view.buffer(%arg1) {nosideeffects} : (!vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer>
      vm.call @hal.buffer.assert(%ref_2, %_utf8_tensor_FC1814BC4A58F22A, %ref_1, %c4, %c16, %c3075) : (!vm.ref<!hal.buffer>, !vm.buffer, !vm.ref<!hal.allocator>, i64, i32, i32) -> ()
      %ref_3 = vm.call @hal.fence.create(%__device_0, %zero) : (!vm.ref<!hal.device>, i64) -> !vm.ref<!hal.fence>
      %ref_4 = vm.call @hal.device.queue.alloca(%__device_0, %c-1, %null, %ref_3, %zero, %c48, %c3075, %c4, %zero) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, i64, i32, i32, i64, i64) -> !vm.ref<!hal.buffer>
      %ref_5 = vm.call @hal.fence.create(%__device_0, %zero) : (!vm.ref<!hal.device>, i64) -> !vm.ref<!hal.fence>
      vm.call.variadic @hal.device.queue.execute.indirect(%__device_0, %c-1, %ref_3, %ref_5, %__main_memoize_result_0_device_0, %zero, [(%ref_2, %zero, %c4), (%ref, %zero, %c4), (%ref_4, %zero, %c4)]) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, !vm.ref<!hal.command_buffer>, i64, tuple<!vm.ref<!hal.buffer>, i64, i64> ...)
      %0 = vm.call.variadic @hal.fence.await(%c-1_0, %zero, [%ref_5]) : (i32, i64, !vm.ref<!hal.fence> ...) -> i32
      vm.cond_br %0, ^bb2, ^bb1
    ^bb1:  // pred: ^bb0
      %ref_6 = vm.call.variadic @hal.buffer_view.create(%ref_4, %zero, %c4, %c268435488, %c1, []) {nosideeffects} : (!vm.ref<!hal.buffer>, i64, i64, i32, i32, i64 ...) -> !vm.ref<!hal.buffer_view>
      vm.return %ref_6 : !vm.ref<!hal.buffer_view>
    ^bb2:  // pred: ^bb0
      vm.fail %0, "failed to wait on timepoint"
    }
    vm.export @main attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @main(%input0: tensor<i32>, %input1: tensor<i32>) -> (%output0: tensor<i32>)"}}
    vm.export @__init
    vm.func private @__init() {
      %c1 = vm.const.i32 1
      %null = vm.const.ref.zero : !vm.buffer
      %c14 = vm.const.i32 14
      %c-1 = vm.const.i64 -1
      %c18 = vm.const.i32 18
      %zero = vm.const.i32.zero
      %zero_0 = vm.const.i64.zero
      %c1_1 = vm.const.i64 1
      %null_2 = vm.const.ref.zero : !vm.ref<!hal.device>
      %0 = vm.call @hal.devices.count() {nosideeffects} : () -> i32
      %1 = vm.ext.i32.i64.s %0 : i32 -> i64
      vm.br ^bb1(%zero_0, %zero_0, %null_2 : i64, i64, !vm.ref<!hal.device>)
    ^bb1(%2: i64, %3: i64, %4: !vm.ref<!hal.device>):  // 2 preds: ^bb0, ^bb4
      %rnz = vm.cmp.nz.ref %4 : !vm.ref<!hal.device>
      %5 = vm.xor.i32 %rnz, %c1 : i32
      %slt = vm.cmp.lt.i64.s %2, %1 : i64
      %6 = vm.and.i32 %5, %slt : i32
      vm.cond_br %6, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %7 = vm.trunc.i64.i32 %2 : i64 -> i32
      %ref = vm.call @hal.devices.get(%7) {nosideeffects} : (i32) -> !vm.ref<!hal.device>
      %_utf8_hal_device_id_C6650FF277232B5A = vm.const.ref.rodata @_utf8_hal_device_id_C6650FF277232B5A : !vm.buffer
      %_utf8_torq_CA9D0E4109F294D6 = vm.const.ref.rodata @_utf8_torq_CA9D0E4109F294D6 : !vm.buffer
      %8:2 = vm.call @hal.device.query.i64(%ref, %_utf8_hal_device_id_C6650FF277232B5A, %_utf8_torq_CA9D0E4109F294D6) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer) -> (i32, i64)
      %nz = vm.cmp.nz.i64 %8#1 : i64
      %9 = vm.select.i32 %8#0, %nz, %zero : i32
      vm.cond_br %9, ^bb3, ^bb4(%zero : i32)
    ^bb3:  // pred: ^bb2
      %_utf8_hal_executable_format_E03EECB63A2AAF52 = vm.const.ref.rodata @_utf8_hal_executable_format_E03EECB63A2AAF52 : !vm.buffer
      %_utf8_torq_fb_91DD22BC77C173EE = vm.const.ref.rodata @_utf8_torq_fb_91DD22BC77C173EE : !vm.buffer
      %10:2 = vm.call @hal.device.query.i64(%ref, %_utf8_hal_executable_format_E03EECB63A2AAF52, %_utf8_torq_fb_91DD22BC77C173EE) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer) -> (i32, i64)
      %nz_3 = vm.cmp.nz.i64 %10#1 : i64
      %11 = vm.select.i32 %10#0, %nz_3, %zero : i32
      vm.br ^bb4(%11 : i32)
    ^bb4(%12: i32):  // 2 preds: ^bb2, ^bb3
      %eq = vm.cmp.eq.i64 %3, %zero_0 : i64
      %13 = vm.select.i64 %12, %c1_1, %zero_0 : i64
      %14 = vm.add.i64 %3, %13 : i64
      %15 = vm.and.i32 %12, %eq : i32
      %ref_4 = vm.select.ref %15, %ref, %null_2 : !vm.ref<!hal.device>
      %16 = vm.add.i64 %2, %c1_1 : i64
      vm.br ^bb1(%16, %14, %ref_4 : i64, i64, !vm.ref<!hal.device>)
    ^bb5:  // pred: ^bb1
      vm.cond_br %5, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      vm.fail %c18, "HAL device `__device_0` not found or unavailable: #hal.device.target<\22torq\22, [#hal.executable.target<\22torq\22, \22torq-fb\22>]>"
    ^bb7:  // pred: ^bb5
      %_utf8_hal_executable_format_E03EECB63A2AAF52_5 = vm.const.ref.rodata @_utf8_hal_executable_format_E03EECB63A2AAF52 : !vm.buffer
      %_utf8_torq_fb_91DD22BC77C173EE_6 = vm.const.ref.rodata @_utf8_torq_fb_91DD22BC77C173EE : !vm.buffer
      %17:2 = vm.call @hal.device.query.i64(%4, %_utf8_hal_executable_format_E03EECB63A2AAF52_5, %_utf8_torq_fb_91DD22BC77C173EE_6) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer) -> (i32, i64)
      %nz_7 = vm.cmp.nz.i64 %17#1 : i64
      %18 = vm.select.i32 %17#0, %nz_7, %zero : i32
      %19 = vm.select.i64 %18, %zero_0, %c-1 : i64
      %eq_8 = vm.cmp.eq.i64 %19, %zero_0 : i64
      vm.global.store.ref %4, @__device_0 : !vm.ref<!hal.device>
      vm.cond_br %eq_8, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %main_dispatch_0_torq_fb = vm.const.ref.rodata @main_dispatch_0_torq_fb : !vm.buffer
      %ref_9 = vm.call @hal.executable.create(%4, %c-1, %_utf8_torq_fb_91DD22BC77C173EE_6, %main_dispatch_0_torq_fb, %null) {nosideeffects} : (!vm.ref<!hal.device>, i64, !vm.buffer, !vm.buffer, !vm.buffer) -> !vm.ref<!hal.executable>
      vm.global.store.ref %ref_9, @__device_0_executable_0_main_dispatch_0 : !vm.ref<!hal.executable>
      %ref_10 = vm.call @__main_memoize_apply() : () -> !vm.ref<!hal.command_buffer>
      vm.global.store.ref %ref_10, @__main_memoize_result_0_device_0 : !vm.ref<!hal.command_buffer>
      vm.return
    ^bb9:  // pred: ^bb7
      vm.fail %c14, "HAL device `__device_0` does not support any variant of executable `main_dispatch_0`; available formats: [torq-fb]"
    }
  }
}
