import 'package:flutter/material.dart';
import 'Components/open_page.dart';
import 'package:startup_namer/Components/signup.dart';
import 'package:startup_namer/Components/signin.dart';
import 'package:startup_namer/model/User.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  var emptyUser = User('nadav', '02342340',0);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Color(0XffF3C33F), //yellow color for appBar
      ),
      home: SignIn(),
    );
  }
}
