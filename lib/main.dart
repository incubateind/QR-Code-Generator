import 'package:flutter/material.dart';
import 'package:qrgenerator/screen/HomeScreen.dart';
import 'package:qrgenerator/screen/SplashScreen.dart';

import 'constant/Constant.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    title: 'QR GENERATOR',
    routes: <String, WidgetBuilder>{
      HOME_SCREEN: (BuildContext context) => HomeScreen(),
    },
    home: SplashScreen(),
  ),
);
