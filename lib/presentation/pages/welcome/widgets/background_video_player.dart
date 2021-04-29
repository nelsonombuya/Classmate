import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideoPlayer extends StatefulWidget {
  final String placeholder;
  final String video;

  BackgroundVideoPlayer({required this.video, required this.placeholder});

  @override
  _BackgroundVideoPlayerState createState() => _BackgroundVideoPlayerState();
}

class _BackgroundVideoPlayerState extends State<BackgroundVideoPlayer> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.video)
      ..initialize().then(
        (_) => setState(
          () {
            _controller.setLooping(true);
            _controller.setVolume(0.0);
            _controller.play();
          },
        ),
      );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: _controller.value.isInitialized
          ? Stack(
              children: <Widget>[
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      height: _controller.value.size.height,
                      width: _controller.value.size.width,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.placeholder),
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
