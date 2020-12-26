import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/io_client.dart';

// ignore: must_be_immutable
class NewItemModel extends StatefulWidget {
  var newItemNameInput = TextEditingController();
  var _currList;
  var _currUser;
  final updateItems;
  var myAddProductModelTextbox = TextEditingController();

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  NewItemModel(this._currUser, this._currList, this.updateItems);

  @override
  _NewItemModelState createState() => _NewItemModelState();
}

class _NewItemModelState extends State<NewItemModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width:
            MediaQuery.of(context).size.width, // Change as per your requirement
        child: new Column(children: <Widget>[
          TextField(
            controller: widget.myAddProductModelTextbox,
            textInputAction: TextInputAction.go,
            textAlign: TextAlign.right,
            decoration: InputDecoration(hintText: "הכנס את המוצר שאתה רוצה"),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            FlatButton(
                child: new Text("Add"),
                onPressed: () async {
                  try {
                    var reqBody = {
                      "name": widget.myAddProductModelTextbox.text,
                      "author": widget._currUser["id"],
                      "list": widget._currList["listid"]
                    };
                    var jsonBody = jsonEncode(reqBody);
                    print(jsonBody);
                    final ioc = new HttpClient();
                    ioc.badCertificateCallback =
                        (X509Certificate cert, String host, int port) => true;
                    final http = new IOClient(ioc);
                    await http.post("https://me-kone.herokuapp.com/items",
                        body: jsonBody,
                        headers: {
                          "accept": "application/json",
                          "content-type": "application/json"
                        }).then((res) {
                      print("Reponse status : ${res.statusCode}");
                      print("Response body : ${res.body}");
                    });
                    String getReqBody = "https://me-kone.herokuapp.com/items/" +
                        widget._currList["listid"].toString();
                    print(getReqBody);
                    await http.get(getReqBody).then((res) {
                      print(res.body);
                      widget.updateItems(jsonDecode(res.body));
                    });
                  } catch (e) {
                    print(e.toString());
                  }
                  Navigator.of(context).pop();
                }),
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ])
        ]));
  }
}
