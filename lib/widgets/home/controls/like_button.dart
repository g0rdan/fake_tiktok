import 'package:flutter/material.dart';
import 'package:fake_tiktok/models/video_model.dart';
import 'package:fake_tiktok/resources/assets.dart';

class LikeButton extends StatefulWidget {
  final VideoModel videoModel;

  LikeButton(this.videoModel, {Key key}) : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _like;
  
  @override
  void initState() {
    _like = widget.videoModel.like;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Icon(
          AppIcons.heart,
          color: _like ? Colors.red : Colors.white,
          size: 35,
        )
      ),
      onTap: () {
        setState(() {
          _like = !_like;
        });
      },
    );
  }
}
