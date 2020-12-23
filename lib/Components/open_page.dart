import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Lists_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class OpenPage extends StatefulWidget {
//   OpenPage();

//   @Override

// }

class OpenPageState extends StatelessWidget {
  @override
  // todo: replace the groups list with data from DB
  List<String> groups = [
    "המגניבים",
    "צוות DevOps",
    "הרוננים",
    "גף תהליכי פיתוח",
    "המגניבים",
    "צוות DevOps",
    "הרוננים",
    "גף תהליכי פיתוח",
  ];
  var _userObject = '';
  var _lists;
  var users;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var newGroupUsers;
  //add groups parameter to constructor
  OpenPageState(this._userObject);

  Widget _buildRow(BuildContext context, int index) {
    //logic code
    if (index.isEven) {
      return ListTile(
        title: Text(
          groups[index ~/ 2]
              .toUpperCase(), //take the string from groups in index of index/2 in integer
          textDirection: TextDirection.rtl,
        ),
        onTap: () {
          // need to get from the server all the lists for the right username and right group and send to lists page
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ListsPage(groups, this._userObject, groups[index ~/ 2])),
          );
        },
      );
    } else {
      return Divider();
    }
  }

  Widget _buildOptions() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: _buildRow,
      itemCount: groups.length * 2,
    );
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: users.length * 2,
        itemBuilder: (BuildContext context, int index) {
          //logic code
          if (index.isEven) {
            return ListTile(
              title: Text(
                users[index ~/ 2]["userfullname"]
                    .toUpperCase(), //take the string from groups in index of index/2 in integer
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                newGroupUsers.add(users[index ~/ 2]["userfullname"]);
              },
            );
          } else {
            return Divider();
          }
        },
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: _scaffoldKey.currentContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: setupAlertDialoadContainer(),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Meקונה',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildOptions(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () async {
              var result =
                  await http.get("https://me-kone.herokuapp.com/users");
              users = jsonDecode(result.body);
              print(users);

              _showDialog();
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.black,
            tooltip: 'New group',
          ),
        ),
      ),
    );
  }
}
