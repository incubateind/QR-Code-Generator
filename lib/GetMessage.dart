import 'dart:async';
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:screenshot_and_share/screenshot_share.dart';
import 'package:qr_flutter/qr_flutter.dart';

var values;  //Values get the message from textbox and acts as "Data" For QR Image Generation.

//##################################################################################################

class GetMessage extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    final appTitle = 'QR Generator';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
    
  }
}

//##################################################################################################

class MyCustomForm extends StatefulWidget{
  MyCustomFormState createState(){
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm>{
  final _formKey = GlobalKey<FormState>();

  TextEditingController _myController = TextEditingController(); //Used to get the data from TextBox

  void dispose(){                                                //Acts as a Flush operation to eliminate previous values.
    _myController.dispose();
    super.dispose();
  }
//This is the Actual front Widgid of the App, containing TextBox and Submit Button.
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _myController,
            validator: (value){
              if (value.isEmpty){
                //returns the below text if user doesn't enter any value | text
                return 'Please Enter some Text';
              }
            },
          ),
          //Below code navigates to next Widget page(class 'MainScreen') 
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: RaisedButton(
              onPressed: (){
                setState(() {
                  //Stores the entered data as Text into the variable "values"
                  values = _myController.text; 
                });
                if(_formKey.currentState.validate()){
                  Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("Processing Data")));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                }
              },
              child: Text("Submit"),
            ),
          )
        ],
      ),
    );
  }
}

//##################################################################################################

class MainScreen extends StatefulWidget{
  _MainScreenState createState() => _MainScreenState();
}

//The Class which actually creates the QR code image for the given data
class _MainScreenState extends State<MainScreen>{
  Widget build(BuildContext context){
    final message = values;                                         //"values" passed to message.
    final qrFutureBuilder = FutureBuilder(
      future: _loadOverlayImage(),
      builder: (ctx,snapshot){
        final size = 280.0;
        if(!snapshot.hasData){
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: message,                                         //Input for the QR Painter
            version: QrVersions.auto,
            color: Color(0xff1a5441),
            emptyColor: Color(0xffeafcf6),
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(60),
            ),
          ),
        );
      },
    );

    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    width: 280,
                    child: qrFutureBuilder,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40).copyWith(bottom: 40),
                child: Text("Your QR Code is Generated Above!"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<ui.Image> _loadOverlayImage() async{
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load('assets/images/message.png');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}
