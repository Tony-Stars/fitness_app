import "package:dio/dio.dart";
import "package:fitness/models/activity.dart";
import "package:fitness/services/dto.dart";
import "package:get_it/get_it.dart";

class ActivityService {
  final int _port = 5000;
  final Dio _dio = GetIt.instance.get<Dio>();

  Future<List<Activity>> getByWorkout(String workoutId) async {
    try {
      final Response<List> response = await _dio.get<List>(
        "http://localhost:$_port/activity/by-workout/$workoutId",
      );
      return response.data?.map((p) => Activity.fromJson(p)).toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  Future<Activity> create(CreateActivityDto dto) async {
    try {
      final Response response = await _dio.post(
        "http://localhost:$_port/activity",
        data: dto.toJson(),
      );
      return Activity.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Activity> update(String id, Activity dto) async {
    try {
      final Response response =
          await _dio.put("http://localhost:$_port/activity/$id",data:dto.toJson());
      return Activity.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> setActivityStatus(SetActivityStatusDto dto) async {
  //   try {
  //     await _dio.put(
  //       'http://localhost:$_port/activity/set-activity-status',
  //       data: dto.toJson(),
  //     );
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> delete(String id) async {
    try {
      _dio.delete("http://localhost:$_port/activity/$id");
    } catch (e) {
      rethrow;
    }
  }
}
