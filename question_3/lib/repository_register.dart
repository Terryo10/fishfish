import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/character_repository/character_provider.dart';
import 'repositories/character_repository/character_repository.dart';

class RepositoriesRegister extends StatelessWidget {
  final Widget appBlocs;

  const RepositoriesRegister({
    super.key,
    required this.appBlocs,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              CharacterRepository(provider: CharacterProvider()),
        )
      ],
      child: appBlocs,
    );
  }
}
