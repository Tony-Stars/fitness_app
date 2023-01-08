import "package:fitness/utils/filter.dart";
import "package:fitness/models/enums.dart";

class AuthLoginDto {
  final String login;
  final String password;

  const AuthLoginDto({required this.login, required this.password});

  Map<String, String> toJson() {
    return {
      "login": login,
      "password": password,
    };
  }
}

class AuthRegisterDto extends AuthLoginDto {
  const AuthRegisterDto({
    required super.login,
    required super.password,
  });
}

class SearchDto {
  final String userId;
  final Filter filter;

  const SearchDto({
    required this.userId,
    required this.filter,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "filter": filter.toJson(),
    };
  }
}

class CreateProgramDto {
  final String authorId;
  final List workouts = const [];
  final Specification specification;
  final Complexity complexity;

  const CreateProgramDto({
    required this.authorId,
    required this.specification,
    required this.complexity,
  });

  Map<String, dynamic> toJson() {
    return {
      "authorId": authorId,
      "workouts": workouts,
      "specification": specification.index,
      "complexity": complexity.index,
    };
  }
}

class CreateActivityDto {
  final String workoutId;
  final String name;
  final bool completed = false;
  final int? count;
  final int? duration;

  const CreateActivityDto({
    required this.workoutId,
    required this.name,
    this.count,
    this.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      "workoutId": workoutId,
      "name": name,
      "completed": completed,
      "count": count,
      "duration": duration,
    };
  }
}

class SetActivityStatusDto {
  final String programId;
  final String workoutId;
  final String activityId;
  final bool completed;

  const SetActivityStatusDto({
    required this.programId,
    required this.workoutId,
    required this.activityId,
    required this.completed,
  });

  Map<String, dynamic> toJson() {
    return {
      "programId": programId,
      "workoutId": workoutId,
      "activityId": activityId,
      "completed": completed,
    };
  }
}
