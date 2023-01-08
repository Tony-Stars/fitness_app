import "package:fitness/models/program.dart";
import "package:fitness/services/dto.dart";
import "package:fitness/services/program_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

abstract class ProgramEvent {
  final BuildContext context;

  const ProgramEvent({
    required this.context,
  });
}

class GetByAuthorEvent extends ProgramEvent {
  final String authorId;

  const GetByAuthorEvent({
    required this.authorId,
    required super.context,
  });
}

class CreateProgramEvent extends ProgramEvent {
  final CreateProgramDto dto;

  const CreateProgramEvent({
    required this.dto,
    required super.context,
  });
}

class DeleteProgramEvent extends ProgramEvent {
  final String id;

  const DeleteProgramEvent({
    required this.id,
    required super.context,
  });
}

abstract class ProgramState {
  const ProgramState();
}

class LoadingProgramsState extends ProgramState {}

class SuccessProgramsState extends ProgramState {
  final List<Program> programs;

  const SuccessProgramsState({required this.programs});
}

class ProgramBloc extends Bloc<ProgramEvent, ProgramState> {
  final ProgramService _programsService = GetIt.instance.get<ProgramService>();

  ProgramBloc() : super(const SuccessProgramsState(programs: [])) {
    on<GetByAuthorEvent>(_getByAuthor);
    on<CreateProgramEvent>(_create);
    on<DeleteProgramEvent>(_delete);
  }

  Future<void> _getByAuthor(
      GetByAuthorEvent event, Emitter<ProgramState> emit) async {
    try {
      final programs = await _programsService.getByAuthor(event.authorId);
      emit(SuccessProgramsState(programs: programs));
    } catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text("Get by author error!"),
        ),
      );
      rethrow;
    }
  }

  Future<void> _create(
      CreateProgramEvent event, Emitter<ProgramState> emit) async {
    try {
      final Program program = await _programsService.create(event.dto);
      if (state is SuccessProgramsState) {
        emit(SuccessProgramsState(
          programs: [...(state as SuccessProgramsState).programs, program],
        ));
        ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 3),
          content: Text("Добавлено"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text("Create error!"),
        ),
      );
      rethrow;
    }
  }

  Future<void> _delete(
      DeleteProgramEvent event, Emitter<ProgramState> emit) async {
    try {
      await _programsService.delete(event.id);
      if (state is SuccessProgramsState) {
        emit(
          SuccessProgramsState(
            programs: (state as SuccessProgramsState)
                .programs
                .where((Program program) => program.id != event.id)
                .toList(),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text("Delete error!"),
        ),
      );
      rethrow;
    }
  }
}
