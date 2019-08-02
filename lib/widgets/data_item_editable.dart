import 'package:flutter/material.dart';

class DataItemEditable extends StatelessWidget {
  DataItemEditable(
      {this.controller,
      this.label,
      this.hint,
      this.value,
      this.focus,
      this.nextFocus,
      this.multiline = false,
      this.editable = false,
      this.focused = false});

  final TextEditingController controller;
  final String label;
  final String hint;
  final String value;
  final FocusNode focus;
  final FocusNode nextFocus;
  final bool multiline;
  final bool editable;
  final bool focused;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter a value";
            } else
              return null;
          },
          autofocus: focused,
          enabled: editable,
          focusNode: focus,
          onFieldSubmitted: (v) {
            if (nextFocus != null)
              FocusScope.of(context).requestFocus(nextFocus);
          },
          keyboardType: TextInputType.text,
          maxLines: multiline ? 2 : 1,
          controller: controller,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration.collapsed(hintText: hint)),
    );
  }
}
