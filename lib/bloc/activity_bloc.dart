import "package:fitness/models/activity.dart";
import "package:fitness/services/activity_service.dart";
import "package:fitness/services/dto.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

abstract class ActivityEvent {
  final BuildContext context;

  const ActivityEvent({
    required this.context,
  });
}

class GetByWorkoutEvent extends ActivityEvent {
  final String programId;

  GetByWorkoutEvent({
    required super.context,
    required this.programId,
  });
}

class CreateActivityEvent extends ActivityEvent {
  final CreateActivityDto dto;

  const CreateActivityEvent({
    required super.context,
    required this.dto,
  });
}

class UpdateActivityEvent extends ActivityEvent {
  final Activity dto;

  const UpdateActivityEvent({
    required super.context,
    required this.dto,
  });
}

class DeleteActivityEvent extends ActivityEvent {
  final String id;

  const DeleteActivityEvent({
    required super.context,
    required this.id,
  });
}

abstract class ActivityState {
  const ActivityState();
}

class LoadingActivityState extends ActivityState {
  const LoadingActivityState();
}

class SuccessActivityState extends ActivityState {
  final List<Activity> activities;
  const SuccessActivityState({required this.activities});
}

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityService _activityService =
      GetIt.instance.get<ActivityService>();

  ActivityBloc() : super(const SuccessActivityState(activities: [])) {
    on<GetByWorkoutEvent>(_getByWorkout);
    on<CreateActivityEvent>(_create);
    on<UpdateActivityEvent>(_update);
    on<DeleteActivityEvent>(_delete);
  }

  Future<void> _getByWorkout(
      GetByWorkoutEvent event, Emitter<ActivityState> emit) async {
    try {
      final activities = await _activityService.getByWorkout(event.programId);
      emit(SuccessActivityState(activities: activities));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _create(
      CreateActivityEvent event, Emitter<ActivityState> emit) async {
    try {
      final activity = await _activityService.create(event.dto);
      if (state is SuccessActivityState) {
        emit(SuccessActivityState(
          activities: [...(state as SuccessActivityState).activities, activity],
        ));
        ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 5),
          content: Text("Добавлено"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 5),
        content: Text("Ошибка!"),
      ));
      rethrow;
    }
  }

  Future<void> _update(
      UpdateActivityEvent event, Emitter<ActivityState> emit) async {
    try {
      if (state is SuccessActivityState && event.dto.id != null) {
        final activity =
            await _activityService.update(event.dto.id!, event.dto);
        final updated = (state as SuccessActivityState).activities.map((a) {
          if (a.id == event.dto.id) {
            return activity;
          }
          return a;
        }).toList();
        emit(SuccessActivityState(activities: updated));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _delete(
      DeleteActivityEvent event, Emitter<ActivityState> emit) async {
    try {
      await _activityService.delete(event.id);
      if (state is SuccessActivityState) {
        emit(
          SuccessActivityState(
            activities: (state as SuccessActivityState)
                .activities
                .where((Activity activity) => activity.id != event.id)
                .toList(),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
