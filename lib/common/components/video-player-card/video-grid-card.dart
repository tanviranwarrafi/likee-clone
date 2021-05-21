import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:likee_clone/common/widgets/image-loader.dart';
import 'package:likee_clone/models/video.dart';
import 'package:likee_clone/utils/constraints.dart';
import 'package:likee_clone/utils/size-config.dart';

class VideoGridCard extends StatelessWidget {
  final Video video;
  final Function onTap;

  VideoGridCard({this.video, this.onTap});

  @override
  Widget build(BuildContext context) {
    var block = SizeConfig.block;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: video.userPic,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            colorBlendMode: BlendMode.darken,
            placeholder: (context, url) => ImageLoader(color: Colors.pinkAccent, size: block * 7),
            errorWidget: (context, url, error) => Image.asset("assets/images/icons/cover.png", fit: BoxFit.cover),
          ),
          Positioned(
            left: block * 2.5,
            bottom: block,
            child: CircleAvatar(
              radius: block * 3.5,
              backgroundColor: Colors.pinkAccent,
              backgroundImage: NetworkImage(video.userPic),
            ),
          ),
          Positioned(
            right: block * 2.5,
            bottom: block * 2.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.favorite_outline_sharp, color: white, size: block * 4.5),
                SizedBox(width: block / 2),
                Text(video.likes, style: TextStyle(color: white, fontSize: block * 3.5))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
