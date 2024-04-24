import 'package:flutter/material.dart';
import 'package:flutter_movie_app/screens/splash_screen.dart';

void main() {
  runApp(
    SplashScreen(onInitializationComplete: () => null),
  );
}






// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
        
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: Scaffold( appBar: AppBar(),body: const Center(child: Text('Initial commit'),),),
//     );
//   }
// }
