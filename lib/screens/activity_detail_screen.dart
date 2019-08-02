import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_tech_test/data/mock_data.dart';
import 'package:go_tech_test/data/models.dart';
import 'package:go_tech_test/widgets/common_widgets.dart';
import 'package:go_tech_test/widgets/data_item_datetime.dart';

class ActivityDetailsScreen extends StatefulWidget {
  ActivityDetailsScreen(this.activity);

  final Activity activity;

  @override
  _ActivityDetailsScreenState createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _locationController;
  DateTimeController _dateTimeController;

  final focusTitle = FocusNode();
  final focusDescription = FocusNode();
  final focusLocation = FocusNode();

  static const String NEW_IMAGE =
      "https://cdn.pixabay.com/photo/2014/12/16/22/25/youth-570881_960_720.jpg";

  var dateTime = new DateTime.now();

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.activity?.title);
    _descriptionController =
        TextEditingController(text: widget.activity?.description);
    _locationController =
        TextEditingController(text: widget.activity?.location);
    _dateTimeController =
        DateTimeController(datetime: widget.activity?.datetime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          title: Text(widget.activity.title ?? "New Activity"),
          actions: _isMine()
              ? [
                  Builder(builder: (context) {
                    return IconButton(
                      key: Key("okButton"),
                      icon: Icon(Icons.check),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          showSnackBar("Saving Data");
                          StreamSubscription<String> listener;
                          listener = mockDataBloc.stringDataStream.listen(
                              (String data) {
                            Navigator.of(context, rootNavigator: true).pop();
                            listener?.cancel();
                          }, onError: (error) {
                            showSnackBar("error.$error");
                            listener?.cancel();
                          });
                          mockDataBloc.createOrUpdateActivity(Activity(
                            id: widget.activity?.id,
                            title: _titleController.text,
                            owner: mockDataBloc.me,
                            image: NEW_IMAGE,
                            location: _locationController.text,
                            description: _descriptionController.text,
                            datetime: _dateTimeController.datetime,
                          ));
                        }
                      },
                    );
                  }),
                ]
              : null),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Hero(
              tag: widget.activity.id ?? "0",
              child: Image.network(
                widget.activity.image ?? NEW_IMAGE,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter an activity";
                  } else
                    return null;
                },
                autofocus: _isMine() && (widget.activity?.id == null),
                enabled: _isMine(),
                controller: _titleController,
                focusNode: focusTitle,
                onFieldSubmitted: (v) {
                  FocusScope.of(context).requestFocus(focusDescription);
                },
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0),
                decoration: InputDecoration(
                    labelText: "Activity",
                    hintText: "What do you want to do?")),
            dataItemUser("Who", widget.activity.owner),
            dataItem(
                label: "What",
                value: widget.activity.description,
                controller: _descriptionController,
                hint: "Description of the activity",
                focus: focusDescription,
                nextFocus: focusLocation,
                editable: _isMine(),
                multiline: true),
            dataItem(
                label: "Where",
                value: widget.activity.location,
                controller: _locationController,
                hint: "Location of the event",
                focus: focusLocation,
                editable: _isMine()),
            DataItemDateTime(
              label: "When",
              controller: _dateTimeController,
              hint: "Please select a date"
            ),
          ],
        ),
      ),
    );
  }

  _isMine() {
    return (widget.activity.owner == mockDataBloc.me);
  }

  showSnackBar(String textKey) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(textKey)));
  }
}
