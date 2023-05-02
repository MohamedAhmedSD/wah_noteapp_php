import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text("تم انشاء الحساب بنجاح الان يمكنك تسجيل الدخول"),
          ),
          const SizedBox(
            height: 16,
          ),
          MaterialButton(
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              // there are different between =>
              // pushAndRemoveUntil && pushNamedAndRemoveUntil
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            child: const Text("تسحيل الدخول"),
          )
        ],
      ),
    );
  }
}
