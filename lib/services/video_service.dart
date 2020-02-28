import 'package:fake_tiktok/models/video_model.dart';

class VideoService {
  List<VideoModel> getVideos(){
    return [
      VideoModel(
        'http://techslides.com/demos/sample-videos/small.mp4',
        false,
        [
          'comment 1',
          'comment 2',
        ]
      ),
      VideoModel(
        'https://www.sample-videos.com/video123/mp4/240/big_buck_bunny_240p_5mb.mp4',
        true,
        [
          'comment 4',
          'comment 5',
          'comment 6',
          'real comment',
        ]
      )
    ];
  }
}