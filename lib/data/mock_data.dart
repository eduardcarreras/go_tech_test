import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'models.dart';
import 'package:http/http.dart' as http;

class MockData {
  static const WEEKDAYS = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List<Activity> activities = [];
  List<User> users = [];
  User me = User(
    name: "Eduard Carreras",
    avatar: "https://uploads.toptal.io/user/photo/428703/large_dbd34d24f6a1440e5437f561cf156115.png",
    location: "Barcelona"
  );

  final _blocStreamController = StreamController<List<Activity>>.broadcast();
  final _blocActionStreamController = StreamController<String>.broadcast();

  StreamSink<List<Activity>> get blocSink => _blocStreamController.sink;
  Stream<List<Activity>> get blocStream => _blocStreamController.stream;

  StreamSink<String> get stringDataSink => _blocActionStreamController.sink;
  Stream<String> get stringDataStream => _blocActionStreamController.stream;

  init() async {
    await _fillUsers();
    for (int i = 0; i < 50; i++) {
      var title = _getMockTitle();
      var image = _getMockImage(title);
      var owner = _getMockOwner();
      var location = _getMockLocation();
      var datetime = _getMockDateTime();
      var activity = Activity(
        id: "A${i.toString().padLeft(4, '0')}",
        title: title,
        image: image,
        owner: owner,
        datetime: datetime,
        description: _getMockDescription(title, location, datetime),
        location: location,
      );
      activities.add(activity);
      blocSink.add(activities);
    }
    _sortActivities();
  }

  void createOrUpdateActivity(Activity activity) {
    if (activity.id == null) {
      activity.id = "A${activities.length.toString().padLeft(4, '0')}";
      activities.add(activity);
      stringDataSink.add("OK");
    } else {
      activities.removeWhere((a) => (a.id == activity.id));
      activities.add(activity);
      stringDataSink.add("OK");
    }
    _sortActivities();
  }

  _sortActivities() {
    activities.sort((a,b)=>(a.datetime.compareTo(b.datetime)));
  }

  _getMockTitle() {
    var list = ['Biking', 'Hiking', 'Bowling', 'Go out', 'Yoga', 'Conference'];

    return list[Random().nextInt(list.length)];
  }

  _fillUsers() async {
    final response = await http
        .get("https://uinames.com/api/?amount=25&ext&region=united%20states");
    var items = json.decode(response.body);
    for (var item in items) {
      users.add(User(
        name: "${item['name']} ${item['surname']}",
        avatar: item['photo'],
      ));
    }
  }

  _getMockOwner() {
    return users[Random().nextInt(users.length)];
  }

  _getMockDateTime() {
    var _random = Random();
    var date = DateTime.now();
    date = date.add(Duration(days: _random.nextInt(7)));
    return DateTime(
        date.year, date.month, date.day, 8 + _random.nextInt(16), 0, 0, 0, 0);
  }

  _getMockDescription(title, location, DateTime date) {
    var list = [
      "$title at $location. Anyone?",
      "I will be $title at $location on ${WEEKDAYS[date.weekday]}",
      "Someone want to join me $title at $location on ${WEEKDAYS[date.weekday]}?",
      "It will be great to do some $title on ${WEEKDAYS[date.weekday]}. It will be in $location",
    ];

    return list[Random().nextInt(list.length)];
  }

  _getMockLocation() {
    var list = ["Bronx", "Brooklyn", "Manhattan", "Queens"];

    return list[Random().nextInt(list.length)];
  }

  String _getMockImage(title) {
    switch (title) {
      case 'Biking':
        return "https://cdn.pixabay.com/photo/2013/03/19/18/23/utah-95032_960_720.jpg";
      case 'Hiking':
        return "https://cdn.pixabay.com/photo/2016/11/09/15/40/hiking-1811970_960_720.jpg";
      case 'Bowling':
        return "https://cdn.pixabay.com/photo/2017/09/22/21/39/bowling-2777169_960_720.jpg";
      case 'Go out':
        return "https://cdn.pixabay.com/photo/2017/08/03/21/48/drinks-2578446_960_720.jpg";
      case 'Yoga':
        return "https://cdn.pixabay.com/photo/2017/08/02/20/24/people-2573216_960_720.jpg";
      case 'Conference':
        return "https://cdn.pixabay.com/photo/2013/02/20/01/04/meeting-83519_960_720.jpg";
      case 'Kayak':
        return "https://cdn.pixabay.com/photo/2016/08/01/20/13/girl-1561989_960_720.jpg";
    }
    return "https://cdn.pixabay.com/photo/2014/12/16/22/25/youth-570881_960_720.jpg";
  }

  dispose() {
    _blocStreamController.close();
    _blocActionStreamController.close();
  }

}

final MockData mockDataBloc = MockData();
