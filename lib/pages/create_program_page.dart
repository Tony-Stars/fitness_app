import "package:fitness/bloc/programs_bloc.dart";
import "package:fitness/bloc/user_bloc.dart";
import "package:fitness/models/enums.dart";
import "package:fitness/services/dto.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";

class CreateProgramPage extends StatefulWidget {
  final ProgramBloc programBloc;

  const CreateProgramPage({
    super.key,
    required this.programBloc,
  });

  @override
  State<CreateProgramPage> createState() => _CreateProgramPageState();
}

class _CreateProgramPageState extends State<CreateProgramPage> {
  Complexity complexity = Complexity.easy;
  Specification specification = Specification.arms;

  void create(BuildContext context) async {
    final UserState userState = GetIt.instance.get<UserBloc>().state;
    final ProgramState programsState = widget.programBloc.state;
    if (programsState is SuccessProgramsState &&
        userState is AuthenticatedUserState) {
      final CreateProgramDto dto = CreateProgramDto(
        authorId: userState.user.id,
        complexity: complexity,
        specification: specification,
      );
      widget.programBloc.add(CreateProgramEvent(dto: dto, context: context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Создание программы")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<Complexity>(
              value: complexity,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              onChanged: (Complexity? value) {
                setState(() {
                  complexity = value!;
                });
              },
              items: Complexity.values
                  .map<DropdownMenuItem<Complexity>>((Complexity complexity) {
                return DropdownMenuItem<Complexity>(
                  value: complexity,
                  child: Text(complexity.toString()),
                );
              }).toList(),
            ),
            DropdownButton<Specification>(
              value: specification,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              onChanged: (Specification? value) {
                setState(() {
                  specification = value!;
                });
              },
              items: Specification.values.map<DropdownMenuItem<Specification>>(
                  (Specification specification) {
                return DropdownMenuItem<Specification>(
                  value: specification,
                  child: Text(specification.toString()),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => create(context),
              child: const Text("Создать"),
            ),
          ],
        ),
      ),
    );
  }
}
