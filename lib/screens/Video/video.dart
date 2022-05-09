import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class videoplay extends StatefulWidget {
  String Linkid;

  videoplay({
    required this.Linkid,
  });

  // const videoplay({Key? key}) : super(key: key);

  @override
  _videoplayState createState() => _videoplayState();
}

class _videoplayState extends State<videoplay> {
  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
                  // initialVideoId: _ids.first,

                  initialVideoId: widget.Linkid,
                  flags: const YoutubePlayerFlags(
                    mute: false,
                    autoPlay: true,
                    disableDragSeek: false,
                    loop: false,
                    isLive: false,
                    forceHD: false,
                    enableCaption: true,
                  ),
                );
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
