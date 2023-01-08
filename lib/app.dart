import "package:fitness/bloc/filter_bloc.dart";
import "package:fitness/bloc/programs_bloc.dart";
import "package:fitness/bloc/search_bloc.dart";
import "package:fitness/bloc/user_bloc.dart";
import "package:fitness/pages/home_page.dart";
import "package:fitness/pages/login_page.dart";
import "package:fitness/services/screen_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

class FitnessApp extends StatefulWidget {
  const FitnessApp({super.key});

  @override
  State<FitnessApp> createState() => _FitnessAppState();
}

class _FitnessAppState extends State<FitnessApp> {
  @override
  void didChangeDependencies() {
    initApp(context);
    super.didChangeDependencies();
  }

  void initApp(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenService = GetIt.instance.get<ScreenService>();
    screenService.size = size;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<UserBloc>(),
      child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UnknownUserState) {
          return const LoginPage();
        } else if (state is AuthenticatedUserState) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<ProgramBloc>(
                create: (BuildContext context) =>
                    GetIt.instance.get<ProgramBloc>()
                      ..add(GetByAuthorEvent(
                        authorId: state.user.id,
                        context: context,
                      )),
              ),
              BlocProvider<FilterBloc>(
                create: (BuildContext context) =>
                    GetIt.instance.get<FilterBloc>(),
              ),
              BlocProvider<SearchBloc>(create: (BuildContext context) {
                return GetIt.instance.get<SearchBloc>();
              }),
            ],
            child: const HomePage(),
          );
        }
        return const Scaffold();
      }),
    );
  }
}
