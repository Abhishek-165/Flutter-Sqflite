import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();


  
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      Fluttertoast.showToast(
        msg: "Login Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: Container(
            child: Text("Home Page"),
        ),
          ),
        
      
    );
  }
}