import 'package:flutter/material.dart';
import "package:qr_generator/GetMessage.dart";

class HomePage extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("QR Generator"),
      ),
      body: Center(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>GetMessage()),
                  );
                },
                child: const Text("Generate QR Code"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}