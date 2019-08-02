import 'package:flutter/material.dart';
import 'package:go_tech_test/data/models.dart';

class ActivityTile extends StatelessWidget {
  final Activity activity;

  ActivityTile(this.activity);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListTile(
        leading: Hero(
          tag: activity.id,
          child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(activity.image),
                  )
              )),
        ),
        title: Text('${activity.title}'),
        subtitle: Text("${activity.description}"),
      ),
    );
  }
}