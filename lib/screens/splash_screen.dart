import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';

import 'package:flutter_movie_app/models/app_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onInitializationComplete});

  final VoidCallback onInitializationComplete;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => _setup().then(
        (value) => widget.onInitializationComplete(),
      ),
    );
  }

  Future<void> _setup() async {
    // here the get_it package will allow us to register a singleton for different
    // classes that we have inisde of our application and then make them available
    // to us.

    final getIt = GetIt.instance;

    final configFile = await rootBundle.loadString('assets/config/main.json');

    final configData = jsonDecode(configFile);

    // here we are registering the config data as a singleton so that we can access
    // it(this single instance) globally
    getIt.registerSingleton<AppConfig>(AppConfig(
        BASE_API_URL: configData['BASE_API_URL'],
        BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL'],
        API_KEY: configData['API_KEY']));
  }

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
