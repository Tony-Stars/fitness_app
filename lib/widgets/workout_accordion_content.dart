import "package:fitness/bloc/activity_bloc.dart";
import "package:fitness/bloc/workout_bloc.dart";
import "package:fitness/models/activity.dart";
import "package:fitness/models/workout.dart";
import "package:fitness/widgets/activity_tile.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class WorkoutAccordionContent extends StatelessWidget {
  final Workout workout;
  final bool isAuthor;

  const WorkoutAccordionContent({
    super.key,
    required this.workout,
    required this.isAuthor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityState>(builder: (context, state) {
      if (state is SuccessActivityState) {
        return Column(
          children: [
            ...state.activities.map((Activity activity) {
              return ActivityTile(
                activityCubit: context.read<ActivityBloc>(),
                activity: activity,
              );
            }),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  right: 20.0,
                ),
                child: GestureDetector(
                  onTap: (() {
                    context.read<WorkoutBloc>().add(
                        DeleteWorkoutEvent(id: workout.id, context: context));
                  }),
                  child: const Icon(Icons.delete_outline_outlined),
                ),
              ),
            ),
          ],
        );
      }
      return const SizedBox.shrink();
    });
  }
}
