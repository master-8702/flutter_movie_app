import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_movie_app/screens/home_screen.dart';
import 'package:flutter_movie_app/screens/splash_screen.dart';

// here in the main method what we are doing is that, we call runApp to call the
// splash screen as an app and after when the initializations is completed we will
// again call runapp and give it the root of the application (HomeScreen). So in
// this case flutter will just disregard the app that was previouly running.
void main() {
  runApp(
    SplashScreen(
      onInitializationComplete: () =>
          runApp(const ProviderScope(child: MyApp())),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      initialRoute: 'home',
      routes: {
        'home': (context) => HomeScreen(),
      },
      home: Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Master Movies'),
        ),
      ),
    );
  }
}
