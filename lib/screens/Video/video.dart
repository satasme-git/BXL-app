import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
        title: const Text(""),
        backgroundColor: Colors.black,
      ),
      body: Scaffold(
        backgroundColor: Colors.black87,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
