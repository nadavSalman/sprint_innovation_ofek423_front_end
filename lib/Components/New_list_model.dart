import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewListModel extends StatefulWidget {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  var myAddListModelTextbox = TextEditingController();

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
          Text(
            "${widget.selectedDate.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            widget.selectedTime.format(context),
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          RaisedButton(
            onPressed: () => _selectDateAndTime(context),
            child: Text(
              'Click to choose',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            color: Color(0XffF3C33F),
          ),
        ],
      ),
    );
  }
}
