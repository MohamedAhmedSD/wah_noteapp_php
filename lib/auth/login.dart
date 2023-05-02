import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:noteapp_php/core/constants/links.dart';
import 'package:noteapp_php/main.dart';
import 'package:noteapp_php/views/widgets/crud.dart';
import 'package:noteapp_php/views/widgets/customtextform.dart';

import '../core/functions.dart/valid.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //* TFF
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  //* form key
  GlobalKey<FormState> formstate = GlobalKey();
  //* Crud
  Crud crud = Crud();
  //* loading
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  //?================ form ==========================
                  Form(
                      key: formstate,
                      child: Column(
                        children: [
                          Image.asset("assets/logo.jpg"),
                          CustomTextForm(
                            valid: (val) {
                              return validInput(val!, 3, 20);
                            },
                            hint: 'email',
                            mycontroller: emailcontroller,
                          ),
                          CustomTextForm(
                            valid: (val) {
                              return validInput(val!, 3, 20);
                            },
                            hint: 'password',
                            mycontroller: passwordcontroller,
                          ),
                          // button
                          MaterialButton(
                            onPressed: () async {
                              // Navigator.of(context).pushNamed("home");
                              await login();
                            },
                            color: Colors.blue,
                            textColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            child: const Text("Login"),
                          ),
                          Container(
                            height: 10,
                          ),
                          InkWell(
                            child: const Text("Sign up"),
                            onTap: () {
                              Navigator.of(context).pushNamed("signup");

                              // Navigator.pushNamed(context, "signup");
                            },
                          )
                        ],
                      ))
                ],
              ),
            ),
    );
  }

  Future login() async {
    if (formstate.currentState!.validate()) {
      //* add loading
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(linkLogin, {
        //! don't forget .text => with controller
        'email': emailcontroller.text, "password": passwordcontroller.text
      });
      isLoading = false;
      setState(() {});
      if (response != null && response["status"] == "success") {
        //? ======= shared prefs =============
        //! we need save our login data
        //? sharedPref, hive, getstorage
        //* we use set, we need user id
        //? so we need bring it from db
        //* convert id to String

        sharedPref.setString(
            //! from db table, so login php should carry all user data on json
            "id",
            response["data"]["id"].toString()); //! assoc array on php

        sharedPref.setString("username", response["data"]["username"]);

        sharedPref.setString("email", response["data"]["email"]);
        //?=========================================

        if (!mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        //? ============= when field ===========
        if (!mounted) return;

        AwesomeDialog(
                // btnCancel: const Text("Cancel"),
                context: context,
                title: "تنبيه",
                body: const Text(
                    "البريد الالكتروني او كلمة السر خطأ او هذا الحساب غير موجود"))
            .show();
      }
    }
  }
}
