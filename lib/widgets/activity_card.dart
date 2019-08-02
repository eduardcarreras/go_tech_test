import 'package:flutter/material.dart';
import 'package:go_tech_test/data/models.dart';

import 'common_widgets.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;

  ActivityCard(this.activity);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: activity.id,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
/*
            Opacity(
              opacity: .3,
              child: Hero(
                tag: activity.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    activity.image
                  ),
                ),
              ),
            ),
*/
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  image: NetworkImage(activity.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                            width: 30.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(activity.owner.avatar),
                                ))),
                        SizedBox(width: 10),
                        Text(
                          activity.owner.name,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Text(
                          '${activity.title}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text("${activity.description}"),
                    SizedBox(height: 10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 10,
                          ),
                          SizedBox(width: 2),
                          Text(activity.location, style: TextStyle(fontSize: 10)),
                          SizedBox(width: 10),
                          const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                            size: 10,
                          ),
                          SizedBox(width: 2),
                          Text(activity.getDate(), style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
