import 'package:flutter/material.dart';
import 'package:go_tech_test/data/models.dart';
import 'package:intl/intl.dart';

import 'data_item_editable.dart';
import 'data_item_read_only.dart';

Widget dataItemTimestamp(String key, DateTime date) {
  return DataItemReadOnly(
      label: key, value: (date == null) ? null : getDate(date));
}

String getDate(DateTime date) {
  return DateFormat.yMMMd().add_jm().format(date);
}

Widget dataItem(
    {TextEditingController controller,
    String label = "",
    String hint = "",
    String value,
    FocusNode focus,
    FocusNode nextFocus,
    bool multiline = false,
    bool editable = false,
    bool focused = false}) {
  if (editable)
    return DataItemEditable(
        label: label,
        controller: controller,
        hint: hint,
        value: value,
        focus: focus,
        nextFocus: nextFocus,
        multiline: multiline,
        editable: editable,
        focused: focused);
  else
    return DataItemReadOnly(
      label: label,
      value: value,
    );
}

Widget dataItemUser(String key, User user) {
  if (user != null) {
    return ListTile(
      title: Text(
        key,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(user.avatar),
                  ))),
          SizedBox(width: 10),
          Text(user.name),
        ],
      ),
    );
  }
  return SizedBox.shrink();
}
