module @jit___call attributes {stream.resources = #stream.resource_config<{max_allocation_size = 4294967296, min_buffer_offset_alignment = 4096, max_buffer_range = 4294967296, min_buffer_range_alignment = 4096, index_bits = 32, alias_mutable_bindings = 1, memory_model = Unified}>} {
  util.global private @__device_0 : !hal.device
  util.initializer {
    %c18_i32 = arith.constant 18 : i32
    %false = arith.constant false
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0 = util.null : !hal.device
    %device_count = hal.devices.count : index
    cf.br ^bb1(%c0, %c0, %0 : index, index, !hal.device)
  ^bb1(%1: index, %2: index, %3: !hal.device):  // 2 preds: ^bb0, ^bb4
    %4 = util.cmp.eq %3, %0 : !hal.device
    %5 = arith.cmpi slt, %1, %device_count : index
    %6 = arith.andi %4, %5 : i1
    cf.cond_br %6, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    %device_n = hal.devices.get %1 : !hal.device
    %ok, %value = hal.device.query<%device_n : !hal.device> key("hal.device.id" :: "torq") : i1, i1 = false
    cf.cond_br %value, ^bb3, ^bb4(%false : i1)
  ^bb3:  // pred: ^bb2
    %ok_0, %value_1 = hal.device.query<%device_n : !hal.device> key("hal.executable.format" :: "torq-fb") : i1, i1 = false
    cf.br ^bb4(%value_1 : i1)
  ^bb4(%7: i1):  // 2 preds: ^bb2, ^bb3
    %8 = arith.cmpi eq, %2, %c0 : index
    %9 = arith.select %7, %c1, %c0 : index
    %10 = arith.addi %2, %9 : index
    %11 = arith.andi %7, %8 : i1
    %12 = arith.select %11, %device_n, %0 : !hal.device
    %13 = arith.addi %1, %c1 : index
    cf.br ^bb1(%13, %10, %12 : index, index, !hal.device)
  ^bb5:  // pred: ^bb1
    cf.cond_br %4, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    util.status.check_ok %c18_i32, "HAL device `__device_0` not found or unavailable: #hal.device.target<\22torq\22, [#hal.executable.target<\22torq\22, \22torq-fb\22>]>"
    cf.br ^bb7
  ^bb7:  // 2 preds: ^bb5, ^bb6
    util.global.store %3, @__device_0 : !hal.device
    util.return
  }
  util.global private @__device_0_query_0_hal_executable_format_torq_fb : i1
  util.initializer {
    %__device_0 = util.global.load @__device_0 : !hal.device
    %ok, %value = hal.device.query<%__device_0 : !hal.device> key("hal.executable.format" :: "torq-fb") : i1, i1 = false
    util.global.store %value, @__device_0_query_0_hal_executable_format_torq_fb : i1
    util.return
  }
  util.global private @__device_0_executable_0_main_dispatch_0 : !hal.executable
  util.initializer {
    %c-1_i64 = arith.constant -1 : i64
    %c-1 = arith.constant -1 : index
    %c0 = arith.constant 0 : index
    %c14_i32 = arith.constant 14 : i32
    %0 = util.null : !hal.executable
    %__device_0_query_0_hal_executable_format_torq_fb = util.global.load @__device_0_query_0_hal_executable_format_torq_fb : i1
    %__device_0 = util.global.load @__device_0 : !hal.device
    %1 = arith.select %__device_0_query_0_hal_executable_format_torq_fb, %c0, %c-1 : index
    %2 = arith.cmpi eq, %1, %c0 : index
    cf.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %executable = hal.executable.create device(%__device_0 : !hal.device) affinity(%c-1_i64) target(@main_dispatch_0::@torq_fb) : !hal.executable
    cf.br ^bb3(%executable : !hal.executable)
  ^bb2:  // pred: ^bb0
    util.status.check_ok %c14_i32, "HAL device `__device_0` does not support any variant of executable `main_dispatch_0`; available formats: [torq-fb]"
    cf.br ^bb3(%0 : !hal.executable)
  ^bb3(%3: !hal.executable):  // 2 preds: ^bb1, ^bb2
    util.global.store %3, @__device_0_executable_0_main_dispatch_0 : !hal.executable
    util.return
  }
  hal.executable private @main_dispatch_0 {
    hal.executable.binary public @torq_fb attributes {data = dense<"0x0C000000534E5055000000003EFAFFFF24000000500000003C0000009400000010000000080000000200000000000000000000001B0000006D61696E5F64697370617463685F305F656C656D656E7477697365000300000048000000300000001C000000050000009C0400005C0200003C0200002002000000010000BAFAFFFF020000000040900004000000D8FAFFFF01000000003090000400000001000000FAFAFFFF0020900004000000010000000500000090000000780000004C00000030000000040000004AFBFFFF080000000300000042FBFFFF04000000020000000B000000000000000C0000000000000072FBFFFF080000000200000064FBFFFF80020000010100008AFBFFFF080000000300000082FBFFFF040000000200000005000000000000000600000000000000B2FBFFFF0800000002000000B6FBFFFF01000000C6FBFFFF0800000001000000E6FBFFFF010000000C1410001800000010000000080000004800000000000000000000000000000018FCFFFF0C00100008010000040000000801000080000E100000004001000000000A00000000000000000101000000000100005101000001010000550200014515210000E10A000000A820080000000004001F10E8050004FFFFFFFF0F0000000000010000000000040000000000000000000000000000000406000200000000100600080000000000000000000000001C060044000000000200010000000000000000010000000000000000B064800400010000000000000000000000000080FFFFFF7F000006001F0100001F0100001F0100E0180500A301000000000000000200000008000000010000C038000000080500A10100008000000000100500A10100008000000000000500A20100000000000000010000C00000000034FDFFFF08001000020000000400000002000000010100004CFDFFFF00001000080000000400000008000000000000000100000068FDFFFF8C16100028020000040000002802000000010C10000004000000000002000000080500000200001008001000010000000000000000000000000000000000000000000000080003100100000004000000040000000400006000010C10000004000000000008000000100500000800001000001000010000000000000000000000000000000000000000000000080003100100000004000000040000000400006000010C10000004000000000004000000180500000400001000209000010000000000000000000000000000000000000000000000080003100100000004000000040000000400006000010C10000004000000000004000000200500000400001000309000010000000000000000000000000000000000000000000000080003100100000004000000040000000400006000010C100000040000000000BC00000000000000BC000010F817100001000000000000000000000000000000000000000000000008000310010000000400000004000000040000600000007000010C1000000400000000000801000028050000080100100C001000010000000000000000000000000000000000000000000000080003100100000004000000040000000400006000020110280500010800031001000000100000001000000000000060080003100100000000000000000000001000006030010B10000004000400000000050000040000100040900001000000000000000000000000000000000000000000000008000310010000000800000008000000080000E0A4FFFFFF0C14100048000000040000004800000000010C1000000400000000006C010000800200006C0100108C16100001000000000000000000000000000000000000000000000008000310010000000400000004000000040000E00A001000040008000C0014001C0004000000080000000C0010001400180008000900080004000C00050000000000000004000600080004000E000A00040000000000080009000E000D0000000400000008000C000E0011000400080000000C0010000C0010000400080000000C0012002000040008000C001000140018001C00"> : vector<1504xi8>, format = "torq-fb", mime_type = "application/x-flatbuffers"}
  }
  util.func private @__main_memoize_apply() -> !hal.command_buffer attributes {inlining_policy = #util.inline.never} {
    %c-1_i64 = arith.constant -1 : i64
    %c3 = arith.constant 3 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c4 = arith.constant 4 : index
    %__device_0 = util.global.load immutable @__device_0 : !hal.device
    %__device_0_executable_0_main_dispatch_0 = util.global.load immutable @__device_0_executable_0_main_dispatch_0 : !hal.executable
    %cmd = hal.command_buffer.create device(%__device_0 : !hal.device) mode("None") categories("Transfer|Dispatch") affinity(%c-1_i64) bindings(%c3) : !hal.command_buffer
    hal.command_buffer.dispatch<%cmd : !hal.command_buffer> target(%__device_0_executable_0_main_dispatch_0 : !hal.executable)[%c0] workgroups([%c1, %c1, %c1]) bindings([
      (%c0 : index)[%c0, %c4], 
      (%c1 : index)[%c0, %c4], 
      (%c2 : index)[%c0, %c4]
    ]) flags("None")
    hal.command_buffer.execution_barrier<%cmd : !hal.command_buffer> source("Dispatch|Transfer|CommandRetire") target("CommandIssue|Dispatch|Transfer") flags("None")
    hal.command_buffer.finalize<%cmd : !hal.command_buffer>
    util.return %cmd : !hal.command_buffer
  }
  util.global private @__main_memoize_result_0_device_0 : !hal.command_buffer
  util.initializer {
    %0 = util.call @__main_memoize_apply() : () -> !hal.command_buffer
    util.global.store %0, @__main_memoize_result_0_device_0 : !hal.command_buffer
    util.return
  }
  util.func public @main(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @main(%input0: tensor<i32>, %input1: tensor<i32>) -> (%output0: tensor<i32>)"}} {
    %c-1_i32 = arith.constant -1 : i32
    %c0_i64 = arith.constant 0 : i64
    %0 = util.null : !hal.fence
    %c-1_i64 = arith.constant -1 : i64
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %memory_type = hal.memory_type<"DeviceVisible|DeviceLocal"> : i32
    %buffer_usage = hal.buffer_usage<"TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage"> : i32
    %__device_0 = util.global.load immutable @__device_0 : !hal.device
    %__main_memoize_result_0_device_0 = util.global.load immutable @__main_memoize_result_0_device_0 : !hal.command_buffer
    %element_type_i32 = hal.element_type<i32> : i32
    %dense_row_major = hal.encoding_type<dense_row_major> : i32
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input0") shape([]) type(%element_type_i32) encoding(%dense_row_major)
    %buffer = hal.buffer_view.buffer<%arg0 : !hal.buffer_view> : !hal.buffer
    %allocator = hal.device.allocator<%__device_0 : !hal.device> : !hal.allocator
    hal.buffer.assert<%buffer : !hal.buffer> message("tensor") allocator(%allocator : !hal.allocator) minimum_length(%c4) type(DeviceVisible) usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage")
    hal.buffer_view.assert<%arg1 : !hal.buffer_view> message("input1") shape([]) type(%element_type_i32) encoding(%dense_row_major)
    %buffer_0 = hal.buffer_view.buffer<%arg1 : !hal.buffer_view> : !hal.buffer
    hal.buffer.assert<%buffer_0 : !hal.buffer> message("tensor") allocator(%allocator : !hal.allocator) minimum_length(%c4) type(DeviceVisible) usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage")
    %fence = hal.fence.create device(%__device_0 : !hal.device) flags("None") : !hal.fence
    %transient_buffer = hal.device.queue.alloca<%__device_0 : !hal.device> affinity(%c-1_i64) wait(%0) signal(%fence) pool(%c0_i64) type(%memory_type) usage(%buffer_usage) flags("None") : !hal.buffer{%c4}
    %fence_1 = hal.fence.create device(%__device_0 : !hal.device) flags("None") : !hal.fence
    hal.device.queue.execute.indirect<%__device_0 : !hal.device> affinity(%c-1_i64) wait(%fence) signal(%fence_1) commands(%__main_memoize_result_0_device_0) bindings([
      (%buffer_0 : !hal.buffer)[%c0, %c4], 
      (%buffer : !hal.buffer)[%c0, %c4], 
      (%transient_buffer : !hal.buffer)[%c0, %c4]
    ]) flags("None")
    %status = hal.fence.await until([%fence_1]) timeout_millis(%c-1_i32) flags("None") : i32
    util.status.check_ok %status, "failed to wait on timepoint"
    %view = hal.buffer_view.create buffer(%transient_buffer : !hal.buffer)[%c0, %c4] shape([]) type(%element_type_i32) encoding(%dense_row_major) : !hal.buffer_view
    util.return %view : !hal.buffer_view
  }
}
