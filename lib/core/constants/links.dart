const String linkServerName =
    "http://10.0.2.2/ecommerce"; //? emulator, local host

const String linkServerName2 =
    "http://127.0.0.1/ecommerce/"; //? local host, may add port

const String linkServerName3 =
    "http://192.168.43.211/ecommerce"; //? ipconfig, wifi =====

//! [1]auth
const String linkSignUp = "$linkServerName3/wah/note_app/auth/signup.php";
const String linkLogin = "$linkServerName3/wah/note_app/auth/login.php";

//! [2] Note
const String linkViewNotes = "$linkServerName3/wah/note_app/crud/view.php";
const String linkAddNotes = "$linkServerName3/wah/note_app/crud/add.php";
const String linkEditNotes = "$linkServerName3/wah/note_app/crud/edit.php";
const String linkDeleteNotes = "$linkServerName3/wah/note_app/crud/delete.php";
