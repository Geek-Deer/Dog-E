import 'package:flutter/material.dart';
import 'package:doge/utils/particles.dart';
import 'package:doge/utils/nav.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFA50E), Color(0xFFF25D2B)])),
            ),

          ),
          Positioned.fill(
              child: const Particles(50)
          ),
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Image.asset('assets/png/doggoBono.png', width: 150),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text("Bienvenido", style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    )),
                    const SizedBox(
                      height: 8,
                    ),

                    Center(
                      child: Center(
                        child: SizedBox(
                          width: 245,
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "Antes de empezar con ",style: TextStyle(
                                fontSize: 14,
                                fontWeight:FontWeight.w600,
                                color: Colors.white,
                              ),
                              ),
                              TextSpan(
                                text: "Dog-E ",style: TextStyle(
                                fontSize: 16,
                                fontWeight:FontWeight.bold,
                                color: Colors.white,
                              ),
                              ),
                              TextSpan(
                                text: "proceda con su autenticación.",style: TextStyle(
                                fontSize: 14,
                                fontWeight:FontWeight.w600,
                                color: Colors.white,
                              ),
                              ),
                            ]
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      height: 49,
                      minWidth: 258,
                      elevation: 8,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      color: Colors.white,
                      child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFFF26D2B),
                          ),),
                      onPressed: () {nav.goToLogin(context);},
                    ),
                    SizedBox(
                      height:20,
                    ),
                    MaterialButton(
                      height: 49,
                      minWidth: 258,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      color: Color(0xFFFFFF).withOpacity(0.20),
                      child: Text(
                        "Registrarse",
                        style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white,
                        ),),
                      onPressed: (){ nav.goToRegister(context); },
                    ),
                    SizedBox(
                      height: 16
                    ),
                    Text("Al iniciar sesión acepta los terminos\n y condiciones de uso y avisos de privacidad", textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white,
                    ),),
                  ],

                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}















