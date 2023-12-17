class WeightAndDirection {
  int weight;
  String direction;
  WeightAndDirection({required this.weight, required this.direction});
}

class DirectedWeightedGraph {
  Map<String, Map<String, WeightAndDirection>> _adjacencyList;

  DirectedWeightedGraph()
      : _adjacencyList = {}; // Initialize the field in the constructor

  void addVertex(String vertex) {
    if (!_adjacencyList.containsKey(vertex)) {
      _adjacencyList[vertex] = {};
    }
  }

  void addEdge(
      String startVertex, String endVertex, int weight, String direction) {
    if (!_adjacencyList.containsKey(startVertex)) {
      addVertex(startVertex);
    }
    if (!_adjacencyList.containsKey(endVertex)) {
      addVertex(endVertex);
    }

    _adjacencyList[startVertex]![endVertex] =
        WeightAndDirection(weight: weight, direction: direction);
  }

  // void printGraph() {
  //   _adjacencyList.forEach((vertex, edges) {
  //     print('$vertex ->');
  //     edges.forEach((neighbor, weightAndDirection) {
  //       print('  ${neighbor} (Weight: ${weightAndDirection.weight}, Direction: ${weightAndDirection.direction})');
  //     });
  //   });
  // }
}
