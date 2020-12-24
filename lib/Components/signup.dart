import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:startup_namer/Components/signin.dart';



class SignUp extends StatelessWidget {
  String _data;

  SignUp(this._data);

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      routes: {
        '/': (context) => SignUpScreen(),
      },
    );
  }


}


class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _userNameTextController = TextEditingController();
  final _userPhoneTextController = TextEditingController();

  double _formProgress = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: _formProgress),
          Text('Sign Up', style: Theme
              .of(context)
              .textTheme
              .headline4),

          Padding(

            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              textAlign: TextAlign.end,
              controller: _userNameTextController,
              decoration: InputDecoration(hintText: 'שם מלא '),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              controller: _userPhoneTextController,
              decoration: InputDecoration(hintText: 'מספר טלפון'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center ,//Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center, //Center Column contents horizontally,
            children: <Widget>[
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                    return states.contains(MaterialState.disabled) ? null : Colors.black38;
                  }),
                  backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                    return states.contains(MaterialState.disabled) ? null : Colors.white10;
                  }),
                ),
                onPressed:() async{
                  //navigation :
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn("Sign-In")),
                  );
                },


                child: Text('Sign in'),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                    return states.contains(MaterialState.disabled) ? null : Colors.black38;
                  }),
                  backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                    return states.contains(MaterialState.disabled) ? null : Colors.white10;
                  }),
                ),
                onPressed:() async{

                },
                child: Text('Sign up',
                  style: TextStyle(fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,),),
              ),
            ],
          )
        ],
      ),
    );
  }
}
