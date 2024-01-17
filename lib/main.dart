import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:physiatrix_admin/Screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyB9nlg9uZnMpDTAdKrvGxu4Xq-CCFn2mXQ",
    appId: "1:611533837404:web:df5f57caef73c0422cc299",
    messagingSenderId: "611533837404",
    projectId: "physiatrix1",
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1440, 1016),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My App',
            home: child,
            theme: ThemeData(
                unselectedWidgetColor: Colors.white,
                primarySwatch: Colors.grey),
          );
        },
        child: const LoginScreen());
  }
}
