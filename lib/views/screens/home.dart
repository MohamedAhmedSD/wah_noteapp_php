import 'package:flutter/material.dart';
import 'package:noteapp_php/main.dart';
import 'package:noteapp_php/views/screens/notess/edit.dart';
import 'package:noteapp_php/views/widgets/cardnotes.dart';
import 'package:noteapp_php/views/widgets/crud.dart';

import '../../core/constants/links.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// use mixin with our Crud
class _HomeState extends State<Home> with Crud {
  // Crud crud = Crud();
  // function use links pf view php,
  getNotes() async {
    var response = await postRequest(
        linkViewNotes,
        //! data
        // to see only your notes
        // by call id from sharedpref
        {"id": sharedPref.getString("id")});
    //   print(response);
    return response; //! don't forget it
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          //? ============== exit btn ======================
          //* clear our shared prefs + nav to login page ===
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("add", (route) => false);
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  FutureBuilder(
                      //! if we use empty list as initialData =>
                      //? 'Future<dynamic>' is not a subtype of type 'Future<List<dynamic>>?'
                      // initialData: const [],
                      future: getNotes(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data != null && snapshot.hasData) {
                          // we need this line :::::::::::::::
                          if (snapshot.data['status'] == 'fail') {
                            return const Center(
                                child: Text(
                              "there are no notes",
                              style: TextStyle(fontSize: 20),
                            ));
                          }

                          // print("has data");

                          return ListView.builder(
                              //! becarfull => length not lenght
                              itemCount: snapshot.data['data'].length,
                              // itemCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                return CardNote(
                                  onDelete: () async {
                                    //! we write onDelete function core code here
                                    var response = await postRequest(
                                        linkDeleteNotes, {
                                      "id": snapshot.data['data'][i]['notes_id']
                                          .toString()
                                    });
                                    if (response["status"] == "success") {
                                      Navigator.of(context)
                                          .pushReplacementNamed("home");
                                    }
                                  },
                                  onTap: () async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditNotes(
                                          notes: snapshot.data["data"][i],
                                        ),
                                      ),
                                    );
                                  },
                                  title:
                                      "${snapshot.data['data'][i]['notes_title']}",
                                  content:
                                      "${snapshot.data['data'][i]['notes_content']}",
                                );
                              });

                          // return Text("${snapshot.data!['data'][0]['notes_title']}");
                          // return const Text("jjj");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: Text("Loading"));
                        }
                        return const Text("not connected to xampp server");
                        // return const Center(child: Text("Lpading"));
                      }),
                ],
              ),
            ),
    );
  }
}
