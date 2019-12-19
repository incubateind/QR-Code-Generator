import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_generator/GetMessage.dart';
import 'GetMessage.dart';
void main() => runApp(ExampleApp());

class ExampleApp extends StatelessWidget
{ 
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'QR.Flutter',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: GetMessage(),
      );
  }
}
