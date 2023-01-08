import "package:dio/dio.dart";
import "package:fitness/bloc/activity_bloc.dart";
import "package:fitness/bloc/filter_bloc.dart";
import "package:fitness/bloc/programs_bloc.dart";
import "package:fitness/bloc/search_bloc.dart";
import "package:fitness/bloc/user_bloc.dart";
import "package:fitness/bloc/workout_bloc.dart";
import "package:fitness/services/activity_service.dart";
import "package:fitness/services/program_service.dart";
import "package:fitness/services/screen_service.dart";
import "package:fitness/services/user_service.dart";
import "package:fitness/services/workout_service.dart";
import "package:get_it/get_it.dart";

class ServiceLocator {
  static final _getIt = GetIt.instance;

  static void register() {
    ServiceLocator._registerServices();
    ServiceLocator._registerBlocs();
  }

  static void _registerServices() {
    _getIt.registerFactory<Dio>(() => Dio());
    _getIt.registerSingleton<UserService>(UserService());
    _getIt.registerSingleton<ProgramService>(ProgramService());
    _getIt.registerSingleton<WorkoutService>(WorkoutService());
    _getIt.registerSingleton<ActivityService>(ActivityService());
    _getIt.registerSingleton<ScreenService>(ScreenService());
  }

  static void _registerBlocs() {
    _getIt.registerSingleton<UserBloc>(UserBloc());
    _getIt.registerFactory<ProgramBloc>(() => ProgramBloc());
    _getIt.registerFactory<WorkoutBloc>(() => WorkoutBloc());
    _getIt.registerFactory<ActivityBloc>(() => ActivityBloc());
    _getIt.registerFactory<SearchBloc>(() => SearchBloc());
    _getIt.registerFactory<FilterBloc>(() => FilterBloc());
  }
}
