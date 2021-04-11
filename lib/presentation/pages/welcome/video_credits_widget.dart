// # Imports
import 'package:flutter/material.dart';

/// # Video Credits Widget
/// Used to display a caption for the video or image used
/// on the welcome page.
class VideoCreditsWidget extends StatelessWidget {
  VideoCreditsWidget({@required this.videoCredits, this.color});
  final String videoCredits;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      videoCredits,
      style: Theme.of(context).textTheme.caption.copyWith(color: color),
    );
  }
}
