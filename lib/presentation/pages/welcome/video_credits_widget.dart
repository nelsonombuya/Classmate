// # Imports
import 'package:flutter/material.dart';

/// # Video Credits Widget
/// Used to display a caption for the video or image used
/// on the welcome page.
class VideoCreditsWidget extends StatelessWidget {
  VideoCreditsWidget({@required this.videoCredits});
  final String videoCredits;

  @override
  Widget build(BuildContext context) {
    return Text(
      videoCredits,
      style: Theme.of(context).textTheme.caption,
    );
  }
}
