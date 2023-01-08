class Workout {
  final String id;
  final String programId;
  // final List<Activity> activities;

  const Workout({required this.id, required this.programId});

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json["id"],
      programId: json["programId"],
      // activities: (json['activities'] as List<dynamic>)
      //     .map((a) => Activity.fromJson(a))
      //     .toList(),
    );
  }
}
