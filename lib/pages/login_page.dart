import "package:fitness/utils/app_router.dart";
import "package:fitness/bloc/user_bloc.dart";
import "package:fitness/services/dto.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginTextController = TextEditingController(text: "1");
  final _passwordTextController = TextEditingController(text: "1");

  final _inputDecoration = const InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    ),
  );

  void login(BuildContext context) {
    final dto = AuthLoginDto(
      login: _loginTextController.text,
      password: _passwordTextController.text,
    );
    final UserBloc bloc = GetIt.instance.get<UserBloc>();
    bloc.add(LoginUserEvent(dto: dto, context: context));
  }

  void register() {
    Navigator.of(context).pushNamed(AppPage.register);
  }

  @override
  void dispose() {
    _loginTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Авторизация"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          const SizedBox(height: 80),
          Center(
            child: Text(
              "Фитнес",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 45),
          TextField(
            controller: _loginTextController,
            decoration: _inputDecoration.copyWith(
              label: const Text("Логин"),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _passwordTextController,
            decoration: _inputDecoration.copyWith(
              label: const Text("Пароль"),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                child: const Text("Войти"),
                onPressed: () {
                  login(context);
                },
              ),
              ElevatedButton(
                child: const Text("Создать аккаунт"),
                onPressed: () {
                  register();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
