import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  var _products = [];

  ProductList(this._products);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
          },
        ));
  }
}
