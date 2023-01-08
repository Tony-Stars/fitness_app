import "package:dio/dio.dart";
import "package:fitness/models/workout.dart";
import "package:get_it/get_it.dart";

class WorkoutService {
  final int _port = 5000;
  final Dio _dio = GetIt.instance.get<Dio>();

  Future<List<Workout>> getByProgram(String programId) async {
    try {
      final Response<List> response = await _dio.get<List>(
        "http://localhost:$_port/workout/by-program/$programId",
      );
      return response.data?.map((p) => Workout.fromJson(p)).toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  Future<Workout> create(String programId) async {
    try {
      final Response response = await _dio.post(
        "http://localhost:$_port/workout",
        data: {"programId": programId},
      );
      return Workout.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      _dio.delete("http://localhost:$_port/workout/$id");
    } catch (e) {
      rethrow;
    }
  }
}
