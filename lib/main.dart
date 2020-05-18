import 'package:flutter/material.dart';
import 'package:github_flutter/providers/user_provider.dart';
import 'package:github_flutter/screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserProvider(),
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
       
          primarySwatch: Colors.blue,
       
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
