#executable_target_torq_fb = #hal.executable.target<"torq", "torq-fb">
#map = affine_map<() -> ()>
#device_target_torq = #hal.device.target<"torq", [#executable_target_torq_fb]> : !hal.device
module @jit___call attributes {stream.affinity.default = #hal.device.affinity<@__device_0>, stream.resources = #stream.resource_config<{max_allocation_size = 4294967296, min_buffer_offset_alignment = 4096, max_buffer_range = 4294967296, min_buffer_range_alignment = 4096, index_bits = 32, alias_mutable_bindings = 1, memory_model = Unified}>} {
  util.global private @__device_0 = #device_target_torq
  util.func public @main(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @main(%input0: tensor<i32>, %input1: tensor<i32>) -> (%output0: tensor<i32>)"}} {
    %0 = hal.tensor.import %arg0 "input0" : !hal.buffer_view -> tensor<i32>
    %1 = iree_tensor_ext.compute_barrier.start %0 : tensor<i32> -> tensor<i32>
    %2 = hal.tensor.import %arg1 "input1" : !hal.buffer_view -> tensor<i32>
    %3 = iree_tensor_ext.compute_barrier.start %2 : tensor<i32> -> tensor<i32>
    %4 = flow.dispatch.region -> (tensor<i32>) {
      %6 = tensor.empty() : tensor<i32>
      %7 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = []} ins(%3, %1 : tensor<i32>, tensor<i32>) outs(%6 : tensor<i32>) {
      ^bb0(%in: i32, %in_0: i32, %out: i32):
        %9 = arith.addi %in, %in_0 : i32
        linalg.yield %9 : i32
      } -> tensor<i32>
      %8 = iree_tensor_ext.compute_barrier.end %7 : tensor<i32> -> tensor<i32>
      flow.return %8 : tensor<i32>
    }
    %5 = hal.tensor.export %4 "output0" : tensor<i32> -> !hal.buffer_view
    util.return %5 : !hal.buffer_view
  }
}
