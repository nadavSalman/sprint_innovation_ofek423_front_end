import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:startup_namer/Components/signup.dart';
import 'package:startup_namer/logic/loginUtil.dart';
import 'package:startup_namer/model/User.dart';
import 'package:startup_namer/Components/open_page.dart';


class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => SignInScreen(),
      },
      theme: ThemeData(
        primaryColor: Color(0XffF3C33F), //yellow color for appBar
      ),
    );
  }


}


class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[600],
      body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
              'Assets/logo.png',
              width: 190.0,
              height: 120.0,
            ), SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm(),
          ),
        ),
              ]),
    ));
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
                 
          //LinearProgressIndicator(value: _formProgress),
          Text('התחבר', 
          textAlign: TextAlign.center,
          style: Theme
              .of(context)
              .textTheme
              .headline4),

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly ,//Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center, //Center Column contents horizontally,
            children: <Widget>[
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                    return states.contains(MaterialState.disabled) ? null : Colors.black54;
                  }),
                  backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                    return states.contains(MaterialState.disabled) ? null : Colors.lightBlue[50];
                  }),
                ),
                onPressed:() async{


                  if(checkUserPhoneInput(_userPhoneTextController.text)){
                    try {
                      Response response = await Dio().get("https://me-kone.herokuapp.com/users/${_userPhoneTextController.text}");
                      print('api res -> ${response}');
                      // //print(response.data.toString());
                      // print(response.data["username"]);


                      if(response.data.toString() == "user does not exist"){
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("user does not exist"),
                        ));
                        //register the new user and navigate to open page :
                      }else{

                        //navigate to open page :
                        //with recive data : {"username":"Nadav Salman","id":4}
                        User signinUser = User(response.data["username"], _userPhoneTextController.text, response.data["id"]);
                        print(signinUser.toString());

                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Log in..."),
                        ));


                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OpenPage(signinUser.toJson())),
                        );

                      }
                      //print('sucsess');

                    } catch (e) {
                      print('Error');
                      print(e);
                    }

                  }else{
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Invalid input"),
                    ));
                  }


                },


                child: Text('התחבר',
                  style: TextStyle(fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,),),

              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                    return states.contains(MaterialState.disabled) ? null : Colors.black54;
                  }),
                  backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                    return states.contains(MaterialState.disabled) ? null : Colors.lightBlue[50];
                  }),
                ),
                onPressed:() async{
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("go to registration page ..."),
                  ));
                  //navigation :
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Text('הירשם'),
              ),
            ],
          )
        ],
      ),
    );
  }
}






