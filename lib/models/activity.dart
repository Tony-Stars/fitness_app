import "package:flutter/material.dart";

abstract class Activity {
  final String? id;
  final String name;
  final bool completed;

  String get title;
  IconData get icon;

  const Activity({
    required this.id,
    required this.name,
    required this.completed,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    if (json["count"] != null) {
      return RepetitionActivity.fromJson(json);
    } else {
      return DurationActivity.fromJson(json);
    }
  }

  Activity copyWithCompleted(bool value);

  Map<String, dynamic> toJson();
}

class RepetitionActivity extends Activity {
  final int count;

  @override
  String get title => "$name - $count раз";

  @override
  IconData get icon => Icons.onetwothree;

  const RepetitionActivity({
    super.id,
    required this.count,
    required super.name,
    required super.completed,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "count": count,
      "name": name,
      "completed": completed,
    };
  }

  @override
  RepetitionActivity copyWithCompleted(bool value) {
    return RepetitionActivity(
      id: id,
      completed: value,
      name: name,
      count: count,
    );
  }

  factory RepetitionActivity.fromJson(Map<String, dynamic> json) {
    return RepetitionActivity(
      id: json["id"],
      count: json["count"],
      name: json["name"],
      completed: json["completed"],
    );
  }
}

class DurationActivity extends Activity {
  final Duration duration;

  @override
  String get title => "$name - ${duration.inSeconds} секунд";

  @override
  IconData get icon => Icons.hourglass_empty;

  const DurationActivity({
    super.id,
    required this.duration,
    required super.name,
    required super.completed,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "duration": duration.inSeconds,
      "name": name,
      "completed": completed,
    };
  }

  @override
  DurationActivity copyWithCompleted(bool value) {
    return DurationActivity(
      id: id,
      completed: value,
      name: name,
      duration: duration,
    );
  }

  factory DurationActivity.fromJson(Map<String, dynamic> json) {
    return DurationActivity(
      id: json["id"],
      duration: Duration(seconds: json["duration"]),
      name: json["name"],
      completed: json["completed"],
    );
  }
}
