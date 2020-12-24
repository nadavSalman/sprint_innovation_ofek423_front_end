import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/io_client.dart';

class NewGroupModel extends StatefulWidget {
  List newGroupUsers = [];
  List users = [];
  var newGroupNameInput = TextEditingController();

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  NewGroupModel(this.users);

  @override
  _NewGroupModelState createState() => _NewGroupModelState();
}

class _NewGroupModelState extends State<NewGroupModel> {
  _addUserToGroup(user) {
    setState(() {
      widget.newGroupUsers.add(user);
    });
  }

  void _showDialogExistingUserInNewGroup() {
    // flutter defined function
    showDialog(
      context: widget._scaffoldKey.currentContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "המשתמש נוסף כבר לקבוצה",
            textAlign: TextAlign.right,
          ),
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
    return Container(
      height: MediaQuery.of(context).size.height,
      width:
          MediaQuery.of(context).size.width, // Change as per your requirement
      child: new Column(
        children: <Widget>[
          TextField(
            controller: widget.newGroupNameInput,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(hintText: "הכנס שם קבוצה חדשה"),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
          Text(
            "אנשי קשר להוספה:",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 20,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
          new Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.users.length * 2,
              itemBuilder: (BuildContext context, int index) {
                //logic code
                if (index.isEven) {
                  return ListTile(
                    title: Text(
                      widget.users[index ~/ 2]["userfullname"]
                          .toUpperCase(), //take the string from groups in index of index/2 in integer
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      if (!widget.newGroupUsers
                          .contains(widget.users[index ~/ 2])) {
                        _addUserToGroup(widget.users[index ~/ 2]);
                      } else {
                        _showDialogExistingUserInNewGroup();
                      }
                    },
                  );
                } else {
                  return Divider();
                }
              },
            ),
          ),
          Text(
            "חברי הקבוצה הנוכחיים:",
            style: TextStyle(
              fontSize: 20,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
          new Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.newGroupUsers.length * 2,
              itemBuilder: (BuildContext context, int index) {
                //logic code
                if (index.isEven) {
                  return ListTile(
                    title: Text(
                      widget.newGroupUsers[index ~/ 2]["userfullname"]
                          .toUpperCase(), //take the string from groups in index of index/2 in integer
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                  );
                } else {
                  return Divider();
                }
              },
            ),
          ),
          new FlatButton(
            child: new Text("create"),
            onPressed: () async {
              try {
                var usersIdForDB = [];
                widget.newGroupUsers.forEach((user) {
                  usersIdForDB.add("'" + user["userid"] + "'");
                });
                var jsonString = jsonEncode({
                  "name": widget.newGroupNameInput.text,
                  "users": usersIdForDB
                });
                final ioc = new HttpClient();
                ioc.badCertificateCallback =
                    (X509Certificate cert, String host, int port) => true;
                final http = new IOClient(ioc);
                await http.post("https://me-kone.herokuapp.com/groups/group",
                    body: {
                      "name": widget.newGroupNameInput.text,
                      "users": usersIdForDB
                    }).then((res) {
                  print("Reponse status : ${res.statusCode}");
                  print("Response body : ${res.body}");
                });
              } catch (e) {
                print(e.toString());
              }

              // create group' add to local list and post request
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }
}
