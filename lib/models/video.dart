class Video {
  String comments;
  String likes;
  String songName;
  String url;
  String user;
  String userPic;
  String videoTitle;

  Video({this.comments, this.likes, this.songName, this.url, this.user, this.userPic, this.videoTitle});

  Video.fromJson(Map<String, dynamic> json) {
    comments = json['comments'];
    likes = json['likes'];
    songName = json['song_name'];
    url = json['url'];
    user = json['user'];
    userPic = json['user_pic'];
    videoTitle = json['video_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comments'] = this.comments;
    data['likes'] = this.likes;
    data['song_name'] = this.songName;
    data['url'] = this.url;
    data['user'] = this.user;
    data['user_pic'] = this.userPic;
    data['video_title'] = this.videoTitle;
    return data;
  }
}
