import 'package:flutter/material.dart';
import 'package:likee_clone/models/video.dart';
import 'package:likee_clone/utils/constraints.dart';
import 'package:likee_clone/utils/size-config.dart';

class HeaderHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var block = SizeConfig.block;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Following", style: TextStyle(color: white, fontSize: 17, fontWeight: FontWeight.bold)),
        SizedBox(width: block * 2),
        Text("|", style: TextStyle(color: white.withOpacity(0.3), fontSize: block * 4.5)),
        SizedBox(width: block * 2),
        Text("For You", style: TextStyle(color: white, fontSize: 17, fontWeight: FontWeight.bold))
      ],
    );
  }
}

class LeftPanel extends StatelessWidget {
  final String name;
  final String caption;
  final String songName;

  LeftPanel({this.name, this.caption, this.songName});

  @override
  Widget build(BuildContext context) {
    var block = SizeConfig.block;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(name, style: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: block * 4)),
        SizedBox(height: block * 2.5),
        Text(caption, style: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: block * 4)),
        SizedBox(height: block * 2.5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.music_note, color: white, size: block * 4),
            SizedBox(width: block * 2.5),
            Text(songName, style: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: block * 4))
          ],
        )
      ],
    );
  }
}

class RightPanel extends StatelessWidget {
  final Video video;

  RightPanel({this.video});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var block = SizeConfig.block;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        getProfile(video.userPic),
        SizedBox(height: block * 2.5),
        getIcons(Icons.favorite, '35M'),
        SizedBox(height: block * 2.5),
        getIcons(Icons.message, '35K'),
        SizedBox(height: block * 2.5),
        getIcons(Icons.share, '35k'),
        SizedBox(height: block * 2.5),
        getAlbum('https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'),
      ],
    );
  }

  Widget getAlbum(String albumImg) {
    var block = SizeConfig.block;
    return CircleAvatar(
      backgroundColor: white,
      radius: block * 5.8,
      child: CircleAvatar(radius: block * 5.5, backgroundImage: NetworkImage(albumImg)),
    );
  }

  Widget getIcons(IconData icon, String count) {
    var block = SizeConfig.block;
    return Container(
      child: Column(
        children: <Widget>[
          Icon(icon, color: white, size: block * 10),
          SizedBox(height: block / 2),
          Text(count, style: TextStyle(color: white, fontSize: block * 3.5, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget getProfile(String img) {
    var block = SizeConfig.block;
    return Container(
      width: block * 12,
      height: block * 14,
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: white,
            radius: block * 5.8,
            child: CircleAvatar(radius: block * 5.5, backgroundImage: NetworkImage(img)),
          ),
          Positioned(
            bottom: block,
            left: 0,
            right: 0,
            child: Container(
              width: block * 5,
              height: block * 5,
              decoration: BoxDecoration(shape: BoxShape.circle, color: pink),
              child: Center(child: Icon(Icons.add, color: white, size: block * 4)),
            ),
          ),
        ],
      ),
    );
  }
}
