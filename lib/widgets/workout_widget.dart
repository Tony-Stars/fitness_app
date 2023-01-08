import "package:fitness/utils/app_router.dart";
import "package:fitness/bloc/workout_bloc.dart";
import "package:fitness/models/workout.dart";
import "package:fitness/pages/workout_page.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class WorkoutWidget extends StatelessWidget {
  final Workout workout;
  final bool isAuthor;
  final String name;

  const WorkoutWidget({
    super.key,
    required this.workout,
    required this.isAuthor,
    required this.name,
  });

  final textStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(180, 0, 0, 0));

  void toWorkoutPage(BuildContext context, Workout workout, String name) {
    Navigator.of(context).pushNamed(AppPage.workout,
        arguments: WorkoutPage(
          workout: workout,
          isAuthor: isAuthor,
          name: name,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onLongPress: () => context
            .read<WorkoutBloc>()
            .add(DeleteWorkoutEvent(id: workout.id, context: context)),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Text(name),
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_right_outlined),
                  onPressed: () => toWorkoutPage(context, workout, name),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
