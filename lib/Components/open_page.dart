import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Lists_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'New_group_model.dart';

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

  Widget _buildOptions() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: _buildRow,
      itemCount: widget.groups.length * 2,
    );
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
          content: NewGroupModel(widget.users),
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
