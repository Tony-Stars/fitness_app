import "package:fitness/models/workout.dart";
import "package:fitness/services/workout_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

abstract class WorkoutEvent {
  final BuildContext context;

  const WorkoutEvent({
    required this.context,
  });
}

class GetByProgramEvent extends WorkoutEvent {
  final String programId;

  const GetByProgramEvent({
    required this.programId,
    required super.context,
  });
}

class CreateWorkoutEvent extends WorkoutEvent {
  final String programId;

  const CreateWorkoutEvent({
    required this.programId,
    required super.context,
  });
}

class DeleteWorkoutEvent extends WorkoutEvent {
  final String id;

  const DeleteWorkoutEvent({
    required this.id,
    required super.context,
  });
}

abstract class WorkoutState {
  const WorkoutState();
}

class LoadingWorkoutState extends WorkoutState {
  const LoadingWorkoutState();
}

class SuccessWorkoutState extends WorkoutState {
  final List<Workout> workouts;
  const SuccessWorkoutState({required this.workouts});
}

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutService _workoutService = GetIt.instance.get<WorkoutService>();

  WorkoutBloc() : super(const SuccessWorkoutState(workouts: [])) {
    on<GetByProgramEvent>(_getByProgram);
    on<CreateWorkoutEvent>(_create);
    on<DeleteWorkoutEvent>(_delete);
  }
  Future<void> _getByProgram(
      GetByProgramEvent event, Emitter<WorkoutState> emit) async {
    try {
      final workouts = await _workoutService.getByProgram(event.programId);
      emit(SuccessWorkoutState(workouts: workouts));
    } catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 5),
          content: Text("Ошибка!"),
        ),
      );
      rethrow;
    }
  }

  Future<void> _create(
      CreateWorkoutEvent event, Emitter<WorkoutState> emit) async {
    try {
      final workout = await _workoutService.create(event.programId);
      if (state is SuccessWorkoutState) {
        emit(SuccessWorkoutState(
          workouts: [...(state as SuccessWorkoutState).workouts, workout],
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 5),
          content: Text("Ошибка!"),
        ),
      );
      rethrow;
    }
  }

  Future<void> _delete(
      DeleteWorkoutEvent event, Emitter<WorkoutState> emit) async {
    try {
      await _workoutService.delete(event.id);
      if (state is SuccessWorkoutState) {
        emit(
          SuccessWorkoutState(
            workouts: (state as SuccessWorkoutState)
                .workouts
                .where((Workout workout) => workout.id != event.id)
                .toList(),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 5),
          content: Text("Ошибка!"),
        ),
      );
      rethrow;
    }
  }
}
