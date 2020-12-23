import 'package:flutter/material.dart';
import 'package:dio/dio.dart';



class SignIn extends StatelessWidget {
  String _data;

  SignIn(this._data);

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
          Text('Sign up', style: Theme
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

              try {
                Response response = await Dio().get("https://me-kone.herokuapp.com/users/${_userPhoneTextController.text}");
                print(response);
                print(response.data.toString());
                if(response.data.toString() == "user does not exist"){
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("user does not exist"),
                  ));
                  //register the new user and navigate to open page :
                }else{
                  //navigate to open page :
                }
                //print('sucsess');
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("user exist."),
                ));
              } catch (e) {
                print('Error');
                print(e);
              }



            },
            child: Text('Sign up'),
          ),
        ],
      ),
    );
  }
}

