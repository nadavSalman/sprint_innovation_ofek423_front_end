import 'package:flutter/material.dart';
import 'products_list_page.dart';
import 'package:intl/intl.dart' as intl;
import 'New_list_model.dart';

class ListsPage extends StatefulWidget {
  List _lists;
  var _userObject;
  var _currGroupObject;
  var _allUsers;
  var pressedListName;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  ListsPage(
      this._lists, this._userObject, this._currGroupObject, this._allUsers);

  @override
  _ListsPageState createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  getListName(int index) {
    print(widget._lists[index ~/ 2]["listcreator"]);
    var result = widget._allUsers.firstWhere(
        (obj) => obj["userid"] == widget._lists[index ~/ 2]["listcreator"]);
    widget.pressedListName = result["userfullname"] +
        " ב" +
        widget._lists[index ~/ 2]["purchaselocation"];
    return widget.pressedListName;
  }

  updateLists(newLists){
    setState(() {
      widget._lists = newLists;
    });
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
          intl.DateFormat('dd-MM-yyyy – hh:mm').format(
              DateTime.parse(widget._lists[index ~/ 2]["listpurchasedate"])),
          textDirection: TextDirection.rtl,
        ),
        onTap: () {
          // need to get from the server all the lists for the right username and right group and send to lists page
          widget.pressedListName = getListName(index);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductsListPage(
                    widget._lists[index ~/ 2],
                    widget._userObject,
                    widget._currGroupObject,
                    widget.pressedListName,
                    widget._allUsers)),
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
                widget._currGroupObject["teamname"],
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
                  itemCount: widget._lists.length * 2,
                ))
          ]),
        )));
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: widget._scaffoldKey.currentContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "הוספת רשימה חדשה",
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
          content: NewListModel(widget._userObject, widget._currGroupObject, updateLists),
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
