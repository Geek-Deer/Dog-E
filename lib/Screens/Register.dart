import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doge/utils/bg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:doge/utils/particles.dart';
import 'package:doge/utils/nav.dart';
import 'package:doge/utils/defaultWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override


  State<RegisterScreen> createState() => _RegisterScreenState();

}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passTextController = TextEditingController();
  TextEditingController _passTextControllerCon = TextEditingController();

  String? valueChoose;
  List listItem = ['Masculino', 'Femenino', 'Otro', 'Prefiero no responder'];


  late AnimationController _controller;

  @override
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
        children:[
          Positioned(
              bottom: 0,
              left: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 300),
                    painter: BottomBGCustomPainter(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:80, left: 50, right: 50),
            child: Column(
              children: [
                const Text("Ingrese sus datos", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Color(0xFF5F6266)
                )),
                const SizedBox(
                  height: 49
                ),
                defTextField("Nombre", false, _nameTextController),
                const SizedBox(
                    height: 12
                ),
                defTextField("Teléfono", false, _phoneTextController),
                const SizedBox(
                    height: 12
                ),
                defTextField("Correo", false, _emailTextController),
                const SizedBox(
                    height: 12
                ),
                defTextField("Contraseña", true, _passTextController),
                const SizedBox(
                    height: 12
                ),
                defTextField("Confirmar contraseña", true, _passTextControllerCon),
                const SizedBox(
                    height: 12
                ),
                const SizedBox(
                    height: 18
                ),
                defMatButton(context, "Registrarse", () {
                  if(_emailTextController.text.isNotEmpty&&
                      _passTextController.text.isNotEmpty&&
                      _emailTextController.text.isNotEmpty&&
                      _phoneTextController.text.isNotEmpty&&
                      (_passTextController.text == _passTextControllerCon.text)){
                      FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text,
                          password: _passTextController.text).then((value) {
                            String docName = _emailTextController.text;
                        FirebaseFirestore.instance.collection('Dog-E_Database/data/user').doc("$docName").set({'name':_nameTextController.text, 'email' : _emailTextController.text, 'num' :_phoneTextController.text, 'pass' : _passTextController.text });
                        _nameTextController.text = "";
                        _phoneTextController.text = "";
                        _emailTextController.text = "";
                        _passTextController.text = "";
                        _passTextControllerCon.text = "";
                        nav.goToLogin(context);
                      }).onError((error, stackTrace){
                        print("error ${error.toString()}");
                      });
                      var snack = SnackBar(content: Text("Registro realizado con éxito", style: TextStyle(color: Colors.deepOrangeAccent)), duration: Duration(seconds: 2), margin: EdgeInsets.all(10), backgroundColor: Colors.white, behavior: SnackBarBehavior.floating,);
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                      nav.goToWelcome(context);
                  }
                  else{
                    if(_passTextController.text != _passTextControllerCon &&
                        _emailTextController.text.isNotEmpty&&
                        _passTextController.text.isNotEmpty&&
                        _emailTextController.text.isNotEmpty&&
                        _phoneTextController.text.isNotEmpty){
                      var snack = SnackBar(content: Text("Las contraseñas no coinciden.", style: TextStyle(color: Colors.deepOrangeAccent)), duration: Duration(seconds: 2), margin: EdgeInsets.all(10), backgroundColor: Colors.white, behavior: SnackBarBehavior.floating,);
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    }
                    else {
                      var snack = SnackBar(content: Text("Por favor llene los espacios.", style: TextStyle(color: Colors.deepOrangeAccent)), duration: Duration(seconds: 2), margin: EdgeInsets.all(10), backgroundColor: Colors.white, behavior: SnackBarBehavior.floating,);
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    }
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                }, 0xFFF26D2B , 0xFFFFFFFF),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


