import "package:fitness/models/enums.dart";

class Program {
  final String id;
  final String authorId;
  // final List<Workout> workouts;
  final Specification specification;
  final Complexity complexity;

  const Program({
    required this.id,
    required this.authorId,
    // required this.workouts,
    required this.specification,
    required this.complexity,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json["id"],
      authorId: json["authorId"],
      // workouts: (json['workouts'] as List<dynamic>)
      //     .map((w) => Workout.fromJson(w))
      //     .toList(),
      specification: Specification.values[json["specification"]],
      complexity: Complexity.values[json["complexity"]],
    );
  }
}
