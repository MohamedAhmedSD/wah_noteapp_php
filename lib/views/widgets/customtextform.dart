import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hint;
  final TextEditingController mycontroller;
  final String? Function(String?) valid; // data type of validator
  const CustomTextForm(
      {super.key,
      required this.hint,
      required this.mycontroller,
      required this.valid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
