import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:startup_namer/Components/open_page.dart';
import 'package:startup_namer/Components/signin.dart';
import 'package:startup_namer/model/User.dart';



class SignUp extends StatelessWidget {


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
                    MaterialPageRoute(builder: (context) => SignIn()),
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
                    //1. Sen POST request to register the user
                      //1.1 In case of registration secsses get the user data and forwar to openPage route.

                    //2.heandle already exsist user .
                  Response response;
                  try{
                      response = await Dio().post("https://me-kone.herokuapp.com/users/user",
                      data: {"name": _userNameTextController.text, "phone": _userPhoneTextController.text});
                      //print('api res / add new user  -> ${response}');
                      // retriving the new user id :
                      Response responseUser = await Dio().get("https://me-kone.herokuapp.com/users/${_userPhoneTextController.text}");
                      User signinUser = User(responseUser.data["username"], _userPhoneTextController.text, responseUser.data["id"]);

                      print(signinUser.toString());


                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("added user "),
                      ));

                    //navigate to open page :
                    //with recive data : User added
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OpenPage(signinUser.toJson())),
                      );

                  }catch(e){
                    print('api error res -> ${response}');
                  }


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
