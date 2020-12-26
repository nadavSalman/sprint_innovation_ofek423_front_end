import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  var _products = [];
  var _allUsers;

  ProductList(this._products, this._allUsers);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  getItemName(int index) {
    
    var authorName =  widget._allUsers.firstWhere((obj) => obj["userid"] ==  widget._products[index ~/ 2]["productauthor"]);
    return widget._products[index ~/ 2]["productname"]+ " ל-" + authorName["userfullname"];
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: new ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          itemCount: widget._products.length * 2,
          itemBuilder: (BuildContext context, int index) {
            if (index.isEven) {
              return ListTile(
                title: Text(
                  getItemName(index),
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            } else {
              return Divider();
            }
          },
        ));
  }
}
