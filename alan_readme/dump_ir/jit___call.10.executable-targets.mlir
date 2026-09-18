#executable_target_torq_fb = #hal.executable.target<"torq", "torq-fb">
#map = affine_map<() -> (1)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (4)>
#map3 = affine_map<(d0, d1) -> (d1 - d0)>
#map4 = affine_map<() -> (64)>
#map5 = affine_map<() -> (2)>
#pipeline_layout = #hal.pipeline.layout<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>
#device_target_torq = #hal.device.target<"torq", [#executable_target_torq_fb]> : !hal.device
module @jit___call attributes {stream.affinity.default = #hal.device.affinity<@__device_0>, stream.resources = #stream.resource_config<{max_allocation_size = 4294967296, min_buffer_offset_alignment = 4096, max_buffer_range = 4294967296, min_buffer_range_alignment = 4096, index_bits = 32, alias_mutable_bindings = 1, memory_model = Unified}>} {
  util.global private @__device_0 = #device_target_torq
  hal.executable private @main_dispatch_0 {
    hal.executable.variant public @torq_fb target(#executable_target_torq_fb) {
      hal.executable.export public @main_dispatch_0_elementwise ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %c1 = arith.constant 1 : index
        %c1_0 = arith.constant 1 : index
        %c1_1 = arith.constant 1 : index
        hal.return %c1, %c1_0, %c1_1 : index, index, index
      }
      builtin.module {
        memref.global "private" @__program_slot0 : memref<640xi8, #torq_hl<enc mem_space = lram>> = uninitialized {lram_address = 0 : i64}
        memref.global "private" @__program_slot1 : memref<640xi8, #torq_hl<enc mem_space = lram>> = uninitialized {lram_address = 640 : i64}
        memref.global "private" @__intermediate_0 : memref<i32, #torq_hl<enc mem_space = lram>> = uninitialized {lram_address = 1280 : i64}
        memref.global "private" @__intermediate_1 : memref<2xi8, #torq_hl<enc mem_space = lram>> = uninitialized {lram_address = 1288 : i64}
        memref.global "private" @__intermediate_2 : memref<2xi32, #torq_hl<enc mem_space = lram>> = uninitialized {lram_address = 1296 : i64}
        memref.global "private" @__intermediate_3 : memref<i32, #torq_hl<enc mem_space = lram>> = uninitialized {lram_address = 1304 : i64}
        memref.global "private" @__intermediate_4 : memref<i32, #torq_hl<enc mem_space = lram>> = uninitialized {lram_address = 1312 : i64}
        memref.global "private" @__intermediate_5 : memref<5120xi8, #torq_hl<enc mem_space = lram>> = uninitialized {lram_address = 1320 : i64}
        memref.global "private" constant @__const_global_0 : memref<2xi32> = dense<[0, 1]> {xram_address = 1048576 : i64}
        memref.global "private" constant @__const_global_1 : memref<2xi8> = dense<1> {xram_address = 1048584 : i64}
        memref.global "private" constant @__const_descriptor_slice_program_torq_hl.add_0_0_1 : memref<264xi8> = dense<"0x80000E100000004001000000000A00000000000000000101000000000100005101000001010000550200014515210000E10A000000A820080000000004001F10E8050004FFFFFFFF0F0000000000010000000000040000000000000000000000000000000406000200000000100600080000000000000000000000001C060044000000000200010000000000000000010000000000000000B064800400010000000000000000000000000080FFFFFF7F000006001F0100001F0100001F0100E0180500A301000000000000000200000008000000010000C038000000080500A10100008000000000100500A10100008000000000000500A20100000000000000010000C000000000"> {xram_address = 1048588 : i64}
        func.func @main_dispatch_0_elementwise() attributes {"torq-next-free-xram-address" = 9457664 : i64, "torq-nss-program-base" = 1053708 : i64} {
          %0 = memref.get_global @__program_slot0 : memref<640xi8, #torq_hl<enc mem_space = lram>> {"torq-buffer-ids" = array<i64: 0>}
          %1 = memref.get_global @__program_slot1 : memref<640xi8, #torq_hl<enc mem_space = lram>> {"torq-buffer-ids" = array<i64: 1>}
          %2 = torq_hl.program "nss_program_0" {block_sizes = array<i32: 72>} : !torq_hl.program<nss> {
          ^bb0(%arg0: memref<640xi8, #torq_hl<enc mem_space = lram>>, %arg1: memref<640xi8, #torq_hl<enc mem_space = lram>>, %arg2: !torq_hl.invocation<nss>, %arg3: !torq_hl.invocation<nss>):
            %11 = torq_hl.get_block %arg3 block 0 : !torq_hl.invocation<nss> -> memref<364xi8>
            %subview_4 = memref.subview %arg1[0] [364] [1] : memref<640xi8, #torq_hl<enc mem_space = lram>> to memref<364xi8, strided<[1]>, #torq_hl<enc mem_space = lram>>
            torq_hw.nss_task {"torq-task-id" = 0 : i64}() {
              torq_hw.dma_in_cfg from %11 : memref<364xi8> to %subview_4 : memref<364xi8, strided<[1]>, #torq_hl<enc mem_space = lram>> {read_address = 1054348 : i32, read_ndl = #torq_hw<dma_ndl{dims = [[364, 1]]}>, write_address = 640 : i32, write_ndl = #torq_hw<dma_ndl{dims = [[364, 1]]}>}
              torq_hw.dma_in_start
              torq_hw.dma_in_wait
            }
            torq_hl.return %arg1, %arg0 : memref<640xi8, #torq_hl<enc mem_space = lram>>, memref<640xi8, #torq_hl<enc mem_space = lram>>
          }
          %invocation, %code_sections = torq_hl.descriptor "nss_program_0" on 0 program %2 : <nss> code [array<i8: 0, 1, 12, 16, 0, 0, 4, 0, 0, 0, 0, 0, 108, 1, 0, 0, -128, 2, 0, 0, 108, 1, 0, 16, -116, 22, 16, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 3, 16, 1, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, -32>] {executor_code_addresses = array<i64: 0>, "torq-job-id" = 0 : i32, xram_code_addresses = array<i64: 1053708>} : !torq_hl.invocation<nss>, memref<72xi8>
          %3 = torq_hl.get_block %invocation block 0 : !torq_hl.invocation<nss> -> memref<72xi8>
          %subview = memref.subview %0[0] [72] [1] {lram_address = 0 : i64} : memref<640xi8, #torq_hl<enc mem_space = lram>> to memref<72xi8, strided<[1]>, #torq_hl<enc mem_space = lram>>
          torq_hl.host_copy %3 : memref<72xi8> to %subview : memref<72xi8, strided<[1]>, #torq_hl<enc mem_space = lram>> {element_size_bytes = 72 : i64, input_strides_bytes = array<i64>, output_strides_bytes = array<i64>, shape = array<i64>, "torq-action-id" = 0 : i32}
          %4 = torq_hl.program "nss_program_1" {block_sizes = array<i32: 364, 188>} : !torq_hl.program<nss> {
          ^bb0(%arg0: memref<640xi8, #torq_hl<enc mem_space = lram>>, %arg1: memref<640xi8, #torq_hl<enc mem_space = lram>>, %arg2: !torq_hl.invocation<nss>, %arg3: memref<i32>, %arg4: memref<i32>, %arg5: !torq_hl.invocation<slice>, %arg6: memref<i32>):
            %11 = memref.get_global @__intermediate_1 : memref<2xi8, #torq_hl<enc mem_space = lram>>
            %12 = memref.get_global @__const_global_1 : memref<2xi8>
            %13 = memref.get_global @__intermediate_2 : memref<2xi32, #torq_hl<enc mem_space = lram>>
            %14 = memref.get_global @__const_global_0 : memref<2xi32>
            %15 = memref.get_global @__intermediate_3 : memref<i32, #torq_hl<enc mem_space = lram>>
            %16 = memref.get_global @__intermediate_4 : memref<i32, #torq_hl<enc mem_space = lram>>
            %17 = memref.get_global @__const_descriptor_slice_program_torq_hl.add_0_0_1 : memref<264xi8>
            %18 = memref.get_global @__intermediate_5 : memref<5120xi8, #torq_hl<enc mem_space = lram>>
            %19 = memref.get_global @__intermediate_0 : memref<i32, #torq_hl<enc mem_space = lram>>
            %subview_4 = memref.subview %18[0] [264] [1] {lram_address = 1320 : i64} : memref<5120xi8, #torq_hl<enc mem_space = lram>> to memref<264xi8, strided<[1]>, #torq_hl<enc mem_space = lram>>
            torq_hw.nss_task {"torq-task-id" = 1 : i64}() {
              torq_hw.dma_in_cfg from %12 : memref<2xi8> to %11 : memref<2xi8, #torq_hl<enc mem_space = lram>> {read_address = 1048584 : i32, read_ndl = #torq_hw<dma_ndl{dims = [[2, 1]]}>, write_address = 1288 : i32, write_ndl = #torq_hw<dma_ndl{dims = [[2, 1]]}>}
              torq_hw.dma_in_start
              torq_hw.dma_in_wait
            }
            torq_hw.nss_task {"torq-task-id" = 2 : i64}() {
              torq_hw.dma_in_cfg from %14 : memref<2xi32> to %13 : memref<2xi32, #torq_hl<enc mem_space = lram>> {read_address = 1048576 : i32, read_ndl = #torq_hw<dma_ndl{dims = [[8, 1]]}>, write_address = 1296 : i32, write_ndl = #torq_hw<dma_ndl{dims = [[8, 1]]}>}
              torq_hw.dma_in_start
              torq_hw.dma_in_wait
            }
            torq_hw.nss_task {"torq-task-id" = 3 : i64}() {
              torq_hw.dma_in_cfg from %arg3 : memref<i32> to %15 : memref<i32, #torq_hl<enc mem_space = lram>> {read_address = 9445376 : i32, read_ndl = #torq_hw<dma_ndl{dims = [[4, 1]]}>, write_address = 1304 : i32, write_ndl = #torq_hw<dma_ndl{dims = [[4, 1]]}>}
              torq_hw.dma_in_start
              torq_hw.dma_in_wait
            }
            torq_hw.nss_task {"torq-task-id" = 4 : i64}() {
              torq_hw.dma_in_cfg from %arg4 : memref<i32> to %16 : memref<i32, #torq_hl<enc mem_space = lram>> {read_address = 9449472 : i32, read_ndl = #torq_hw<dma_ndl{dims = [[4, 1]]}>, write_address = 1312 : i32, write_ndl = #torq_hw<dma_ndl{dims = [[4, 1]]}>}
              torq_hw.dma_in_start
              torq_hw.dma_in_wait
            }
            %20 = torq_hl.get_block %arg2 block 1 : !torq_hl.invocation<nss> -> memref<188xi8>
            %subview_5 = memref.subview %arg1[0] [188] [1] : memref<640xi8, #torq_hl<enc mem_space = lram>> to memref<188xi8, strided<[1]>, #torq_hl<enc mem_space = lram>>
            torq_hw.nss_task {"torq-task-id" = 5 : i64}() {
              torq_hw.dma_in_cfg from %20 : memref<188xi8> to %subview_5 : memref<188xi8, strided<[1]>, #torq_hl<enc mem_space = lram>> {read_address = 1054712 : i32, read_ndl = #torq_hw<dma_ndl{dims = [[188, 1]]}>, write_address = 0 : i32, write_ndl = #torq_hw<dma_ndl{dims = [[188, 1]]}>}
              torq_hw.dma_in_start
              torq_hw.dma_in_wait
            }
            torq_hl.next lram_area(%arg1 : memref<640xi8, #torq_hl<enc mem_space = lram>>) to ^bb1 {lramAddress = 0 : i64}
          ^bb1:  // pred: ^bb0
            torq_hw.nss_task {"torq-task-id" = 6 : i64}() {
              torq_hw.dma_in_cfg from %17 : memref<264xi8> to %subview_4 : memref<264xi8, strided<[1]>, #torq_hl<enc mem_space = lram>> {read_address = 1048588 : i32, read_ndl = #torq_hw<dma_ndl{dims = [[264, 1]]}>, write_address = 1320 : i32, write_ndl = #torq_hw<dma_ndl{dims = [[264, 1]]}>}
              torq_hw.dma_in_start
              torq_hw.dma_in_wait
            }
            torq_hw.nss_task {"torq-task-id" = 7 : i64}() {
              "torq_hw.slice_start"(%arg5, %18, %19, %11, %13, %15, %16) <{id = 0 : index, program_address = 1320 : i32}> : (!torq_hl.invocation<slice>, memref<5120xi8, #torq_hl<enc mem_space = lram>>, memref<i32, #torq_hl<enc mem_space = lram>>, memref<2xi8, #torq_hl<enc mem_space = lram>>, memref<2xi32, #torq_hl<enc mem_space = lram>>, memref<i32, #torq_hl<enc mem_space = lram>>, memref<i32, #torq_hl<enc mem_space = lram>>) -> ()
            }
            torq_hw.nss_task {"torq-task-id" = 8 : i64}() {
              "torq_hw.slice_wait"() <{id = 0 : index}> : () -> ()
            }
            torq_hw.nss_task {"torq-task-id" = 9 : i64}() {
              torq_hw.dma_out_cfg from %19 : memref<i32, #torq_hl<enc mem_space = lram>> to %arg6 : memref<i32> {read_address = 1280 : i32, read_ndl = #torq_hw<dma_ndl{dims = [[4, 1]]}>, write_address = 9453568 : i32, write_ndl = #torq_hw<dma_ndl{dims = [[4, 1]]}>}
              torq_hw.dma_out_start
              torq_hw.dma_out_wait
            }
            torq_hl.return %arg0, %arg1 : memref<640xi8, #torq_hl<enc mem_space = lram>>, memref<640xi8, #torq_hl<enc mem_space = lram>>
          }
          %invocation_0, %code_sections_1:2 = torq_hl.descriptor "nss_program_1" on 0 program %4 : <nss> code [array<i8: 0, 1, 12, 16, 0, 0, 4, 0, 0, 0, 0, 0, 2, 0, 0, 0, 8, 5, 0, 0, 2, 0, 0, 16, 8, 0, 16, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 3, 16, 1, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 96, 0, 1, 12, 16, 0, 0, 4, 0, 0, 0, 0, 0, 8, 0, 0, 0, 16, 5, 0, 0, 8, 0, 0, 16, 0, 0, 16, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 3, 16, 1, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 96, 0, 1, 12, 16, 0, 0, 4, 0, 0, 0, 0, 0, 4, 0, 0, 0, 24, 5, 0, 0, 4, 0, 0, 16, 0, 32, -112, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 3, 16, 1, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 96, 0, 1, 12, 16, 0, 0, 4, 0, 0, 0, 0, 0, 4, 0, 0, 0, 32, 5, 0, 0, 4, 0, 0, 16, 0, 48, -112, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 3, 16, 1, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 96, 0, 1, 12, 16, 0, 0, 4, 0, 0, 0, 0, 0, -68, 0, 0, 0, 0, 0, 0, 0, -68, 0, 0, 16, -8, 23, 16, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 3, 16, 1, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 96, 0, 0, 0, 112, 0, 1, 12, 16, 0, 0, 4, 0, 0, 0, 0, 0, 8, 1, 0, 0, 40, 5, 0, 0, 8, 1, 0, 16, 12, 0, 16, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 3, 16, 1, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 96, 0, 2, 1, 16, 40, 5, 0, 1, 8, 0, 3, 16, 1, 0, 0, 0, 16, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 96, 8, 0, 3, 16, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 16, 0, 0, 96, 48, 1, 11, 16, 0, 0, 4, 0, 4, 0, 0, 0, 0, 5, 0, 0, 4, 0, 0, 16, 0, 64, -112, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 3, 16, 1, 0, 0, 0, 8, 0, 0, 0, 8, 0, 0, 0, 8, 0, 0, -32>] {executor_code_addresses = array<i64: 640>, "torq-job-id" = 1 : i32, xram_code_addresses = array<i64: 1054348, 1054712>} : !torq_hl.invocation<nss>, memref<364xi8>, memref<188xi8>
          torq_hl.start_program %invocation : !torq_hl.invocation<nss> args(%0, %1, %invocation, %invocation_0 : memref<640xi8, #torq_hl<enc mem_space = lram>>, memref<640xi8, #torq_hl<enc mem_space = lram>>, !torq_hl.invocation<nss>, !torq_hl.invocation<nss>) code(%0 : memref<640xi8, #torq_hl<enc mem_space = lram>>) {"torq-action-id" = 1 : i32}
          %5:2 = torq_hl.wait_program %invocation : !torq_hl.invocation<nss> {result_addresses = array<i64: 640, 0>, "torq-action-id" = 2 : i32, "torq-buffer-ids" = array<i64: 5, 6>} : memref<640xi8, #torq_hl<enc mem_space = lram>>, memref<640xi8, #torq_hl<enc mem_space = lram>>
          %6 = "torq_hl.map_binding"() <{binding_index = 0 : index, is_read_only = true, is_write_only = false, offset = 0 : index}> {"torq-buffer-ids" = array<i64: 7>, xram_address = 9445376 : i64} : () -> memref<i32>
          %7 = "torq_hl.map_binding"() <{binding_index = 1 : index, is_read_only = true, is_write_only = false, offset = 0 : index}> {"torq-buffer-ids" = array<i64: 8>, xram_address = 9449472 : i64} : () -> memref<i32>
          %8 = "torq_hl.map_binding"() <{binding_index = 2 : index, is_read_only = false, is_write_only = false, offset = 0 : index}> {"torq-buffer-ids" = array<i64: 9>, xram_address = 9453568 : i64} : () -> memref<i32>
          %9 = torq_hl.program "slice_program_torq_hl.add_0" : !torq_hl.program<slice> {
          ^bb0(%arg0: memref<i32, #torq_hl<enc mem_space = lram>>, %arg1: memref<2xi8, #torq_hl<enc mem_space = lram>>, %arg2: memref<2xi32, #torq_hl<enc mem_space = lram>>, %arg3: memref<i32, #torq_hl<enc mem_space = lram>>, %arg4: memref<i32, #torq_hl<enc mem_space = lram>>):
            %11 = "torq_hw.get_address"(%arg3) : (memref<i32, #torq_hl<enc mem_space = lram>>) -> index
            %12 = "torq_hw.get_address"(%arg4) : (memref<i32, #torq_hl<enc mem_space = lram>>) -> index
            torq_hw.slice_task{
            op : "add"
             D %arg3, %arg4 : memref<i32, #torq_hl<enc mem_space = lram>>, memref<i32, #torq_hl<enc mem_space = lram>>
             W %arg1 : memref<2xi8, #torq_hl<enc mem_space = lram>>
             B %arg2 : memref<2xi32, #torq_hl<enc mem_space = lram>>
             Q %arg0 : memref<i32, #torq_hl<enc mem_space = lram>>
             SYMBOLS %11, %12
             CFG {alu_op0_mode = [MUL, MUL, MUL, MUL], alu_op1_mode = [ACC, ACC, ACC, ACC], alu_d_unsigned = 7, alu_w_unsigned = 0, act_mode = ACT, act_lsh = [0, 8, 16, 24], act_clip_min = -2147483648, act_clip_max = 2147483647, weight_format = SI, alu_format = I, act_format = I, act_sum_bits = 32,}
             [{DEWR dims = [ B(L) [1, #map],  D(L) [2, #map],  G(H) [1, #map1]]}, {DEBR dims = [ B(L) [4, #map],  D(L) [2, #map2],  G(H) [1, #map1]]}, {DEDR dims = [ B(L) [4, #map],  D(L) [1, #map2],  G(H) [1, #map1],  O(H) [2, #map3],  A(H) [1, #map4]]}, {DEQW dims = [ B(L) [4, #map],  D(L) [1, #map2],  G(H) [1, #map1],  A(H) [1, #map1],  B(S) [2, #map],  X(S) [2, #map5]]}, {REF dims = []}]
             [{CEWW dims = [ B(L) [1, 1],  D(L) [2, 1],  G(L) [1, 0],  T(H) [1, 0]]}, {ACBW dims = [ B(L) [8, 1],  D(L) [1, 8],  G(L) [1, 0],  T(H) [1, 0]]}, {CEDW dims = [ B(L) [4, 1],  D(L) [1, 4],  T(H) [2, 0]]}, {CEDR dims = [ B(L) [4, 1],  D(L) [2, 4],  T(H) [2, 0]]}, {CEWR dims = [ B(L) [1, 1],  D(L) [1, 0],  S(H) [2, 1],  M(H) [1, 0],  T(H) [1, 0]]}, {ACBR dims = [ B(L) [8, 1],  D(L) [1, 8],  M(H) [1, 0],  T(H) [1, 0]]}, {ACPR dims = [ B(L) [4, 1],  D(L) [4, 4],  G(L) [1, 0],  S(H) [1, 16],  T(H) [1, 0]]}, {CEPR dims = [ B(L) [4, 1],  D(L) [4, 4],  N(H) [2, 0],  T(H) [1, 0]]}, {ACPW dims = [ B(L) [4, 1],  D(L) [4, 4],  G(L) [4, 16],  T(H) [1, 0]]}]
            }
            torq_hl.return
          }
          %invocation_2, %code_sections_3 = torq_hl.descriptor "slice_program_torq_hl.add_0" on 0 program %9 : <slice> code [array<i8: -128, 0, 14, 16, 0, 0, 0, 64, 1, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 81, 1, 0, 0, 1, 1, 0, 0, 85, 2, 0, 1, 69, 21, 33, 0, 0, -31, 10, 0, 0, 0, -88, 32, 8, 0, 0, 0, 0, 4, 0, 31, 16, -24, 5, 0, 4, -1, -1, -1, -1, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 6, 0, 2, 0, 0, 0, 0, 16, 6, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 6, 0, 68, 0, 0, 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, -80, 100, -128, 4, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -128, -1, -1, -1, 127, 0, 0, 6, 0, 31, 1, 0, 0, 31, 1, 0, 0, 31, 1, 0, -32, 24, 5, 0, -93, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 8, 0, 0, 0, 1, 0, 0, -64, 56, 0, 0, 0, 8, 5, 0, -95, 1, 0, 0, -128, 0, 0, 0, 0, 16, 5, 0, -95, 1, 0, 0, -128, 0, 0, 0, 0, 0, 5, 0, -94, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -64, 0, 0, 0, 0>] {executor_code_addresses = array<i64: 1320>, "torq-buffer-ids" = array<i64: 10>, xram_code_addresses = array<i64: 1048588>} : !torq_hl.invocation<slice>, memref<264xi8>
          torq_hl.start_program %invocation_0 : !torq_hl.invocation<nss> args(%5#0, %5#1, %invocation_0, %6, %7, %invocation_2, %8 : memref<640xi8, #torq_hl<enc mem_space = lram>>, memref<640xi8, #torq_hl<enc mem_space = lram>>, !torq_hl.invocation<nss>, memref<i32>, memref<i32>, !torq_hl.invocation<slice>, memref<i32>) code(%5#0 : memref<640xi8, #torq_hl<enc mem_space = lram>>) {"torq-action-id" = 3 : i32}
          %10:2 = torq_hl.wait_program %invocation_0 : !torq_hl.invocation<nss> {result_addresses = array<i64: 640, 0>, "torq-action-id" = 4 : i32, "torq-buffer-ids" = array<i64: 11, 12>} : memref<640xi8, #torq_hl<enc mem_space = lram>>, memref<640xi8, #torq_hl<enc mem_space = lram>>
          return
        }
      }
    }
  }
  util.func public @main(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @main(%input0: tensor<i32>, %input1: tensor<i32>) -> (%output0: tensor<i32>)"}} {
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %element_type_i32 = hal.element_type<i32> : i32
    %dense_row_major = hal.encoding_type<dense_row_major> : i32
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input0") shape([]) type(%element_type_i32) encoding(%dense_row_major)
    %0 = stream.tensor.import on(#hal.device.affinity<@__device_0>) %arg0 : !hal.buffer_view -> tensor<i32> in !stream.resource<external>{%c4}
    hal.buffer_view.assert<%arg1 : !hal.buffer_view> message("input1") shape([]) type(%element_type_i32) encoding(%dense_row_major)
    %1 = stream.tensor.import on(#hal.device.affinity<@__device_0>) %arg1 : !hal.buffer_view -> tensor<i32> in !stream.resource<external>{%c4}
    %result, %result_timepoint = stream.resource.alloca uninitialized on(#hal.device.affinity<@__device_0>) : !stream.resource<external>{%c4} => !stream.timepoint
    %2 = stream.cmd.execute on(#hal.device.affinity<@__device_0>) await(%result_timepoint) => with(%1 as %arg2: !stream.resource<external>{%c4}, %0 as %arg3: !stream.resource<external>{%c4}, %result as %arg4: !stream.resource<external>{%c4}) {
      stream.cmd.dispatch @main_dispatch_0::@torq_fb::@main_dispatch_0_elementwise {
        ro %arg2[%c0 for %c4] : !stream.resource<external>{%c4},
        ro %arg3[%c0 for %c4] : !stream.resource<external>{%c4},
        wo %arg4[%c0 for %c4] : !stream.resource<external>{%c4}
      }
    } => !stream.timepoint
    %3 = stream.timepoint.await %2 => %result : !stream.resource<external>{%c4}
    %4 = stream.tensor.export on(#hal.device.affinity<@__device_0>) %3 : tensor<i32> in !stream.resource<external>{%c4} -> !hal.buffer_view
    util.return %4 : !hal.buffer_view
  }
}
