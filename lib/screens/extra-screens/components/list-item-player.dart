import 'dart:async';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:likee_clone/common/components/video-player-card/player-components.dart';
import 'package:likee_clone/utils/size-config.dart';

class ListItemPlayer extends StatefulWidget {
  final int index;
  final String videoUrl;
  final ValueNotifier<double> notifier;

  ListItemPlayer({@required this.index, @required this.notifier, this.videoUrl});

  @override
  _ListItemPlayerState createState() => _ListItemPlayerState();
}

class _ListItemPlayerState extends State<ListItemPlayer> {
  FijkPlayer _player;
  Timer _timer;
  bool _start = false;
  bool _expectStart = false;

  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(scrollListener);
    int mills = widget.index <= 3 ? 100 : 500;
    _timer = Timer(Duration(milliseconds: mills), () async {
      _player = FijkPlayer();
      await _player?.setDataSource(
        widget.videoUrl,
      );
      await _player?.prepareAsync();
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
    if (_player != null && widget.index == x) {
      _expectStart = true;
      _player.removeListener(pauseListener);
      if (_start == false && _player.isPlayable()) {
        FijkLog.i("start from scroll listener $_player");
        _player.start();
        _start = true;
      } else if (_start == false) {
        FijkLog.i("add start listener $_player");
        _player.addListener(startListener);
      }
    } else if (_player != null) {
      _expectStart = false;
      _player.removeListener(startListener);
      if (_player.isPlayable() && _start) {
        FijkLog.i("pause from scroll listener $_player");
        _player.pause();
        _start = false;
      } else if (_start) {
        FijkLog.i("add pause listener $_player");
        _player.addListener(pauseListener);
      }
    }
  }

  void startListener() {
    FijkValue value = _player.value;
    if (value.prepared && !_start && _expectStart) {
      _start = true;
      FijkLog.i("start from player listener $_player");
      _player.start();
    }
  }

  void pauseListener() {
    FijkValue value = _player.value;
    if (value.prepared && _start && !_expectStart) {
      _start = false;
      FijkLog.i("pause from player listener $_player");
      _player?.pause();
    }
  }

  void finalizer() {
    _player?.removeListener(startListener);
    _player?.removeListener(pauseListener);
    var player = _player;
    _player = null;
    player?.release();
  }

  @override
  void dispose() {
    super.dispose();
    widget.notifier.removeListener(scrollListener);
    _timer?.cancel();
    finalizer();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    FijkFit fit = FijkFit(sizeFactor: 1.0, aspectRatio: 480 / 270, alignment: Alignment.center);
    return RotatedBox(
      quarterTurns: -1,
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: _player != null
                ? FijkView(
                    player: _player,
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
