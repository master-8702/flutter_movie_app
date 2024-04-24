import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onInitializationComplete});

  final VoidCallback onInitializationComplete;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master Movies',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.80,
          height: 200,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/movie.png'),
                  fit: BoxFit.contain)),
        ),
      ),
    );
  }
}
