import 'package:dio/dio.dart';
import 'package:felix/common/blocs/create_map/create_map_bloc.dart';
import 'package:felix/common/blocs/get_bloc/get_bloc.dart';
import 'package:felix/common/blocs/sign_up/sign_up_bloc.dart';
import 'package:felix/common/models/map_model.dart';
import 'package:felix/common/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../features/splash/splash_page.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/sign_in/sign_in_bloc.dart';
import '../controller/provider/project_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProjectModel(),
      child: Builder(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(service: RestUser(Dio())),
            ),
            BlocProvider<SignUpBloc>(
              create: (context) => SignUpBloc(service: RestUser(Dio())),
            ),
            BlocProvider(
              create: (context) => CreatePostBloc(service: RestMap(Dio())),
            ),
            BlocProvider(
              create: (context) => GetBloc()..add(GetRequired()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: "K2D",
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: context.watch<ProjectModel>().locale,
            home: const SplashPage(),
          ),
        );
      }),
    );
  }
}
