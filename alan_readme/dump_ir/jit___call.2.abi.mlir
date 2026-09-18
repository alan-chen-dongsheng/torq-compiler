#map = affine_map<() -> ()>
module @jit___call {
  util.func public @main(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @main(%input0: tensor<i32>, %input1: tensor<i32>) -> (%output0: tensor<i32>)"}} {
    %0 = hal.tensor.import %arg0 "input0" : !hal.buffer_view -> tensor<i32>
    %1 = hal.tensor.import %arg1 "input1" : !hal.buffer_view -> tensor<i32>
    %2 = flow.dispatch.region -> (tensor<i32>) {
      %4 = tensor.empty() : tensor<i32>
      %5 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = []} ins(%1, %0 : tensor<i32>, tensor<i32>) outs(%4 : tensor<i32>) {
      ^bb0(%in: i32, %in_0: i32, %out: i32):
        %6 = arith.addi %in, %in_0 : i32
        linalg.yield %6 : i32
      } -> tensor<i32>
      flow.return %5 : tensor<i32>
    }
    %3 = hal.tensor.export %2 "output0" : tensor<i32> -> !hal.buffer_view
    util.return %3 : !hal.buffer_view
  }
}
