import 'package:flutter/material.dart';
import 'package:fake_tiktok/animations/spinner_animation.dart';
import 'package:fake_tiktok/models/video_model.dart';
import 'package:fake_tiktok/resources/assets.dart';
import 'package:fake_tiktok/widgets/home/audio_spinner_icon.dart';
import 'package:fake_tiktok/widgets/home/controls/comment_tile.dart';
import 'package:fake_tiktok/widgets/home/controls/video_control_action.dart';
import 'package:fake_tiktok/widgets/home/video_metadata/user_profile.dart';
import 'package:fake_tiktok/widgets/home/video_metadata/video_desc.dart';

import 'like_button.dart';

class ScreenControls extends StatefulWidget {
  final VideoModel videoModel;

  ScreenControls(this.videoModel,{Key key}) : super(key: key);

  @override
  _ScreenControlsState createState() => _ScreenControlsState();
}

class _ScreenControlsState extends State<ScreenControls> {
  TextEditingController textEditController = TextEditingController();

  VideoModel get videoModel => widget.videoModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 5, 
            child: videoDesc()
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(bottom: 60, right: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  userProfile(),
                  LikeButton(videoModel),
                  GestureDetector(
                    child: videoControlAction(
                      icon: AppIcons.chat_bubble, 
                      label: "${videoModel.comments.length}"
                    ),
                    onTap: () async {
                      await _onCommentsPressed();
                    },
                  ),
                  videoControlAction(
                    icon: AppIcons.reply, 
                    label: "Share", 
                    size: 27
                  ),
                  SpinnerAnimation(body: audioSpinner())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future _onCommentsPressed() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child:Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                  child: Container(
                    color: Colors.grey[100],
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Text(
                            "${videoModel.comments.length} comments",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ) 
                        ),
                        Positioned(
                          right: 2,
                          top: 2,
                          bottom: 2,
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: Container(
                    color: Colors.grey[100],
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8, left: 8, top: 8, right: 8),
                      child: ListView.builder(
                        itemCount: videoModel.comments.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CommentTile(videoModel.comments[index]);
                        }
                      ),
                    )
                  )
                ),
                SizedBox(
                  height: 80,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(10.0),
                              hintText: 'Add comment...'
                            ),
                            controller: textEditController,
                            onSubmitted: (text) {
                              setState(() {
                                videoModel.comments.add(text);
                              });
                              textEditController.clear();
                            },
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon:  Icon(Icons.send),
                            onPressed: () {
                              setState(() {
                                videoModel.comments.add(textEditController.value.text);
                              });
                              textEditController.clear();
                            },
                          ),
                        )
                      ],
                    )
                  ),
                )
              ],
            )
          )
        );
      }
    );
  }

  Widget bottomSheetBuilder(){
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
      color: Colors.transparent, // for some reasons transparent doesn't work
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular( 16.0)
            )
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
              child: Container(
                color: Colors.grey[100],
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "${videoModel.comments.length} comments",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      ) 
                    ),
                    Positioned(
                      right: 2,
                      top: 2,
                      bottom: 2,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[100],
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8, left: 8, top: 8, right: 8),
                  child: ListView.builder(
                    itemCount: videoModel.comments.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CommentTile(videoModel.comments[index]);
                    }
                  ),
                )
              )
            ),
            SizedBox(
              height: 80,
              child: Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText: 'Add comment...'
                        ),
                        controller: textEditController,
                        onSubmitted: (text) {
                          videoModel.comments.add(text);
                          setState(() {});
                          textEditController.clear();
                        },
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon:  Icon(Icons.send),
                        onPressed: () {
                          videoModel.comments.add(textEditController.value.text);
                          setState(() {});
                        },
                      ),
                    )
                  ],
                )
              ),
            )
          ],
        )
      ),
    )
    );
  }
}
