import 'package:flutter/material.dart';
import 'package:likee_clone/common/components/video-player-card/video-player-card.dart';
import 'package:likee_clone/models/demo-data.dart';

class VideoListView extends StatefulWidget {
  final int listIndex;

  VideoListView({this.listIndex});

  @override
  _VideoListViewState createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> with SingleTickerProviderStateMixin {
  final ValueNotifier<double> notifier = ValueNotifier(-1);
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: likeeVideos.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          notifier.value = notification.metrics.pixels;
          return true;
        },
        child: RotatedBox(
          quarterTurns: 1,
          child: TabBarView(
            controller: tabController,
            children: List.generate(likeeVideos.length, (startItem) {
              return VideoPlayerItem(video: likeeVideos[startItem]);
            }),
          ),
        ),
      ),
    );
  }
}
