import 'package:noteapp_php/core/constants/message.dart';

validInput(String val, int min, int max) {
  if (val.length > max) {
    return "$messageInputMax $max";
  }
  //* because we use 3 ifs
  //! empty should be before min
  //? to see it

  if (val.isEmpty) {
    return messageInputEmpty;
  }
  if (val.length < min) {
    return "$messageInputMin $min";
  }
}

//* you must make connection between validInput function
//? and signUp() function, to check before add data to db
