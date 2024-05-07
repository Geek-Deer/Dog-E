import 'dart:async';

import 'package:flutter/material.dart';
import 'package:doge/utils/particles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:doge/utils/nav.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () => nav.goToWelcome(context));
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
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors:[Color(0xFFFFA50E),Color(0xFFF2602B)])),
              ),
              const Positioned.fill(
                  child: Particles(50)
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/png/doggoBono.png", width: 150),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const Text(
                    'Desarrollado por',
                    style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'LunitaProyectos',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 40))
                ],
              ),
            ]
        )
    );
  }
}









