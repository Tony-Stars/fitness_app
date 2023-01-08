import "package:fitness/bloc/user_bloc.dart";
import "package:fitness/bloc/workout_bloc.dart";
import "package:fitness/models/program.dart";
import "package:fitness/models/workout.dart";
import "package:fitness/widgets/workout_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

class ProgramPage extends StatefulWidget {
  final Program program;

  const ProgramPage({
    super.key,
    required this.program,
  });

  @override
  State<ProgramPage> createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  List<Workout> workouts = [];

  void onPressedFAB(BuildContext context) {
    context.read<WorkoutBloc>().add(
        CreateWorkoutEvent(programId: widget.program.id, context: context));
  }

  bool isAuthor() {
    final UserState userState = GetIt.instance.get<UserBloc>().state;
    if (userState is AuthenticatedUserState) {
      return userState.user.id == widget.program.authorId;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutBloc>(
      create: (BuildContext context) => GetIt.instance.get<WorkoutBloc>()
        ..add(
            GetByProgramEvent(programId: widget.program.id, context: context)),
      child: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state is SuccessWorkoutState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.program.specification.toString()),
              ),
              body: Center(
                child: ListView.builder(
                  itemCount: state.workouts.length,
                  itemBuilder: ((context, index) {
                    return WorkoutWidget(
                      name: (index + 1).toString(),
                      workout: state.workouts[index],
                      isAuthor: isAuthor(),
                    );
                  }),
                ),
              ),
              floatingActionButton: isAuthor()
                  ? FloatingActionButton(
                      onPressed: () => onPressedFAB(context),
                      tooltip: "Добавить тренировку",
                      child: const Icon(Icons.add),
                    )
                  : null,
            );
          } else if (state is LoadingWorkoutState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const Scaffold();
          }
        },
      ),
    );
  }
}
