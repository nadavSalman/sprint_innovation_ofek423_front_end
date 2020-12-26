import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'Products_List.dart';
import 'dart:convert';

class ProductsListPage extends StatefulWidget {
  var _products = [];
  var _userObject;
  var _currListObject;
  var _currGroupObject;
  var myAddProductModelTextbox = TextEditingController();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  ProductsListPage(
      this._currListObject, this._userObject, this._currGroupObject);

  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  getProducts() async {
    try {
      await Dio().get("https://me-kone.herokuapp.com/items/1").then((res) {
        print(res.data);
        setState(() {
          widget._products = res.data;
        });
      });
    } catch (e) {
      print('Error');
      print(e);
    }
  }

  Widget _buildRow(BuildContext context, int index) {
    if (index.isEven) {
      return ListTile(
        title: Text(
          widget._products[index ~/ 2]["productname"],
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      );
    } else {
      return Divider();
    }
  }

  Widget _buildOptions() {
    return new Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    new ListTile(
                      title: Text(
                        widget._currListObject,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      ),
                      subtitle: Text(
                        " קבוצה:" + widget._currGroupObject,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    new Expanded(child: ProductList(widget._products))
                  ],
                ))));
  }

  void _addProduct(productslist) {
    setState(() {
      widget._products = productslist;
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: widget._scaffoldKey.currentContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "הוספת מוצר חדש",
            textAlign: TextAlign.right,
          ),
          content: TextField(
            controller: widget.myAddProductModelTextbox,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(hintText: "הכנס את המוצר שאתה רוצה"),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Add"),
              onPressed: () async {
                //add post request to the db and add to the local list
                // widget._products.add(widget.myAddProductModelTextbox.text);
                var products = widget._products;
                products.add({
                  "productname": widget.myAddProductModelTextbox.text,
                  "productauthor": '1',
                  "listid": '1'
                });
                _addProduct(products);
                try {
                  await http.post("https://me-kone.herokuapp.com/items/",
                      body: {
                        "name": widget.myAddProductModelTextbox.text,
                        "author": '1',
                        "list": '1'
                      });
                } catch (e) {
                  print(e);
                }
                print("added to db");
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
            onPressed: () {
              _showDialog();
            },
            child: Icon(Icons.edit),
            backgroundColor: Colors.black,
            tooltip: 'New product',
          ),
        ),
      ),
    );
  }
}
