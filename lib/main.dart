import 'package:flutter/material.dart';
import 'package:todolist_app/auth_verify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todolist_app/firebase_options.dart';
import 'package:todolist_app/widgets/application.dart';

//import 'application.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(elevation: 0),
        useMaterial3: true,
      ),
      home: const MyApp(),
    ),
  );
}
