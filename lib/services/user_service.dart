import "package:dio/dio.dart";
import "package:fitness/models/user.dart";
import "package:fitness/services/dto.dart";
import "package:get_it/get_it.dart";

class UserService {
  final int _port = 4000;
  final Dio _dio = GetIt.instance.get<Dio>();

  Future<User> login(AuthLoginDto dto) async {
    try {
      final Response response = await _dio.post(
        "http://localhost:$_port/auth/login",
        data: dto.toJson(),
      );
      return User.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<User> register(AuthRegisterDto dto) async {
    try {
      final Response response = await _dio.post(
        "http://localhost:$_port/auth/register",
        data: dto.toJson(),
      );
      return User.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
