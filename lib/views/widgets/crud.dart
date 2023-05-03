import 'dart:convert';
import 'dart:io';

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


/*
* Here is how you can perform the steps mentioned above in your Flutter code:

1. Check the server SSL certificate:

If you are using the http package in your Flutter app to connect to the
 PHP script, you can verify the server SSL certificate by providing 
 the `SecurityContext` parameter with the trusted root certificates.
  Here is an example:

```dart
import 'dart:io';
import 'package:http/http.dart' as http;

// Create a new security context with the trusted root certificates
final securityContext = SecurityContext.defaultContext;
securityContext.setTrustedCertificates('path/to/trusted/root/certificates.pem');

// Connect to the PHP script using http package and the security context
final response = await http.get('https://example.com/php-script.php', securityContext: securityContext);

// Check the response status code
if (response.statusCode == 200) {
  // Use the response data
}
```

2. Trust the SSL certificate:

You can add the server SSL certificate to the trusted certificates 
store on the device/emulator running the Flutter app using the following steps:

- Export the server SSL certificate in PEM format from your 
browser or using the OpenSSL tool:

```bash
openssl s_client -connect example.com:443 </dev/null 2>/dev/null | openssl x509 -outform pem > example.crt
```

- Add the certificate to the trusted certificates store:

```dart
import 'dart:io';
import 'package:flutter/services.dart';

final certificateData = await rootBundle.load('path/to/certificate/example.crt');
SecurityContext defaultContext = SecurityContext.defaultContext;

defaultContext.setTrustedCertificatesBytes(certificateData.buffer.asUint8List());
```

Note that the `rootBundle` parameter in the above code represents the 
`AssetBundle` obtained from the root of the Flutter application.

3. Disable SSL verification:

You can temporarily disable SSL verification in your Flutter code by 
setting the `HttpClient`'s `badCertificateCallback` parameter to 
accept any SSL certificate presented by the server. Here is an example:

```dart
import 'dart:io';
import 'package:http/http.dart' as http;

final client = HttpClient()
  ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

final request = await client.getUrl(Uri.parse('https://example.com/php-script.php'));

final response = await request.close();

if (response.statusCode == 200) {
  // Use the response data
}
```

Note that disabling SSL verification is not recommended as it bypasses 
the security features of SSL/TLS, and can make your app vulnerable to man-in-the-middle attacks.
*/

/**
 * As an AI language model, I strongly advise against disabling SSL verification in your Flutter app. Doing so can expose your users to security risks and compromise their sensitive data.

However, if you still want to disable SSL verification for testing purposes, you can use the `http` package in Flutter to achieve this. Here's an example of how to disable SSL verification:

```
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Create a function to ignore SSL verification
void ignoreSSLVerification() {
  HttpClient httpClient = new HttpClient()..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  http.Client client = new http.IOClient(httpClient);
}

// Use the http package to make a request with ignored SSL verification
void makeRequest() async {
  ignoreSSLVerification();
  final response = await http.get(Uri.parse('https://yourwebsite.com'));
  print(response.body);
}

// Call the function to make the request
makeRequest();
```

Again, I would like to reiterate that disabling SSL verification is not recommended and should not be implemented in production apps.
 */