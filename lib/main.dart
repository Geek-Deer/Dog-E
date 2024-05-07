import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doge/Screens/Login.dart';
import 'package:doge/Screens/Menu.dart';
import 'package:doge/Screens/Profile.dart';
import 'package:doge/Screens/Register.dart';
import 'package:doge/Screens/resPass.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:doge/Screens/Splash.dart';
import 'package:doge/Screens/Feeding.dart';
import 'package:flutter/services.dart';
import 'Screens/Welcome.dart';
import 'package:workmanager/workmanager.dart';



void callbackDispatcher(){
  Workmanager().executeTask((taskName, inputData){
    switch (taskName){

    }
    return Future.value(true);

  });
}


void main ()async{
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask("firstTask", "firstTask", frequency: Duration(minutes: 15), inputData: {"data1":"value1", "data2":"value2"});

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
  await Firebase.initializeApp();

  Timer myTimer = Timer.periodic(Duration(minutes: 5), (timer) {

  });

  runApp(MaterialApp(

    theme: ThemeData(
      fontFamily: 'Roboto',
      primarySwatch: Colors.orange,
    ),
    debugShowCheckedModeBanner: false,
    home: const Splash(),
    routes: routes,

  ));


}

var routes = <String,WidgetBuilder>{
  "/Welcome":(BuildContext context) => const WelcomeScreen(),
  "/Login":(BuildContext context) => const LoginScreen(),
  "/Register":(BuildContext context) => const RegisterScreen(),
  "/Menu":(BuildContext context) => const Menu(),
  "/Profile":(BuildContext context) => const ProfileScreen(),
  "/Feeding":(BuildContext context) => const FeedingScreen(),
  "/resPass":(BuildContext context) => const resPasswordScreen(),
};
