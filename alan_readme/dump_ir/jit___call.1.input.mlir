#map = affine_map<() -> ()>
module @jit___call {
  util.func public @main(%arg0: tensor<i32>, %arg1: tensor<i32>) -> tensor<i32> {
    %0 = flow.dispatch.region -> (tensor<i32>) {
      %1 = tensor.empty() : tensor<i32>
      %2 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = []} ins(%arg1, %arg0 : tensor<i32>, tensor<i32>) outs(%1 : tensor<i32>) {
      ^bb0(%in: i32, %in_0: i32, %out: i32):
        %3 = arith.addi %in, %in_0 : i32
        linalg.yield %3 : i32
      } -> tensor<i32>
      flow.return %2 : tensor<i32>
    }
    util.return %0 : tensor<i32>
  }
}
