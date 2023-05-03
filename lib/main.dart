import 'package:flutter/material.dart';
import 'package:noteapp_php/auth/success.dart';
import 'package:noteapp_php/views/screens/home.dart';
import 'package:noteapp_php/views/screens/notess/add.dart';
import 'package:noteapp_php/views/screens/notess/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login.dart';
import 'auth/signup.dart';

//! ================ [Not Work If] ===================
//* not open wifi and XAmpp ==========================
//? ============ call shared prefs ==================
//* global
late SharedPreferences sharedPref;
//* 1 aync
void main() async {
  //* 2.
  WidgetsFlutterBinding.ensureInitialized();
  //* 3.
  sharedPref = await SharedPreferences.getInstance();

// ByteData data = await rootBundle.load('assets/raw/certificate.cer');
// SecurityContext context = SecurityContext.defaultContext;
// context.setTrustedCertificatesBytes(data.buffer.asUint8List());
// // If your certificate is self-signed then uncomment the following line
// // context.setClientAuthoritiesBytes(data.buffer.asUint8List());

// // Create a new HTTP client with the security context
// final httpClient = HttpClient(context: context);
// final ioClient = IOClient(httpClient);

// // Use the client to make the request
// final response = await ioClient.get(Uri.parse('https://sheikh.great-site.net/'));

// // Close the client when done
// ioClient.close();

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

/**
 * Here is the updated code:

```
ByteData data = await rootBundle.load('assets/raw/certificate.cer');
SecurityContext context = SecurityContext.defaultContext;
context.setTrustedCertificatesBytes(data.buffer.asUint8List());
// If your certificate is self-signed then uncomment the following line
// context.setClientAuthoritiesBytes(data.buffer.asUint8List());

// Create a new HTTP client with the security context
final httpClient = HttpClient(context: context);
final ioClient = IOClient(httpClient);

// Use the client to make the request
final response = await ioClient.get(Uri.parse('https://sheikh.great-site.net/'));

// Close the client when done
ioClient.close();
```

Explanation:
- We use `setTrustedCertificatesBytes` to set the server's SSL certificate as trusted. If your certificate is self-signed, you can also use `setClientAuthoritiesBytes` to identify the certificate as a client certificate.
- We create the `httpClient` with the `context` that contains the trusted certificate.
- We use `ioClient` to make the request instead of `client` as it is not defined in the code.
- Finally, remember to close the `ioClient` when you are done with the request.
 */