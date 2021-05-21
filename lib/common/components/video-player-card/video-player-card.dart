import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:likee_clone/common/components/video-player-card/player-components.dart';
import 'package:likee_clone/common/widgets/image-loader.dart';
import 'package:likee_clone/models/video.dart';
import 'package:likee_clone/utils/size-config.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final Video video;

  VideoPlayerItem({this.video});

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.video.url)
      ..initialize().then((_) {
        setState(() {
          controller.play();
          controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var height = SizeConfig.screenHeight;
    var width = SizeConfig.screenWidth;
    var block = SizeConfig.block;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Container(
              color: Colors.transparent,
              height: double.infinity,
              child: controller.value.initialized
                  ? GestureDetector(
                      onTap: () {
                        if (controller.value.isPlaying) {
                          controller.pause();
                        } else {
                          controller.play();
                        }
                      },
                      child: AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      ),
                    )
                  : loadingVideo(),
            ),
            Positioned(
              top: block * 10,
              left: 0,
              right: 0,
              child: HeaderHomePage(),
            ),
            Positioned(
              bottom: block * 5,
              left: block * 5,
              child: LeftPanel(
                caption: widget.video.videoTitle,
                name: widget.video.user,
                songName: widget.video.songName,
              ),
            ),
            Positioned(
              right: block * 5,
              bottom: block * 5,
              child: RightPanel(video: widget.video),
            ),
          ],
        ),
      ),
    );
  }

  /*Widget loadingVideo() => Container(
        color: Colors.black,
        child: Center(
          child: GFLoader(
            type: GFLoaderType.circle,
            loaderColorOne: amber,
            loaderColorTwo: Color(0xFFF61E6C),
            loaderColorThree: Color(0xFF6700CF),
          ),
        ),
      );*/
  Widget loadingVideo() => CachedNetworkImage(
        imageUrl: 'https://picsum.photos/seed/picsum/200/300.jpg',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        colorBlendMode: BlendMode.darken,
        placeholder: (context, url) => ImageLoader(color: Colors.pinkAccent, size: 25),
      );
}
