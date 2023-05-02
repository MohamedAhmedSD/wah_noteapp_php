import 'package:flutter/material.dart';
import 'package:noteapp_php/core/functions/valid.dart';
import 'package:noteapp_php/main.dart';
import 'package:noteapp_php/views/widgets/customtextform.dart';

import '../../../core/constants/links.dart';
import '../../widgets/crud.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

//! if not use with Crud mixins => You will build all Crud here
class _AddNotesState extends State<AddNotes> with Crud {
  //
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;
  //? why crud not call from its place on widgets

  addNotes() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequest(linkAddNotes, {
        "title": title.text,
        "content": content.text,
        "id": sharedPref.getString("id")
      });
      isLoading = false;
      setState(() {});
      if (response["status"] == "success") {
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        //! handle it ===================================
        // print("not add");
        // Navigator.of(context).pushReplacementNamed("home");
      }
      // return response;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formstate,
                child: ListView(children: [
                  //?========== avoid add empty notes ==================
                  CustomTextForm(
                      hint: "title",
                      mycontroller: title,
                      valid: (val) {
                        return validInput(val!, 1, 40);
                      }),
                  CustomTextForm(
                      hint: "content",
                      mycontroller: content,
                      valid: (val) {
                        return validInput(val!, 1, 255);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await addNotes();
                    },
                    child: Text("Add"),
                    textColor: Colors.white,
                    color: Colors.blue,
                  ),
                ]),
              ),
            ),
    );
  }
}
