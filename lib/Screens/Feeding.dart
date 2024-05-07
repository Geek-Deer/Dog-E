import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:doge/utils/nav.dart';
import 'package:doge/utils/defaultWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class FeedingScreen extends StatefulWidget {
  const FeedingScreen({Key? key}) : super(key: key);

  @override
  State<FeedingScreen> createState() => _FeedingScreenState();
}

class _FeedingScreenState extends State<FeedingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  TextEditingController _totalController = TextEditingController();

  @override

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _totalController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) return 'Espacio requerido';
    if (int.parse(text) < 0 || int.parse(text) > 200 ) return 'Cantidad inválida';

    return null;
  }

  Future<bool> docExists(String docId)  async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('Dog-E_Database/data/feedings');

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  void addFood(TextEditingController tot) async{
    var collectionRef = FirebaseFirestore.instance.collection('Dog-E_Database/data/feedings');

    int month = DateTime.now().month;
    int day = DateTime.now().day;
    int can = int.parse(tot.text);

    bool aux = await docExists("$month$day");

    if(aux) {
      collectionRef.doc("$month$day").update({"total": FieldValue.increment(can)});
    } else{
      createDoc();
      collectionRef.doc("$month$day").update({"total": FieldValue.increment(can)});
    }
    var snack = SnackBar(content: Text("$can gramos agregados con éxito."), duration: Duration(seconds: 2), margin: EdgeInsets.all(10), backgroundColor: Colors.deepOrangeAccent, behavior: SnackBarBehavior.floating,);
    FirebaseFirestore.instance.collection('Dog-E_Database').doc("control_aux").update({'activated' : true, 'amount' : can});

    print(can);

    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void createDoc(){
    var collectionRef = FirebaseFirestore.instance.collection('Dog-E_Database/data/feedings');
    int month = DateTime.now().month;
    int day = DateTime.now().day;
      final docData = {
        "month": month,
        "day": day,
        "total": 0,
      };
      collectionRef.doc("$month$day").set(docData) .onError((e, _) => print("Error writing document: $e"));

  }

  void _printLatestValue() {
    print('Second text field: ${_totalController.text}');
  }

  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [

          Padding(
            padding: const EdgeInsets.only(top:200, left: 30, right: 30),
            child: Column(
              children: [
                Column(
                  children: [
                    Text("Control de alimentación:",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, fontFamily: "Roboto", color: Color(0xFFF18D2B))),
                  ],
                ),
                SizedBox(height:50),
                TextField(controller: _totalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorText: _errorText,
                hintText: "0",
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xFFB3C5D1),
                    width: 1,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    borderSide: BorderSide(
                      color: Color(0xFFBEC5D1),
                    )
                ),
                hintStyle: const TextStyle(
                  color: Color(0xFFBABABA),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
                SizedBox(height: 50),
                defMatButton(context, "Enviar", (){
                  if(_totalController.value.text.isNotEmpty && int.parse(_totalController.text) > 0 && int.parse(_totalController.text) <= 200) addFood(_totalController);
                  else null;
                },
                    0xFFF18D2B, 0xFFFFFFFF),
                SizedBox(height: 30),
              ],
            ),
          ),



        ],
      ),
    );
  }
}
