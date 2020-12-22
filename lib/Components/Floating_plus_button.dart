import 'package:flutter/material.dart';

class FloatingPlusButton extends StatefulWidget {
  @override
  _FloatingPlusButtonState createState() => _FloatingPlusButtonState();
}

class _FloatingPlusButtonState extends State<FloatingPlusButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          height: 80.0,
          width: 80.0,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
              backgroundColor: Colors.black,
              tooltip: 'New group',
            ),
          ),
        )
    );
  }
}
