import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:convert';
import 'package:http/io_client.dart';

class NewListModel extends StatefulWidget {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  var myAddListModelTextbox = TextEditingController();
  var currGroupObject;
  var currUserObject;
  final updateLists;

  NewListModel(this.currUserObject, this.currGroupObject, this.updateLists);
  @override
  _NewListModelState createState() => _NewListModelState();
}

class _NewListModelState extends State<NewListModel> {
  _selectDateAndTime(BuildContext context) async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    TimeOfDay pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedDate != null && pickedDate != widget.selectedDate ||
        pickedTime != null && pickedTime != widget.selectedTime)
      setState(() {
        widget.selectedTime = pickedTime;
        widget.selectedDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: widget.myAddListModelTextbox,
            textInputAction: TextInputAction.go,
            textAlign: TextAlign.right,
            decoration: InputDecoration(hintText: "הכנס את שם המקום"),

          ),
          Divider(),
          // Directionality(textDirection:, child: ),
          Text(
            "תאריך:",
            textAlign: TextAlign.right,
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Text(
            "${widget.selectedDate.toLocal()} ".split(' ')[0],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            " " + widget.selectedTime.format(context),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),]),
          RaisedButton(
            onPressed: () => _selectDateAndTime(context),
            child: Text(
              'Click to choose',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            color: Color(0XffF3C33F),
          ), 
            

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ new FlatButton(
            child: new Text("Create"),
            onPressed: () async {
              try {
                DateTime newDateToDB = new DateTime(widget.selectedDate.year, widget.selectedDate.month, widget.selectedDate.day, widget.selectedTime.hour, widget.selectedTime.minute);
                String dateInString = newDateToDB.toIso8601String();
                var newListToDB;
                newListToDB = {
                  "team": widget.currGroupObject["teamid"],
                  "creator": widget.currUserObject["id"], 
                  "date": dateInString, 
                  "location": widget.myAddListModelTextbox.text
                };
                var jsonBody = jsonEncode(newListToDB);
                print(jsonBody);
                final ioc = new HttpClient();
                ioc.badCertificateCallback =
                    (X509Certificate cert, String host, int port) => true;
                final http = new IOClient(ioc);
                await http.post("https://me-kone.herokuapp.com/lists/list",
                    body: jsonBody,
                    headers: {
                      "accept": "application/json",
                      "content-type": "application/json"
                    }).then((res) {
                  print("Reponse status : ${res.statusCode}");
                  print("Response body : ${res.body}");
                    });
                    String getReqBody = "https://me-kone.herokuapp.com/lists/" +
                        widget.currGroupObject["teamid"].toString();
                    print(getReqBody);
                    await http.get(getReqBody).then((res) {
                      print(res.body);
                      widget.updateLists(jsonDecode(res.body));
                    });
              } catch (e) {
                print(e.toString());
              }
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )]
          )],
      ),
    );
  }
}
