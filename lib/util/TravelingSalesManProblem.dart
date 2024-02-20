class TravelingSalesManProblem {
  List<int> solve(List<List<int>> distances) {
    final int n = distances.length;
    final List<int> cities = List.generate(n, (index) => index);
    double minDistance = double.infinity;
    List<int>? bestPath;

    void permute(int start) {
      if (start == n - 1) {
        double distance = 0;
        for (int i = 0; i < n - 1; i++) {
          distance += distances[cities[i]][cities[i + 1]];
        }
        distance += distances[cities[n - 1]][cities[0]];

        if (distance < minDistance) {
          minDistance = distance;
          bestPath = List.from(cities);
        }
      } else {
        for (int i = start; i < n; i++) {
          _swap(cities, start, i);
          permute(start + 1);
          _swap(cities, start, i); // backtrack
        }
      }
    }
    permute(0);
    return bestPath!;
  }

  void _swap(List<int> list, int i, int j) {
    final int temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }
}