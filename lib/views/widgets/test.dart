import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/links.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food recipe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const DataFromApi(),
    );
  }
}

class DataFromApi extends StatefulWidget {
  const DataFromApi({super.key});

  @override
  _DataFromApiState createState() => _DataFromApiState();
}

class _DataFromApiState extends State<DataFromApi> {
  Future<List<Data>> getData() async {
    var response =
        // await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
        await http.get(Uri.https(linkViewNotes));
    var jsonData = jsonDecode(response.body);
    List<Data> dataList = [];
    for (var u in jsonData) {
      // Data data = Data(u["name"], u["phone"], u["email"]);
      Data data = Data(u["notes_id"], u["notes_title"], u["notes_content"]);
      dataList.add(data);
    }
    if (kDebugMode) {
      print(dataList.length);
    }
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Data Fetch"),
        ),
        body: Container(
          child: Card(
            child: FutureBuilder<List<Data>>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: const Text("Loading"),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: Column(
                            children: [
                              Text(snapshot.data![i].notes_id),
                              Text(snapshot.data![i].notes_title),
                              Text(snapshot.data![i].notes_content),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ));
  }
}

class Data {
  final String notes_id, notes_title, notes_content;

  Data(this.notes_id, this.notes_title, this.notes_content);
}
