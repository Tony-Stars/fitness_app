import "package:accordion/accordion.dart";
import "package:fitness/bloc/filter_bloc.dart";
import "package:fitness/bloc/search_bloc.dart";
import "package:fitness/bloc/user_bloc.dart";
import "package:fitness/utils/filter.dart";
import "package:fitness/models/enums.dart";
import "package:fitness/models/program.dart";
import "package:fitness/services/dto.dart";
import "package:fitness/widgets/complexity_tile.dart";
import "package:fitness/widgets/program_widget.dart";
import "package:fitness/widgets/specification_tile.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  void submit(BuildContext context) {
    final userState = GetIt.instance.get<UserBloc>().state;
    if (userState is AuthenticatedUserState) {
      final filter = context.read<FilterBloc>().state;
      final dto = SearchDto(userId: userState.user.id, filter: filter);
      BlocProvider.of<SearchBloc>(context)
          .add(SearchEvent(dto: dto, context: context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Accordion(
          paddingListTop: 20,
          paddingListBottom: 0,
          children: [
            AccordionSection(
              header: const Text("Критерии"),
              content:
                  BlocBuilder<FilterBloc, Filter>(builder: (context, state) {
                return Column(
                  children: [
                    const Text("Сложность"),
                    ...Complexity.values.map((Complexity complexity) {
                      return ComplexityTile(
                        complexity: complexity,
                      );
                    }),
                    Divider(
                      color: Theme.of(context).primaryColor,
                    ),
                    const Text("Группа мышц"),
                    ...Specification.values.map((Specification specification) {
                      return SpecificationTile(
                        specification: specification,
                      );
                    }),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () => submit(context),
                        child: const Text("Применить"),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
        BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          if (state is SuccessSearchState) {
            return Column(
              children: state.programs.map((Program program) {
                return ProgramWidget(program: program);
              }).toList(),
            );
          } else if (state is LoadingSearchState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //  else if (state is ErrorSearchState) {
          //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //     duration: Duration(seconds: 5),
          //     content: Text('Error!'),
          //   ));
          // }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
