import "package:fitness/utils/app_router.dart";
import "package:fitness/bloc/programs_bloc.dart";
import "package:fitness/bloc/user_bloc.dart";
import "package:fitness/pages/create_program_page.dart";
import "package:fitness/widgets/search_tab.dart";
import "package:fitness/widgets/training_tab.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final List<StatefulWidget> tabs = const [
    TrainingTab(),
    SearchTab(),
  ];

  void onPressedFAB({required BuildContext widgetContext}) {
    final ProgramBloc programBloc = context.read<ProgramBloc>();
    Navigator.of(widgetContext).pushNamed(AppPage.createProgram,
        arguments: CreateProgramPage(programBloc: programBloc));
  }

  void onSelectTab(int index) {
    if (currentIndex != index) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  void logout(BuildContext widgetContext) {
    widgetContext.read<UserBloc>().add(const LogoutUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            tooltip: "Выйти",
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: tabs[currentIndex],
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              onPressed: () => onPressedFAB(
                widgetContext: context,
              ),
              tooltip: "Добавить программу",
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onSelectTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            label: "Программы",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "Поиск программ",
          ),
        ],
      ),
    );
  }
}
