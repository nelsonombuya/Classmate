// # Imports
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

/// # Background Video Player
/// Used to play a video background on any screen
/// ? Can be extended to include network videos/images as well
class BackgroundVideoPlayer extends StatefulWidget {
  BackgroundVideoPlayer({@required this.video, @required this.placeholder});
  final String placeholder;
  final String video;

  @override
  _BackgroundVideoPlayerState createState() => _BackgroundVideoPlayerState();
}

class _BackgroundVideoPlayerState extends State<BackgroundVideoPlayer> {
  // # Video Controller
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.video)
      ..initialize().then((_) => setState(() {}));
    _controller.setLooping(true);
    _controller.setVolume(0.0);
    _controller.play();
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
          // Shows the video once it has been initialized
          ? Stack(
              children: <Widget>[
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      height: _controller.value.size?.height ?? 0,
                      width: _controller.value.size?.width ?? 0,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
              ],
            )
          // Shows an image while the video is initializing
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
