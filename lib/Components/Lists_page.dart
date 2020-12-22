import 'package:flutter/material.dart';

class ListsPage extends StatelessWidget {
  List _groups;
  var _name;

  List get groups => _groups;

  set groups(List value) => _groups = value;

  ListsPage(this._groups, this._name);

  Widget _buildRow(BuildContext context, int index) {
    if (index.isEven) {
      return ListTile(
        title: Text(
          groups[index ~/ 2].toUpperCase(),
        ),
        // onTap: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ListsPage(groups, this.userName)),
        //   );
        // },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meקונה',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        centerTitle: true,
      ),
      // body:   ListTile(
      //   title: Text(
      //     this._name
      //   ),

      // ),
      body: Center(
        child: _buildOptions(),
      ),
    );
  }
}
