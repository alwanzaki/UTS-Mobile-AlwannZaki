import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/main_shell.dart';

void main() {
  runApp(const TokopediaCloneApp());
}

class TokopediaCloneApp extends StatelessWidget {
  const TokopediaCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tokopedia Clone',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const MainShell(),
    );
  }
}