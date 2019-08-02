import 'package:flutter/material.dart';

class DataItemReadOnly extends StatelessWidget {
  DataItemReadOnly({
    this.label,
    this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    if (value != null) {
      return ListTile(
          title: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            value,
          ));
    }
    return SizedBox.shrink();
  }
}
