import 'dart:async';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:likee_clone/common/components/video-player-card/player-components.dart';
import 'package:likee_clone/models/video.dart';
import 'package:likee_clone/utils/size-config.dart';

class SingleVideoCard extends StatefulWidget {
  final Video video;
  final ValueNotifier<double> notifier;

  SingleVideoCard({this.notifier, this.video});

  @override
  _SingleVideoCardState createState() => _SingleVideoCardState();
}

class _SingleVideoCardState extends State<SingleVideoCard> {
  FijkPlayer player;
  Timer timer;
  bool start = false;
  bool expectStart = false;

  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(scrollListener);
    int mills = 100 /*widget.index <= 3 ? 100 : 500*/;
    timer = Timer(Duration(milliseconds: mills), () async {
      player = FijkPlayer();
      await player?.setDataSource(widget.video.url, autoPlay: false, showCover: false);
      await player?.prepareAsync();
      scrollListener();
      if (mounted) {
        setState(() {});
      }
    });
  }

  void scrollListener() {
    if (!mounted) return;

    /// !!important
    /// If items in your list view have different height,
    /// You can't get the first visible item index by
    /// dividing a constant height simply

    double pixels = widget.notifier.value;
    int x = (pixels / 200).ceil();
    if (player != null /*&& widget.index == x*/) {
      expectStart = true;
      player.removeListener(pauseListener);
      if (start == false && player.isPlayable()) {
        FijkLog.i("start from scroll listener $player");
        player.start();
        start = true;
      } else if (start == false) {
        FijkLog.i("add start listener $player");
        player.addListener(startListener);
      }
    } else if (player != null) {
      expectStart = false;
      player.removeListener(startListener);
      if (player.isPlayable() && start) {
        FijkLog.i("pause from scroll listener $player");
        player.pause();
        start = false;
      } else if (start) {
        FijkLog.i("add pause listener $player");
        player.addListener(pauseListener);
      }
    }
  }

  void startListener() {
    FijkValue value = player.value;
    if (value.prepared && !start && expectStart) {
      start = true;
      FijkLog.i("start from player listener $player");
      player.start();
    }
  }

  void pauseListener() {
    FijkValue value = player.value;
    if (value.prepared && start && !expectStart) {
      start = false;
      FijkLog.i("pause from player listener $player");
      player?.pause();
    }
  }

  void finalizer() {
    player?.removeListener(startListener);
    player?.removeListener(pauseListener);
    var mediaPlayer = player;
    player = null;
    mediaPlayer?.release();
  }

  @override
  void dispose() {
    super.dispose();
    widget.notifier.removeListener(scrollListener);
    timer?.cancel();
    finalizer();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    FijkFit fit = FijkFit(
      sizeFactor: 1.0,
      aspectRatio: 480 / 270,
      alignment: Alignment.center,
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: player != null
                ? FijkView(
                    player: player,
                    fit: FijkFit.cover,
                    cover: AssetImage("assets/images/cover.png"),
                  )
                : Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: const Color(0xFF607D8B)),
                    child: Image.asset("assets/images/cover.png"),
                  ),
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: LeftPanel(name: 'Update Tech Ltd', songName: 'TikTok Demo', caption: 'Original Sound'),
          ),
          Positioned(top: block * 10, left: 0, right: 0, child: HeaderHomePage()),
          Positioned(right: 20, bottom: 20, child: RightPanel())
        ],
      ),
    );
  }
}
