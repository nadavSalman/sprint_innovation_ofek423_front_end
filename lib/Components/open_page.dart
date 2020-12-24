import 'package:flutter/material.dart';
import 'Lists_page.dart';

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
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
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
          style: TextStyle(
            fontSize: 20,
          ),
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

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: _scaffoldKey.currentContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
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
            onPressed: () {
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
