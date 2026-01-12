import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextFieldStyle(){
    return TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Poppins'
    );
  }
  static TextStyle HeadlineTextFieldStyle() {
    return TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins'
    );
  }
    static TextStyle LightTextFieldStyle() {
      return TextStyle(
          color: Colors.black54,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins'
      );
    }
    static TextStyle semiBoldTextField(){
    return TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins'
    );
    }
}
