import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//TODO: Convert to FormField<DateTime> and add validations
class DataItemDateTime extends StatefulWidget {
  static final DateTime noDate = DateTime(1714);

  DataItemDateTime({this.controller, this.label, this.hint, this.clear=false});

  final DateTimeController controller;
  final String label;
  final String hint;
  final bool clear;

  @override
  _DataItemDateTimeState createState() => _DataItemDateTimeState();
}

class _DataItemDateTimeState extends State<DataItemDateTime> {
  @override
  Widget build(BuildContext context) {
    assert(widget.hint != null || widget.controller.datetime != null);

    return GestureDetector(
      onTap: () async {
        var selectedDateTime = await _selectDateTime(context);
        setState(() {
          widget.controller.datetime = selectedDateTime;
        });
      },
      child: ListTile(
          title: Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            (widget.controller.datetime != null)
                ? getDate(widget.controller.datetime)
                : widget.hint,
          )),
    );
  }

  Future<DateTime> _selectDateTime(BuildContext context) async {
    var now = DateTime.now();
    var result = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month, now.day),
      firstDate: DateTime(2017),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget child) {
        return Column(
          children: <Widget>[
            child,
            if (widget.clear)
              RaisedButton(
                child: Text("Clear date"),
                onPressed: () {
                  return DataItemDateTime.noDate;
                },
              ),
          ],
        );
      },
    );
    var timeResult = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 00),
    );
    return DateTime(result.year, result.month, result.day, timeResult.hour,
        timeResult.minute);
  }

  String getDate(DateTime date) {
    return DateFormat.yMMMd().add_jm().format(date);
  }
}

class DateTimeController {
  DateTimeController({this.datetime});

  DateTime datetime;
}
