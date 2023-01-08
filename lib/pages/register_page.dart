import "package:fitness/services/dto.dart";
import "package:fitness/services/user_service.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _inputDecoration = const InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    ),
  );

  void register() {
    final dto = AuthRegisterDto(
      login: _loginTextController.text,
      password: _passwordTextController.text,
    );
    final UserService userService = GetIt.instance.get<UserService>();
    userService.register(dto).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Аккаунт создан"),
      ));
    }).catchError((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Ошибка!"),
      ));
    });
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
        title: const Text("Регистрация"),
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
          const SizedBox(height: 40),
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
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              child: const Text("Создать аккаунт"),
              onPressed: () {
                register();
              },
            ),
          ),
        ],
      ),
    );
  }
}
