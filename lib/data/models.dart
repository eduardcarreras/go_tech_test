
import 'package:intl/intl.dart';

class Activity {
  Activity({
    this.id,
    this.title,
    this.description,
    this.image,
    this.owner,
    this.location,
    this.datetime,
  });

  String id;
  final String title;
  final String description;
  final String image;
  final User owner;
  final String location;
  final DateTime datetime;

  String getDate() {
    if (datetime == null) return "No date";
    return DateFormat.yMMMd().add_jm().format(datetime);
  }}

class User {
  User({
    this.name,
    this.avatar,
    this.location,
  });

  final String name;
  final String avatar;
  final String location;
}
