import 'package:flutter/material.dart';
import 'package:noteapp_php/auth/success.dart';
import 'package:noteapp_php/views/screens/home.dart';
import 'package:noteapp_php/views/screens/notess/add.dart';
import 'package:noteapp_php/views/screens/notess/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login.dart';
import 'auth/signup.dart';

//? ============ call shared prefs ==================
//* global
late SharedPreferences sharedPref;
//* 1 aync
void main() async {
  //* 2.
  WidgetsFlutterBinding.ensureInitialized();
  //* 3.
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

//? ============ call shared prefs ==================
//* aim => connect flutter with php =================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course php rest api',

      //! we determain initial route by SP =>
      //* if there any data in id key go to home page ==================
      initialRoute: sharedPref.getString("id") == null ? "login" : "home",

      // home: SignUp(),
      routes: {
        // if you use /login => navigator not work
        "login": (context) => const Login(),
        "signup": (context) => const SignUp(),
        "home": (context) => const Home(),
        "success": (context) => const Success(),
        "add": (context) => const AddNotes(),
        "edit": (context) => EditNotes(),
      },
    );
  }
}
