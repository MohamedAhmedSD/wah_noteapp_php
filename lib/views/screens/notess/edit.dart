import 'package:flutter/material.dart';
import 'package:noteapp_php/core/constants/links.dart';
import 'package:noteapp_php/views/widgets/crud.dart';
import 'package:noteapp_php/views/widgets/customtextform.dart';

import '../../../core/functions/valid.dart';

class EditNotes extends StatefulWidget {
  //! we add to constructor => notes to reach to certain notes data by it
  final notes;
  EditNotes({super.key, this.notes});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

//! if not use with Crud mixins => You will build all Crud here
class _EditNotesState extends State<EditNotes> with Crud {
  //
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;

  editNotes() async {
    if (formstate.currentState!.validate()) ;
    isLoading = true;
    setState(() {});

    // var response = await postRequest(linkEditNotes, {});
    var response = await postRequest(linkEditNotes, {
      "title": title.text,
      "content": content.text,
      //! we need notes_id => it int => convert into String
      "id": widget.notes["notes_id"].toString()
    });
    isLoading = false;
    setState(() {});
    if (response["status"] == "success") {
      Navigator.of(context).pushReplacementNamed("home");
    } else {}
  }

  @override
  void initState() {
    //! we should start controller and there recive data from home page on start
    title.text = widget.notes["notes_title"];
    content.text = widget.notes["notes_content"];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Notes"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formstate,
          child: ListView(children: [
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
                await editNotes();
              },
              child: Text("Save"),
              textColor: Colors.white,
              color: Colors.blue,
            ),
          ]),
        ),
      ),
    );
  }
}
