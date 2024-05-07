import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doge/utils/bg.dart';
import 'package:doge/utils/nav.dart';
import 'package:doge/utils/defaultWidgets.dart';
import 'package:firebase_core/firebase_core.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
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

        children: [
          Background(
            height: 446.0,
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32, top: 80),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Bienvenido, inicie sesión para comenzar", style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              )),

                              Text("Dog-E", style: TextStyle(
                                fontSize: 36,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              )),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right:20, top:30),
                          child: Column(
                            children: [Image.asset('assets/png/doggoBono.png')]
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 32, right:32, top:49),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  textAlign: TextAlign.right,
                                  text: const TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Correo ",style: TextStyle(
                                          fontSize: 14,
                                          fontWeight:FontWeight.w600,
                                          color: Color(0xFFF1F1F1),
                                        ),
                                        ),
                                        TextSpan(
                                          text: "electrónico:",style: TextStyle(
                                          fontSize: 14,
                                          fontWeight:FontWeight.w600,
                                          color: Color(0xFF5F6266),
                                        ),
                                        ),
                                      ]
                                  )),
                              const SizedBox(
                                height: 14,
                              ),
                              const SizedBox(
                                height: 5,

                              ),
                              defTextField("Ejemplo@gmail.com", false, _emailTextController),
                              const SizedBox(
                                height: 14,
                              ),
                              RichText(
                                  textAlign: TextAlign.right,
                                  text: const TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Contraseña:",style: TextStyle(
                                          fontSize: 14,
                                          fontWeight:FontWeight.w600,
                                          color: Color(0xFF5F6266),
                                        ),
                                        ),
                                      ]
                                  )),
                              const SizedBox(
                                height: 14,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              defTextField("Contraseña", true, _passwordTextController),

                              Padding(
                                padding: const EdgeInsets.only(left:165),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    TextButton(
                                      onPressed:() {nav.goToResPassword(context);},
                                      child: Text("¿Olvidaste tu contraseña?",
                                      textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFFFA60E),
                                            fontWeight: FontWeight.w600,
                                          ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialButton(
                          height: 49,
                          minWidth: 258,
                          elevation: 8,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          color: Color(0xFFF26D2B),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white,
                            ),),
                          onPressed: () {
                            if(_emailTextController.text.isEmpty || _passwordTextController.text.isEmpty){
                              var snack = SnackBar(content: Text("Introduzca sus credenciales completas.", style: TextStyle(color: Colors.white)), duration: Duration(seconds: 2), margin: EdgeInsets.all(10), backgroundColor: Colors.deepOrangeAccent, behavior: SnackBarBehavior.floating,);
                              ScaffoldMessenger.of(context).showSnackBar(snack);
                            }else{
                              FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text, password: _passwordTextController.text).then((value){
                                _passwordTextController.text = "";
                                _emailTextController.text = "";
                                nav.goToMenu(context);
                              }).onError((error, stackTrace){
                                var snack = SnackBar(content: Text("Credenciales incorrectas.", style: TextStyle(color: Colors.white)), duration: Duration(seconds: 2), margin: EdgeInsets.all(10), backgroundColor: Colors.deepOrangeAccent, behavior: SnackBarBehavior.floating,);
                                ScaffoldMessenger.of(context).showSnackBar(snack);
                                _passwordTextController.text = "";
                                _emailTextController.text = "";
                                print("Error ${error.toString()}");
                              });
                            }
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "¿No tienes cuenta?",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFFFA50E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(onPressed: (){nav.goToRegister(context);}, child: const Text("Registrate", style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ))),
                          ],
                        ),
                      ],
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



















