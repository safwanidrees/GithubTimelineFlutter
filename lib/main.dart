import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_flutter/routes/application.dart';
import 'package:github_flutter/routes/routes.dart';
import 'package:github_flutter/utils/theme.dart';
import 'package:provider/provider.dart';

import 'core/bloc/github_bloc/github_bloc.dart';
import 'core/bloc/theme_bloc/theme_bloc.dart';

void main() async {
  await dotenv.load();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (ctx) => GithubBloc()),
    ChangeNotifierProvider(create: (ctx) => ThemeBloc())
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  void initState() {
    context.read<ThemeBloc>().getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeBloc>(
      builder: (context, value, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.themeData(value.darkTheme, context),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
