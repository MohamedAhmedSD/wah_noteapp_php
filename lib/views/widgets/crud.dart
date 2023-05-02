import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//? we need convert lib to deal with json =========

class Crud {
  //* 2 functions
  //* deal with Get && Post request

  //! [1]
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));

      //* connect and page is found

      if (response.statusCode == 200) {
        //* decode json into dart
        var responsebody = jsonDecode(response.body);
        if (kDebugMode) {
          print(responsebody);
        }
        return responsebody; //! to take it, to use later =====
      } else {
        if (kDebugMode) {
          print("Error ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

//! [2]
//? post, path and Map
//* it same as get but need to pass DATA
//! DATA == our request and its values

  postRequest(String url, Map data) async {
    // postRequest(url, data) async {
    // data == name of our requets
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (kDebugMode) {
        print(response);
      }

      //* connect and page is found

      if (response.statusCode == 200) {
        //* decode json into dart
        var responsebody = jsonDecode(response.body);
        if (kDebugMode) {
          print(responsebody);
        }

        return responsebody; // to take it
      } else {
        if (kDebugMode) {
          print("Error ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
