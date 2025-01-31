import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_3/repository_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc_register.dart';
import 'helpers/http_overrides.dart';
import 'routes/router.dart';
import 'state/cubits/theme_cubit.dart';
import 'static/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final appRouter = AppRouter();

  var appConfig = RepositoriesRegister(
    appBlocs: BlocRegister(
      prefs: prefs,
      app: MyApp(
        appRouter: appRouter,
      ),
    ),
  );

  //Development purposes only: I Used MyHttpOverrides to bypass SSL issues
  HttpOverrides.global = MyHttpOverrides();
  runApp(appConfig);
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  const MyApp({
    super.key,
    required this.appRouter,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, AppThemeMode>(
      builder: (context, appThemeMode) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Rick & Morty',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: appThemeMode == AppThemeMode.light
              ? ThemeMode.light
              : ThemeMode.dark,
          routerDelegate: widget.appRouter.delegate(),
          routeInformationParser: widget.appRouter.defaultRouteParser(),
        );
      },
    );
  }
}
