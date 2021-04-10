// # Imports
import 'package:classmate/presentation/pages/welcome/background_video_player_widget.dart';
import 'package:classmate/presentation/pages/welcome/create_new_account_widget.dart';
import 'package:classmate/presentation/pages/welcome/sign_in_with_email_widget.dart';
import 'package:classmate/presentation/pages/welcome/video_credits_widget.dart';
import 'package:classmate/presentation/widgets/custom_loading_elevatedButton_widget.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:flutter/material.dart';

/// # Welcome Page
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Properties
    String _video;
    Color _buttonColor;
    Color _captionColor;
    String _videoCredits;

    // Setting properties according to Dark or Light Modes
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      _video = 'dark';
      _buttonColor = Colors.white70;
      _videoCredits = 'Video by Tima Miroshnichenko from Pexels';
    } else {
      _video = 'light';
      _buttonColor = Colors.white;
      _captionColor = Colors.white;
      _videoCredits = 'Video by Pavel Danilyuk from Pexels';
    }

    // Returning the view
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return Scaffold(
          body: Container(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // FIXME Placeholder Image Jumps before image loads
                // FIXME Doesn't scale well on some devices
                // FIXME Crashes after too many re-initializations
                // # Background Video
                BackgroundVideoPlayer(
                  video: 'assets/videos/welcome_screen_$_video.mp4',
                  placeholder:
                      'assets/videos/welcome_screen_${_video}_placeholder.png',
                ),

                // # The Welcome Page Content
                SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        // # Some Space
                        SizedBox(height: sy(50)),

                        // # Opacity for the text and icon
                        Opacity(
                          opacity: 0.8,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: sx(20.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // # Logo
                                Container(
                                  width: sx(140.0),
                                  height: sx(140.0),
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    'assets/images/logo/white_plain.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),

                                // # ClassMate Text
                                Row(
                                  children: [
                                    Text(
                                      "Class",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          .copyWith(
                                            fontSize: sy(36),
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                    Text(
                                      "Mate",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          .copyWith(
                                            fontSize: sy(36),
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // # Some Space
                        SizedBox(height: sy(200.0)),

                        // # Sign In & Sign Up Buttons
                        Center(
                          child: Column(
                            children: [
                              SignInWithEmailButton(),
                              SizedBox(height: sy(20.0)),
                              CreateANewAccountButton(
                                  buttonColor: _buttonColor),
                              SizedBox(height: sy(40.0)),
                              VideoCreditsWidget(
                                videoCredits: _videoCredits,
                                color: _captionColor,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
