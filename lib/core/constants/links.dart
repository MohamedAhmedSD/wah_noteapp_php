const String linkServerName =
    "http://10.0.2.2/ecommerce"; //? emulator, local host

const String linkServerName2 =
    "http://127.0.0.1/ecommerce/"; //? local host, may add port

const String linkServerName3 =
    "http://192.168.43.211/ecommerce"; //? ipconfig, wifi =====

const String linkServerName4 =
    "http://http://185.27.134.10/ecommerce"; //? outer server full =====

const String linkServerName5 =
    "https://sheikh.great-site.net/ecommerce"; //? domain name ===== may https

//! [1]auth
const String linkSignUp = "$linkServerName3/wah/note_app/auth/signup.php";
const String linkLogin = "$linkServerName3/wah/note_app/auth/login.php";

//! [2] Note
const String linkViewNotes = "$linkServerName3/wah/note_app/crud/view.php";
const String linkAddNotes = "$linkServerName3/wah/note_app/crud/add.php";
const String linkEditNotes = "$linkServerName3/wah/note_app/crud/edit.php";
const String linkDeleteNotes = "$linkServerName3/wah/note_app/crud/delete.php";

/*
 * To disable SSL/TLS verification temporarily in your Flutter app, 
 * you can set the `HttpClient` `badCertificateCallback` property to ignore all
 *  the SSL/TLS errors. Here's how you can do it:

import 'dart:io';

var client = HttpClient();
// Temporarily disable SSL/TLS verification
client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

// Make your request as usual
var request = await client.getUrl(Uri.parse(url));
var response = await request.close();

// Don't forget to restore SSL/TLS verification once you're done with testing
client.badCertificateCallback = null;

Note that disabling SSL/TLS verification can make your app vulnerable to man-in-the-middle attacks, and it's not recommended to use this in production apps. 
 */

