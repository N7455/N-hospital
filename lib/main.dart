
// import 'package:flutter/material.dart';
// import 'screen/splash_screen.dart';
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const NHospitalApp());
// }

// class NHospitalApp extends StatelessWidget {
//   const NHospitalApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'N Hospital',
//       debugShowCheckedModeBanner: false,

//       theme: ThemeData(
//         useMaterial3: true,
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: const Color(0xFF080808),

//         colorScheme: const ColorScheme.dark(
//           primary: Color(0xFFE50914),
//           secondary: Color(0xFF2979FF),
//           surface: Color(0xFF151515),
//         ),
//       ),

//       home: const SplashScreen(),
//     );
//   }
// }



















import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'N Hospital',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF080808),
        primaryColor: const Color(0xFFE50914),
      ),
      home: const SplashScreen(),
    );
  }
}
