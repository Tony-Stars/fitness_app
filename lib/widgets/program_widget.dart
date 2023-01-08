import "package:fitness/utils/app_router.dart";
import "package:fitness/bloc/programs_bloc.dart";
import "package:fitness/models/program.dart";
import "package:fitness/pages/program_page.dart";
import "package:fitness/services/screen_service.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";

class ProgramWidget extends StatelessWidget {
  final Program program;

  const ProgramWidget({
    super.key,
    required this.program,
  });

  final textStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(180, 0, 0, 0));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(AppPage.program,
            arguments: ProgramPage(program: program)),
        onLongPress: () => GetIt.instance
            .get<ProgramBloc>()
            .add(DeleteProgramEvent(id: program.id, context: context)),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: program.complexity.color.withOpacity(0.8),
          ),
          child: SizedBox(
              width: double.infinity,
              height: GetIt.instance.get<ScreenService>().size != null
                  ? GetIt.instance.get<ScreenService>().size!.height / 5
                  : 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          program.specification.toString(),
                          style: textStyle,
                        ),
                        Text(
                          program.complexity.toString(),
                          style: textStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
