import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  final String comment;
  final String _fontFamily = "TikTokIcons";

  const CommentTile(this.comment, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1.0,
            style: BorderStyle.solid),
          color: Colors.purple,
          shape: BoxShape.circle),
      ),
      title: Text(
        "user name",
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontFamily: _fontFamily
        ),
      ),
      subtitle: Text(
        comment,
        style: TextStyle(
          fontSize: 14,
          fontFamily: _fontFamily
        ),
      )
    );
  }
}