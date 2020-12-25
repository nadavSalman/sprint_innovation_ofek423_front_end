import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Lists_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'New_group_model.dart';

class OpenPage extends StatefulWidget {
  var _groups = [];
  var _listsOfPressedGroup=[];
  List users = [];
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, dynamic> _user;

  OpenPage(this._user);

  @override
  _OpenPageState createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
  
  void initState() {
    super.initState();
    getGroups();
  }

  getGroups() async {
    print("the user connected:");
    print(widget._user);
    try {
      String reqBody = "https://me-kone.herokuapp.com/groups/"+widget._user["id"].toString();
      print(reqBody);
      await Dio().get(reqBody).then((res) {
        print(res.data);
        setState(() {
          widget._groups = res.data;
        });
      });
    } catch (e) {
      print('Error');
      print(e);
    }
  }
 
  Widget _buildRow(BuildContext context, int index) {
    //logic code
    if (index.isEven) {
      return ListTile(
        title: Text(
          widget._groups[index ~/ 2]["teamname"]
              .toUpperCase(),
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        onTap: () async{
          print("title : " + widget._groups[index ~/ 2]["teamname"]);
          try {
            String reqBody = "https://me-kone.herokuapp.com/lists/"+widget._groups[index ~/ 2]["teamid"].toString();
            print(reqBody);
            await Dio().get(reqBody).then((res) {
              print(res.data);
              setState(() {
                widget._listsOfPressedGroup = res.data;
              });
            });
          } catch (e) {
            print('Error');
            print(e);
          }
          try {
            var result =
                  await http.get("https://me-kone.herokuapp.com/users");
                   widget.users = jsonDecode(result.body);
              print(widget.users);
          } catch (e) {
            print('Error');
            print(e);
          }
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListsPage(widget._listsOfPressedGroup, widget._user, widget._groups[index ~/ 2], widget.users)),
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
      itemCount: widget._groups.length * 2,
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
