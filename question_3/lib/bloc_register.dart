import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_3/repositories/character_repository/character_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'state/blocs/character_bloc/character_bloc.dart';
import 'state/cubits/theme_cubit.dart';

class BlocRegister extends StatelessWidget {
  final Widget app;
  final SharedPreferences prefs;
  const BlocRegister({super.key, required this.app, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CharacterBloc(
            repository: context.read<CharacterRepository>(),
          ),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(
            prefs,
          ),
        ),
      ],
      child: app,
    );
  }
}
