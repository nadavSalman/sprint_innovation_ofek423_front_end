import 'package:flutter/material.dart';
import 'products_list_page.dart';

class ListsPage extends StatelessWidget {
  List _lists;
  var _userObject;
  var _currGroupObject;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  ListsPage(this._lists, this._userObject, this._currGroupObject);

  Widget _buildRow(BuildContext context, int index) {
    if (index.isEven) {
      return ListTile(
        title: Text(
          _lists[index ~/ 2].toUpperCase(),
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
                builder: (context) => ProductsListPage(
                    _lists[index ~/ 2], this._userObject, _currGroupObject)),
          );
        },
      );
    } else {
      return Divider();
    }
  }

  Widget _buildOptions() {
    return ListView(
      children: <Widget>[
        new ListTile(
          title: Text(
            this._currGroupObject,
            style: TextStyle(
              fontSize: 30,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
        ),
        new Expanded(
            child: new ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          itemBuilder: _buildRow,
          itemCount: _lists.length * 2,
        ))
      ],
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
            tooltip: 'New List',
          ),
        ),
      ),
    );
  }
}
