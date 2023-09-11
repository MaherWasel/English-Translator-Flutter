
import 'package:flutter/material.dart';
import 'package:translator/StartingAppScreen.dart';
void main() {

  runApp( App());
}

class App extends StatelessWidget {
   App({super.key});

  ThemeData theme= ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: StartingAppScreen()
    );
  }
}