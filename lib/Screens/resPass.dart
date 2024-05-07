import 'package:doge/utils/defaultWidgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class resPasswordScreen extends StatefulWidget {
  const resPasswordScreen({Key? key}) : super(key: key);

  @override
  State<resPasswordScreen> createState() => _resPasswordScreenState();
}

class _resPasswordScreenState extends State<resPasswordScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController _emailTextController = TextEditingController();

  Future reset() async{

    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text.trim());
      var snack = SnackBar(content: Text("Revise su carpeta de spam"), duration: Duration(seconds: 2), margin: EdgeInsets.all(10), backgroundColor: Colors.deepOrangeAccent, behavior: SnackBarBehavior.floating,);
      ScaffoldMessenger.of(context).showSnackBar(snack);

    } on FirebaseAuthException catch (e){
      print(e);
      String msg = e.message.toString();
      var snack = SnackBar(content: Text(msg), duration: Duration(seconds: 2), margin: EdgeInsets.all(10), backgroundColor: Colors.deepOrangeAccent, behavior: SnackBarBehavior.floating,);
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
    FocusManager.instance.primaryFocus?.unfocus();
  }

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
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 250, left:50, right:50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Ingrese su correo para reiniciar su contraseña:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, fontFamily: "Roboto", color: Color(0xFFF18D2B)),),
                SizedBox(height: 20),
                defTextField("Ejemplo@gmail.com", false, _emailTextController),
                SizedBox(height: 20),
                defMatButton(context, "Enviar", (){reset();}, 0xFFF18D2B , 0xFFFFFFFF),
              ],
            ),
          )
        ],
      ),
    );
  }
}
