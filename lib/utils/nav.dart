import 'package:flutter/material.dart';

class nav {
  static void goToWelcome(BuildContext context) {
    Navigator.pushNamed(context, "/Welcome");
  }
  static void goToLogin(BuildContext context){
    Navigator.pushNamed(context, "/Login");
  }

  static void goToRegister(BuildContext context){
    Navigator.pushNamed(context, "/Register");
  }
  static void goToMenu(BuildContext context){
    Navigator.pushNamed(context, "/Menu");
  }
  static void goToFeeding(BuildContext context){
    Navigator.pushNamed(context, "/Feeding");
  }
  static void goToProfile(BuildContext context){
    Navigator.pushNamed(context, "/Profile");
  }
  static void goToResPassword(BuildContext context){
    Navigator.pushNamed(context, "/resPass");
  }
}