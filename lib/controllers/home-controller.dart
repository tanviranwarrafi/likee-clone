import 'package:flutter/material.dart';
import 'package:likee_clone/common/api-urls.dart';
import 'package:likee_clone/models/video.dart';
import 'package:likee_clone/services/api-service.dart';

class HomeController with ChangeNotifier {
  ApiService apiService = ApiService();
  List<Video> videos = [];
  bool loader = true;

  initController() {
    // this.fetchVideos();
  }

  disposeController() {
    videos = [];
    loader = true;
  }

  fetchVideos() async {
    apiService.httpGetMethod(endPoint: ApiUrl.videos).then((value) {
      if (value != null) {
        final videoList = value.map((json) => Video.fromJson(json)).toList();
        List<Video> tempList = [];
        for (int i = 0; i < videoList.length; i++) {
          tempList.add(videoList[i]);
        }
        if (tempList.length > 0) {
          videos.addAll(tempList);
        }
        loader = false;
        notifyListeners();
      } else {
        loader = false;
        notifyListeners();
      }
    });
  }
}
