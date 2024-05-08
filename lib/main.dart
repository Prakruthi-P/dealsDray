import 'package:dealsdray/Screens/botttomNavigationBar.dart';
import 'package:dealsdray/Screens/dashboardScreen.dart';
import 'package:dealsdray/Screens/loginScreen.dart';
import 'package:dealsdray/Screens/RegistrationScreen.dart';
import 'package:dealsdray/Screens/splashScreens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes:{
        "/loginScreen":(context)=>LoginScreen(),
        "/dashboardScreen":(context)=>DashBoardScreen(),
        "/registrationScreen":(context)=>RegistrationScreen(),
        "/bottomNavigationScreen":(context)=>BottomNavigation()
    },
      home: const SplashScreen(child: LoginScreen(),),
    );
  }
}

