import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noteapp_php/core/functions/valid.dart';

import '../core/constants/links.dart';
import '../views/widgets/crud.dart';
import '../views/widgets/customtextform.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usercontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey();

//* crud instance
  final Crud _crud = Crud();
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
                  Form(
                      key: formstate,
                      child: Column(
                        children: [
                          Image.asset("assets/logo.jpg"),
                          CustomTextForm(
                            hint: 'user',
                            mycontroller: usercontroller,
                            valid: (val) {
                              return validInput(val!, 3, 20);
                            },
                          ),
                          CustomTextForm(
                            valid: (val) {
                              return validInput(val!, 10, 40);
                            },
                            hint: 'email',
                            mycontroller: emailcontroller,
                          ),
                          CustomTextForm(
                            valid: (val) {
                              return validInput(val!, 4, 20);
                            },
                            hint: 'password',
                            mycontroller: passwordcontroller,
                          ),
                          // button
                          MaterialButton(
                            onPressed: () async {
                              await signUp();
                            },
                            color: Colors.blue,
                            textColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            child: const Text("Sign up"),
                          ),
                          Container(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.of(context).pushReplacementNamed("login");
                              Navigator.pushNamed(context, "login");
                            },
                            child: const Text("Login"),
                          ),
                        ],
                      ))
                ],
              ),
            ),
    );
  }

//* to avoid build context problem, we but function under widget
//* with use => if (!mounted) return;

  //! use POST with => insert,update,delete
  signUp() async {
    //* connect or validator with db
    if (formstate.currentState!.validate()) {
      //* add loading
      isLoading = true;
      setState(() {});

      //! memic if there loading with delay
      // await Future.delayed(const Duration(seconds: 2));

      try {
        //! use POST with => insert,update,delete
        //* look how we assign => db column with => controller.text

        var response = await _crud.postRequest(linkSignUp, {
          "username": usercontroller.text,
          "email": emailcontroller.text,
          "password": passwordcontroller.text
        });
        isLoading = false;
        setState(() {});
        //! be carful check response is it null first !!! ===========
        if (response != null && response['status'] == "success") {
          if (!mounted) return;
          //* pushNamedAndRemoveUntil == remove all previous page from screen
          Navigator.of(context)
              .pushNamedAndRemoveUntil("success", (route) => false);
        } else {
          if (kDebugMode) {
            print("sign up failed");
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}
