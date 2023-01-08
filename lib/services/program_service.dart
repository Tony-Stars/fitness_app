import "package:dio/dio.dart";
import "package:fitness/models/program.dart";
import "package:fitness/services/dto.dart";
import "package:get_it/get_it.dart";

class ProgramService {
  final int _port = 5000;
  final Dio _dio = GetIt.instance.get<Dio>();

  Future<List<Program>> select(SearchDto dto) async {
    try {
      final Response<List> response = await _dio.post(
        "http://localhost:$_port/program/select",
        data: dto.toJson(),
      );
      return response.data?.map((p) => Program.fromJson(p)).toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Program>> getByAuthor(String authorId) async {
    try {
      final Response<List> response = await _dio.get<List>(
        "http://localhost:$_port/program/by-author/$authorId",
      );
      return response.data?.map((p) => Program.fromJson(p)).toList() ?? [];
    } catch (e) {
      rethrow;
    }
  }

  Future<Program> create(CreateProgramDto dto) async {
    try {
      final Response response = await _dio.post(
        "http://localhost:$_port/program",
        data: dto.toJson(),
      );
      return Program.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      _dio.delete("http://localhost:$_port/program/$id");
    } catch (e) {
      rethrow;
    }
  }
}
