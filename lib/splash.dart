import 'dart:async';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 6),
      () {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 90.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/ika.jpg',
                    fit: BoxFit.cover,
                    width: 100,
                    height: 140,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'IKA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    '059',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/laila.jpg',
                    fit: BoxFit.cover,
                    width: 100,
                    height: 140,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'LAILA FADILLA ASYURO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    '067',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/femas.jpg',
                    fit: BoxFit.cover,
                    width: 100,
                    height: 140,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'FEMAS ANUGRA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    '090',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "Memuat...",
            style: TextStyle(
              color: Colors.white,
              backgroundColor: Colors.green.shade400,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
