import "package:fitness/app.dart";
import "package:fitness/pages/create_activity_page.dart";
import "package:fitness/pages/create_program_page.dart";
import "package:fitness/pages/program_page.dart";
import "package:fitness/pages/register_page.dart";
import "package:fitness/pages/workout_page.dart";
import "package:flutter/material.dart";

extension AppPage on String {
  static const String init = "/";
  static const String register = "/register";
  static const String createProgram = "/create-program";
  static const String createActivity = "/create-activity";
  static const String program = "/program";
  static const String workout = "/workout";
}

class AppRouter {
  static String initialRoute = AppPage.init;

  static Route onGenerateRoute(RouteSettings settings) {
    final page = settings.arguments;

    switch (settings.name) {
      case AppPage.init:
        return MaterialPageRoute(builder: (_) => const FitnessApp());
      case AppPage.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case AppPage.createProgram:
        if (page is CreateProgramPage) {
          return MaterialPageRoute(builder: (_) => page);
        }
        return _ErrorPageRoute();
      case AppPage.createActivity:
        if (page is CreateActivityPage) {
          return MaterialPageRoute(builder: (_) => page);
        }
        return _ErrorPageRoute();
      case AppPage.program:
        if (page is ProgramPage) {
          return MaterialPageRoute(builder: (_) => page);
        }
        return _ErrorPageRoute();
      case AppPage.workout:
        if (page is WorkoutPage) {
          return MaterialPageRoute(builder: (_) => page);
        }
        return _ErrorPageRoute();
      default:
        return _ErrorPageRoute();
    }
  }
}

class _ErrorPageRoute extends MaterialPageRoute {
  _ErrorPageRoute() : super(builder: (_) => const _ErrorPage());
}

class _ErrorPage extends StatelessWidget {
  const _ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Error!")),
    );
  }
}
