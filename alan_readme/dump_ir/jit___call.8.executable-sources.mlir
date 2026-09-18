#executable_target_torq_fb = #hal.executable.target<"torq", "torq-fb">
#map = affine_map<() -> ()>
#pipeline_layout = #hal.pipeline.layout<bindings = [#hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, "ReadOnly|Indirect">, #hal.pipeline.binding<storage_buffer, Indirect>], flags = Indirect>
#device_target_torq = #hal.device.target<"torq", [#executable_target_torq_fb]> : !hal.device
module @jit___call attributes {stream.affinity.default = #hal.device.affinity<@__device_0>, stream.resources = #stream.resource_config<{max_allocation_size = 4294967296, min_buffer_offset_alignment = 4096, max_buffer_range = 4294967296, min_buffer_range_alignment = 4096, index_bits = 32, alias_mutable_bindings = 1, memory_model = Unified}>} {
  util.global private @__device_0 = #device_target_torq
  hal.executable private @main_dispatch_0 {
    hal.executable.variant public @torq_fb target(#executable_target_torq_fb) {
      hal.executable.export public @main_dispatch_0_elementwise ordinal(0) layout(#pipeline_layout) count(%arg0: !hal.device) -> (index, index, index) {
        %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
        hal.return %x, %y, %z : index, index, index
      }
      builtin.module {
        func.func @main_dispatch_0_elementwise() {
          %c0 = arith.constant 0 : index
          %0 = hal.interface.binding.subspan layout(#pipeline_layout) binding(0) alignment(4096) offset(%c0) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<i32>>
          %1 = hal.interface.binding.subspan layout(#pipeline_layout) binding(1) alignment(4096) offset(%c0) flags("ReadOnly|Indirect") : !iree_tensor_ext.dispatch.tensor<readonly:tensor<i32>>
          %2 = hal.interface.binding.subspan layout(#pipeline_layout) binding(2) alignment(4096) offset(%c0) flags(Indirect) : !iree_tensor_ext.dispatch.tensor<writeonly:tensor<i32>>
          %3 = iree_tensor_ext.dispatch.tensor.load %0, offsets = [], sizes = [], strides = [] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<i32>> -> tensor<i32>
          %4 = iree_tensor_ext.dispatch.tensor.load %1, offsets = [], sizes = [], strides = [] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<i32>> -> tensor<i32>
          %5 = tensor.empty() : tensor<i32>
          %6 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = []} ins(%3, %4 : tensor<i32>, tensor<i32>) outs(%5 : tensor<i32>) {
          ^bb0(%in: i32, %in_0: i32, %out: i32):
            %7 = arith.addi %in, %in_0 : i32
            linalg.yield %7 : i32
          } -> tensor<i32>
          iree_tensor_ext.dispatch.tensor.store %6, %2, offsets = [], sizes = [], strides = [] : tensor<i32> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<i32>>
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
