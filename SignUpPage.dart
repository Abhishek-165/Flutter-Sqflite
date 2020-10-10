import 'package:flutter/material.dart';
import 'package:taskflutter/database_helper.dart';
import 'package:taskflutter/SignInPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _usernamecontroller = new TextEditingController();
  TextEditingController _firstnamecontroller = new TextEditingController();

  TextEditingController _lastnamecontroller = new TextEditingController();
  TextEditingController _passwordcontroller = new TextEditingController();

  String _value = "Male";
  String dropdownvalue = "0";

  DateTime selectedDate = DateTime.now();


  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }



  insertData() async
  {
    
print(dropdownvalue);
print(_value);
print(_usernamecontroller.text);
print(_firstnamecontroller.text);
print(_lastnamecontroller.text);
print(selectedDate);
print(_passwordcontroller.text);

String datadate = selectedDate.toString();

var dateTime = DateTime.parse(datadate);

var dateString = "${dateTime.day}-${dateTime.month}-${dateTime.year}";

await DatabaseHelper.instance.insert(
  {
      DatabaseHelper.columnUsername: _usernamecontroller.text,
      DatabaseHelper.columnfirstName: _firstnamecontroller.text,
      DatabaseHelper.columnlastName: _lastnamecontroller.text,
      DatabaseHelper.columngender: _value,
      DatabaseHelper.columndob: dateString,
      DatabaseHelper.columnexperience: dropdownvalue,
      DatabaseHelper.columnpassword: _passwordcontroller.text,
      

  }
);
  }
// verifying usernmae, to make it unique

 verifyusername() async
  {
   
   List<Map<String,dynamic>> verifyusernames = await DatabaseHelper.instance.queryAll();
   print(verifyusernames);
    bool boolean = false;
  verifyusernames.forEach((element) {
    print(element);
   if(element["_username"]== _usernamecontroller.text)
   {
      boolean = true;

   }
  
  });

  if(boolean== true)
  {
    
_usernamecontroller.clear();
      _firstnamecontroller.clear();
      _lastnamecontroller.clear();
      _passwordcontroller.clear();
      _value="Male";
      dropdownvalue="0";
      selectedDate= DateTime.now();

      //Toast to aware user about the username already exist

      Fluttertoast.showToast(
        msg: "Username Already Exist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  else
  {
    
     insertData();

     _usernamecontroller.clear();
      _firstnamecontroller.clear();
      _lastnamecontroller.clear();
      _passwordcontroller.clear();
      _value="Male";
      dropdownvalue="0";
      selectedDate= DateTime.now();
      
       Fluttertoast.showToast(
        msg: "Registeration Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SignInPage()),
  );
  }
    
  }

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            appBar: AppBar(title: Text("Registeration"),),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 40, 16, 100),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _usernamecontroller,
                    decoration: InputDecoration(
                        hintText: "Username", icon: Icon(Icons.person_pin)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _firstnamecontroller,
                    decoration: InputDecoration(
                        hintText: "First Name", icon: Icon(Icons.person)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _lastnamecontroller,
                    decoration: InputDecoration(
                        hintText: "Last Name", icon: Icon(Icons.person_rounded)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Radio(
                          value: "Male",
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        ),
                        title: Text("Male"),
                      ),
                      ListTile(
                        leading: Radio(
                          value: "Female",
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          },
                        ),
                        title: Text("Female"),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 20, 10),
                  child: Row(children: [
                    
                      Text("Date of Birth :-    "),
                    RaisedButton(
                    onPressed: () => _selectDate(context), // Refer step 3
                    child: Text(
                      'Select date',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.blue,
                  ),
                  ],)
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 20, 10),
                  child: Row(
                    children: <Widget>[
                      Text("Experience  :-    "),
                      DropdownButton<String>(
                          value: dropdownvalue,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownvalue = newValue;
                            });
                          },
                          items: <String>[
                            "0",
                            "1",
                            "2",
                            "3",
                            "4",
                            "5",
                            "6",
                            "7",
                            "8",
                            "9",
                            "10"
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList())
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordcontroller,
                    decoration: InputDecoration(
                        hintText: "Password", icon: Icon(Icons.lock)),
                  ),
                ),
                RaisedButton(
                    onPressed: 
                      verifyusername,

                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.blue,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
