import 'package:flutter/material.dart';
import 'package:likee_clone/common/components/video-player-card/video-grid-card.dart';
import 'package:likee_clone/common/components/video-player-card/video-player-card.dart';
import 'package:likee_clone/models/demo-data.dart';
import 'package:likee_clone/models/video.dart';
import 'package:likee_clone/utils/constraints.dart';
import 'package:likee_clone/utils/size-config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final ValueNotifier<double> notifier = ValueNotifier(-1);
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: likeeVideos.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: Icon(Icons.account_circle, color: amber, size: 30),
        titleSpacing: 0,
        title: Text('Follow', style: TextStyle(color: grey, fontSize: 16)),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.notifications_none_outlined, color: grey, size: 30),
          )
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          notifier.value = notification.metrics.pixels;
          return true;
        },
        child: GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          primary: false,
          itemCount: likeeVideos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: SizeConfig.orientation == Orientation.portrait ? 2 : 4,
            childAspectRatio: width / (height),
            crossAxisSpacing: block,
            mainAxisSpacing: block,
          ),
          itemBuilder: (context, index) => VideoGridCard(
            video: likeeVideos[index],
            onTap: () {
              Video video = likeeVideos[index];
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerItem(video: video)));
            },
          ),
        ),
      ),
    );
  }
}
