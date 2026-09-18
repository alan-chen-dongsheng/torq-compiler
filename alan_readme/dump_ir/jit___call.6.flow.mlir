#executable_target_torq_fb = #hal.executable.target<"torq", "torq-fb">
#map = affine_map<() -> ()>
#device_target_torq = #hal.device.target<"torq", [#executable_target_torq_fb]> : !hal.device
module @jit___call attributes {stream.affinity.default = #hal.device.affinity<@__device_0>, stream.resources = #stream.resource_config<{max_allocation_size = 4294967296, min_buffer_offset_alignment = 4096, max_buffer_range = 4294967296, min_buffer_range_alignment = 4096, index_bits = 32, alias_mutable_bindings = 1, memory_model = Unified}>} {
  util.global private @__device_0 = #device_target_torq
  flow.executable private @main_dispatch_0 {
    flow.executable.export public @main_dispatch_0_elementwise workgroups() -> (index, index, index) {
      %x, %y, %z = iree_tensor_ext.dispatch.workgroup_count_from_slice()
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_0_elementwise(%arg0: !iree_tensor_ext.dispatch.tensor<readonly:tensor<i32>>, %arg1: !iree_tensor_ext.dispatch.tensor<readonly:tensor<i32>>, %arg2: !iree_tensor_ext.dispatch.tensor<writeonly:tensor<i32>>) {
        %0 = iree_tensor_ext.dispatch.tensor.load %arg0, offsets = [], sizes = [], strides = [] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<i32>> -> tensor<i32>
        %1 = iree_tensor_ext.dispatch.tensor.load %arg1, offsets = [], sizes = [], strides = [] : !iree_tensor_ext.dispatch.tensor<readonly:tensor<i32>> -> tensor<i32>
        %2 = tensor.empty() : tensor<i32>
        %3 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = []} ins(%0, %1 : tensor<i32>, tensor<i32>) outs(%2 : tensor<i32>) {
        ^bb0(%in: i32, %in_0: i32, %out: i32):
          %4 = arith.addi %in, %in_0 : i32
          linalg.yield %4 : i32
        } -> tensor<i32>
        iree_tensor_ext.dispatch.tensor.store %3, %arg2, offsets = [], sizes = [], strides = [] : tensor<i32> -> !iree_tensor_ext.dispatch.tensor<writeonly:tensor<i32>>
        return
      }
    }
  }
  util.func public @main(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @main(%input0: tensor<i32>, %input1: tensor<i32>) -> (%output0: tensor<i32>)"}} {
    %0 = hal.tensor.import %arg0 "input0" : !hal.buffer_view -> tensor<i32>
    %1 = hal.tensor.import %arg1 "input1" : !hal.buffer_view -> tensor<i32>
    %2 = flow.dispatch @main_dispatch_0::@main_dispatch_0_elementwise(%1, %0) : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %3 = hal.tensor.export %2 "output0" : tensor<i32> -> !hal.buffer_view
    util.return %3 : !hal.buffer_view
  }
}
