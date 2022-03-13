import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_and_signin_flutter/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    Timer(Duration(seconds: 1),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => MyHomePage(title: '',)
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.center, colors: [
              Colors.orange[900]!,
              Colors.orange[700]!,
              Colors.orange[400]!
            ])),
     child:Center(
       child:  CircleAvatar(
         child: ClipOval(
           child: Image.asset("assets/logo1.png"),
         ),
         backgroundColor: Colors.transparent,
         radius: 100,
       )

     )
    );
  }
}
