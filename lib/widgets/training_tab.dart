import "package:fitness/bloc/programs_bloc.dart";
import "package:fitness/widgets/program_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class TrainingTab extends StatefulWidget {
  const TrainingTab({super.key});

  @override
  State<TrainingTab> createState() => _TrainingTabState();
}

class _TrainingTabState extends State<TrainingTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramBloc, ProgramState>(
      builder: ((context, state) {
        if (state is LoadingProgramsState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SuccessProgramsState) {
          return ListView.builder(
              itemCount: state.programs.length,
              itemBuilder: (context, index) {
                return ProgramWidget(
                  program: state.programs[index],
                );
              });
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
