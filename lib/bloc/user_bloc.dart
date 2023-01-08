import "package:fitness/models/user.dart";
import "package:fitness/services/dto.dart";
import "package:fitness/services/user_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

abstract class UserState {
  const UserState();
}

class UnknownUserState extends UserState {
  const UnknownUserState();
}

class AuthenticatedUserState extends UserState {
  final User user;

  const AuthenticatedUserState({required this.user});
}

abstract class UserEvent {
  const UserEvent();
}

class LoginUserEvent extends UserEvent {
  final AuthLoginDto dto;
  final BuildContext context;

  const LoginUserEvent({
    required this.dto,
    required this.context,
  });
}

class LogoutUserEvent extends UserEvent {
  const LogoutUserEvent();
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService = GetIt.instance.get<UserService>();

  UserBloc() : super(const UnknownUserState()) {
    on<LoginUserEvent>(_login);
    on<LogoutUserEvent>(_logout);
  }

  Future<void> _login(
    LoginUserEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      final user = await _userService.login(event.dto);
      emit(AuthenticatedUserState(user: user));
    } catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text("Некоректные данные!"),
        ),
      );
      rethrow;
    }
  }

  void _logout(
    LogoutUserEvent event,
    Emitter<UserState> emit,
  ) {
    emit(const UnknownUserState());
  }
}
