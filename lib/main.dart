import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipeapp/views/dashBoard.dart';
import 'package:recipeapp/views/login_UI.dart';
import 'package:recipeapp/views/showRecipe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          accentColor: Colors.purpleAccent),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/showRecipe': (context) => ShowRecipe(),
        '/dashboard': (context) => DashBoard(),
      },
    );
  }
}
