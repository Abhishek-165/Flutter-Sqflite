import 'package:flutter/material.dart';
import 'package:taskflutter/HomePage.dart';
import 'package:taskflutter/database_helper.dart';
import 'package:taskflutter/SignUpPage.dart';
import 'package:fluttertoast/fluttertoast.dart';


class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {


  TextEditingController _usernamecontroller = TextEditingController(); 
  TextEditingController _passwordcontroller = TextEditingController();

loginAuthentication() async

{

   List<Map<String,dynamic>> verifyusernamepassword = await DatabaseHelper.instance.queryAll();
    bool boolean =false;
  verifyusernamepassword.forEach((element) { 
    if(element["_username"]==_usernamecontroller.text && element["_password"]==_passwordcontroller.text)
    {
     boolean = true;
    }
  

  });

  if(boolean==true)
  {
    
   Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomePage()));
  }
  else
  {
    Fluttertoast.showToast(
        msg: "Username or Password is wrong",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Scaffold(
          
          body: SingleChildScrollView(
                      child: Container(
              padding: EdgeInsets.fromLTRB(
                  16, MediaQuery.of(context).size.height * .24, 16, 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Align(
                   alignment: Alignment.center,
                    child: Text("Login",style: TextStyle(color: Colors.blue,fontSize: 40,fontWeight:FontWeight.bold ),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
                    child: TextField(
                   keyboardType: TextInputType.emailAddress,
                   controller:  _usernamecontroller,
                      decoration: InputDecoration(
                          hintText: "Username", icon: Icon(Icons.phone)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextField(
                      obscureText: true,
                    controller: _passwordcontroller ,
                      decoration: InputDecoration(
                          hintText: "Password", icon: Icon(Icons.lock)),
                    ),
                  ),
                  Center(
                      child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: ButtonTheme(
                      minWidth: 250,
                      height: 40,
                      child: RaisedButton(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue)),
                        color: Colors.white,
                        onPressed:  loginAuthentication,
                         
                        
                        textColor: Colors.blue,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
                   Align(
                     alignment: Alignment.bottomCenter,
                                        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: ButtonTheme(
                      minWidth: 250,
                      height: 40,
                      child: RaisedButton(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue)),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SignUpPage()));
                        },
                        textColor: Colors.blue,
                        child: Text(
                          "Signup",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ),
                ),
              ),
            ],
          ),
                   )
                ],
              ),
            ),
          )),
    );
  
  }
}