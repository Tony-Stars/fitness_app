import "package:fitness/models/enums.dart";

class Filter {
  final List<Complexity> complexities;
  final List<Specification> specifications;

  const Filter({
    this.complexities = const [],
    this.specifications = const [],
  });

  Filter copyWith({
    List<Complexity>? complexities,
    List<Specification>? specifications,
  }) {
    return Filter(
      complexities: complexities ?? this.complexities,
      specifications: specifications ?? this.specifications,
    );
  }

  Map<String, List<int>> toJson() {
    return {
      "complexities": complexities.map((c) => c.index).toList(),
      "specifications": specifications.map((s) => s.index).toList(),
    };
  }
}
