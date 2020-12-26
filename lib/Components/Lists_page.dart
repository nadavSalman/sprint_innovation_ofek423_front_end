import 'package:flutter/material.dart';
import 'products_list_page.dart';
import 'package:intl/intl.dart' as intl;

class ListsPage extends StatelessWidget {
  List _lists;
  var _userObject;
  var _currGroupObject;
  var _allUsers;
  var pressedListName;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  ListsPage(this._lists, this._userObject, this._currGroupObject, this._allUsers);
  
  getListName(int index){
    print(_lists[index ~/ 2]["listcreator"]);
    var result =_allUsers.firstWhere((obj) => obj["userid"] == _lists[index ~/ 2]["listcreator"]);
    pressedListName = result["userfullname"]+" ב"+_lists[index ~/ 2]["purchaselocation"];
    return pressedListName;
  }

  Widget _buildRow(BuildContext context, int index) {
    if (index.isEven) {
      return ListTile(
        title: Text(
          getListName(index),
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          intl.DateFormat('dd-MM-yyyy – hh:mm').format(DateTime.parse(_lists[index ~/ 2]["listpurchasedate"])),
          textDirection: TextDirection.rtl,
          // style: TextStyle(
          //   fontSize: 20,
          // ),
        ),
        onTap: () {
          // need to get from the server all the lists for the right username and right group and send to lists page
          pressedListName = getListName(index);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductsListPage(
                    _lists[index ~/ 2], this._userObject, _currGroupObject, pressedListName, this._allUsers)),
          );
        },
      );
    } else {
      return Divider();
    }
  }

  Widget _buildOptions(dynamic context) {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(children: <Widget>[
            new ListTile(
              title: Text(
                this._currGroupObject["teamname"],
                style: TextStyle(
                  fontSize: 30,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                child: new ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(16),
                  itemBuilder: _buildRow,
                  itemCount: _lists.length * 2,
                ))
          ]),
        )));
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
      body: _buildOptions(context),
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
