import 'package:flutter/material.dart';
import 'Lists_page.dart';

class OpenPage extends StatefulWidget {
  @override
  _OpenPageState createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
  @override
  // todo: replace the groups list with data from DB
  final List<String> groups = [
    "hamagnivim",
    "ohad",
    "ronen",
    "yuval",
    "hadas",
    "hi",
    "ohad",
    "ronen",
    "yuval",
    "hadas"
  ];

  var userName = '';

  Widget _buildRow(BuildContext context, int index) {
    //logic code
    if (index.isEven) {
      return ListTile(
        title: Text(
          groups[index ~/ 2]
              .toUpperCase(), //take the string from groups in index of index/2 in integer
        ),
        onTap: () {
          // need to get from the server all the lists for the right username and right group and send to lists page
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListsPage(groups, this.userName)),
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

  _showCreateGroupModel() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Material Dialog"),
              content: new Text("Hey! fffffI'm Coflutter!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
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
      body: _buildOptions(),
      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: _showCreateGroupModel,
            child: Icon(Icons.add),
            backgroundColor: Colors.black,
            tooltip: 'New group',
          ),
        ),
      ),
    );
  }
}
