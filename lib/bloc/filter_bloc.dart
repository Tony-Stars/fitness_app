import "package:fitness/utils/filter.dart";
import "package:fitness/models/enums.dart";
import "package:flutter_bloc/flutter_bloc.dart";

abstract class FilterEvent {
  const FilterEvent();
}

class UpdateComplexityEvent extends FilterEvent {
  final Complexity complexity;
  const UpdateComplexityEvent({required this.complexity});
}

class UpdateSpecificationEvent extends FilterEvent {
  final Specification specification;
  const UpdateSpecificationEvent({required this.specification});
}

class FilterBloc extends Bloc<FilterEvent, Filter> {
  FilterBloc() : super(const Filter()) {
    on<UpdateComplexityEvent>(_onUpdateComplexity);
    on<UpdateSpecificationEvent>(_onUpdateSpecification);
  }

  void _onUpdateComplexity(
    UpdateComplexityEvent event,
    Emitter<Filter> emit,
  ) {
    final filter = state;
    final complexities = filter.complexities;
    final complexity = event.complexity;

    if (complexities.contains(complexity)) {
      emit(filter.copyWith(
          complexities: complexities.where((c) => c != complexity).toList()));
    } else {
      emit(filter.copyWith(complexities: [...complexities, complexity]));
    }
  }

  void _onUpdateSpecification(
    UpdateSpecificationEvent event,
    Emitter<Filter> emit,
  ) {
    final filter = state;
    final specifications = filter.specifications;
    final specification = event.specification;

    if (specifications.contains(specification)) {
      emit(filter.copyWith(
          specifications:
              specifications.where((c) => c != specification).toList()));
    } else {
      emit(filter.copyWith(specifications: [...specifications, specification]));
    }
  }
}
