import "package:fitness/models/program.dart";
import "package:fitness/services/dto.dart";
import "package:fitness/services/program_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

class SearchEvent {
  final SearchDto dto;
  final BuildContext context;

  const SearchEvent({
    required this.dto,
    required this.context,
  });
}

abstract class SearchState {}

class LoadingSearchState extends SearchState {}

class SuccessSearchState extends SearchState {
  List<Program> programs;
  SuccessSearchState({required this.programs});
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProgramService _programsService = GetIt.instance.get<ProgramService>();

  SearchBloc() : super(SuccessSearchState(programs: [])) {
    on<SearchEvent>(_search);
  }

  Future<void> _search(SearchEvent event, Emitter<SearchState> emit) async {
    try {
      final programs = await _programsService.select(event.dto);
      emit(SuccessSearchState(programs: programs));
    } catch (e) {
      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text("Search Error!"),
        ),
      );
      rethrow;
    }
  }
}
