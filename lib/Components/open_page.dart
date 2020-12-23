import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Lists_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenPage extends StatefulWidget {
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
  var _lists = [];
  List users = [];
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _selectedUserIndex;
  List newGroupUsers = [];
  var newGroupNameInput = TextEditingController();

  OpenPage(this._userObject);

  @override
  _OpenPageState createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
  @override
  // todo: replace the groups list with data from DB

  Widget _buildRow(BuildContext context, int index) {
    //logic code
    if (index.isEven) {
      return ListTile(
        title: Text(
          widget.groups[index ~/ 2]
              .toUpperCase(), //take the string from groups in index of index/2 in integer
          textDirection: TextDirection.rtl,
        ),
        onTap: () {
          // need to get from the server all the lists for the right username and right group and send to lists page
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListsPage(widget.groups,
                    widget._userObject, widget.groups[index ~/ 2])),
          );
        },
      );
    } else {
      return Divider();
    }
  }

  _addUserToGroup(users, userIndex) {
    setState(() {
      widget.newGroupUsers = users;
      widget._selectedUserIndex = userIndex;
    });
  }

  Widget _buildOptions() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: _buildRow,
      itemCount: widget.groups.length * 2,
    );
  }

  Widget setupAlertDialoadContainer() {
    return Container(
        height: 300.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
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
                      selectedTileColor: Colors.blue,
                      selected: index == widget._selectedUserIndex,
                      title: Text(
                        widget.users[index ~/ 2]["userfullname"]
                            .toUpperCase(), //take the string from groups in index of index/2 in integer
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      ),
                      onTap: () {
                        List allUsers = widget.newGroupUsers;
                        allUsers.add(widget.users[index ~/ 2]["userfullname"]);
                        _addUserToGroup(allUsers, index ~/ 2);
                      },
                    );
                  } else {
                    return Divider();
                  }
                },
              ),
            )
          ],
        ));
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: widget._scaffoldKey.currentContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("קבוצה חדשה",
              textAlign: TextAlign.right,
              style: TextStyle(decoration: TextDecoration.underline)),
          content: setupAlertDialoadContainer(),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("create"),
              onPressed: () {
                // create group' add to local list and post request
                Navigator.of(context).pop();
              },
            ),
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
      key: widget._scaffoldKey,
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
              widget.users = jsonDecode(result.body);
              print(widget.users);

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
