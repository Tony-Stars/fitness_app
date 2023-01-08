import "package:fitness/utils/app_router.dart";
import "package:fitness/bloc/activity_bloc.dart";
import "package:fitness/models/workout.dart";
import "package:fitness/pages/create_activity_page.dart";
import "package:fitness/widgets/activity_tile.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

class WorkoutPage extends StatefulWidget {
  final Workout workout;
  final bool isAuthor;
  final String name;

  const WorkoutPage({
    super.key,
    required this.workout,
    required this.isAuthor,
    required this.name,
  });

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  Future<void> addActivity({required BuildContext widgetContext}) async {
    final ActivityBloc activityBloc = widgetContext.read<ActivityBloc>();
    Navigator.of(widgetContext).pushNamed(
      AppPage.createActivity,
      arguments: CreateActivityPage(
        activityBloc: activityBloc,
        workoutId: widget.workout.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActivityBloc>(
      create: (BuildContext context) => GetIt.instance.get<ActivityBloc>()
        ..add(
            GetByWorkoutEvent(context: context, programId: widget.workout.id)),
      child: BlocBuilder<ActivityBloc, ActivityState>(
        builder: ((context, state) {
          if (state is SuccessActivityState) {
            return Scaffold(
              appBar: AppBar(title: Text(widget.name)),
              body: ListView.builder(
                  itemCount: state.activities.length,
                  itemBuilder: (context, index) {
                    return ActivityTile(
                      activity: state.activities[index],
                      activityCubit: context.read<ActivityBloc>(),
                    );
                  }),
              floatingActionButton: widget.isAuthor
                  ? FloatingActionButton(
                      onPressed: () => addActivity(widgetContext: context),
                      tooltip: "Добавить упражнение",
                      child: const Icon(Icons.add),
                    )
                  : null,
            );
          } else if (state is LoadingActivityState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const Scaffold();
        }),
      ),
    );
  }
}
