import 'package:flutter/material.dart';
import 'package:go_tech_test/data/mock_data.dart';
import 'package:go_tech_test/data/models.dart';
import 'package:go_tech_test/widgets/activity_card.dart';
import 'package:go_tech_test/widgets/activity_tile.dart';

import 'activity_detail_screen.dart';

class ActivityFeed extends StatefulWidget {
  ActivityFeed({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  @override
  void dispose() {
    mockDataBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    mockDataBloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listKey = GlobalKey<AnimatedListState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey,
      body: StreamBuilder<List<Activity>>(
          stream: mockDataBloc.blocStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            return AnimatedList(
              key: listKey,
              initialItemCount: snapshot.data.length,
              itemBuilder: (context, index, animation) {
                return buildItem(context, index, animation, snapshot.data);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        heroTag: "btnAdd",
        onPressed: () => _navigate(Activity(owner: mockDataBloc.me)),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildItem(BuildContext context, int index, Animation<double> animation,
      List<Activity> data) {
    return InkWell(
      onTap: () => _navigate(data[index]),
      child: SizeTransition(
        key: ValueKey<int>(index),
        axis: Axis.vertical,
        sizeFactor: animation,
        child: ActivityCard(data[index]),
      ),
    );
  }

  void _navigate(Activity activity) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (_,__,___) => ActivityDetailsScreen(activity),
      ),
    );
  }
}
