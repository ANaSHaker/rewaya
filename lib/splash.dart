import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'Home.dart';
import 'drawer.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4 ), () =>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Draweer())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
       children: <Widget>[
         Center(
           child: Shimmer.fromColors(
             direction: ShimmerDirection.rtl,
             baseColor: Colors.white,
             highlightColor: Color(0xff2b343b),
             child: Text(
               "الجنون في القنينة ",
               style: TextStyle(
                   fontSize: 35, fontWeight: FontWeight.w900, letterSpacing: 1.2),
             ),
           ),
         ),
       ],
      ),
    );
  }
}