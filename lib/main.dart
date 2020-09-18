import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:rewaya/splash.dart';

import 'constants.dart';
import 'drawer.dart';
var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => Draweer(),
};
void main() {

  runApp(DynamicTheme(
      defaultBrightness: Brightness.dark, // Brightness.light,
      data: (brightness) => ThemeData(
    primarySwatch: LightPrimaryColor,

    brightness: brightness,
  ),
  themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          theme: theme,
          title: "الجنون في القنينة",
     debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  );}));
}
