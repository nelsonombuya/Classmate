// # Imports
import 'package:classmate/presentation/pages/welcome/background_video_player_widget.dart';
import 'package:classmate/presentation/pages/welcome/create_new_account_widget.dart';
import 'package:classmate/presentation/pages/welcome/sign_in_with_email_widget.dart';
import 'package:classmate/presentation/pages/welcome/video_credits_widget.dart';
import 'package:classmate/constants/device.dart';
import 'package:flutter/material.dart';

/// # Welcome Page
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Properties
    String _video;
    String _videoCredits;
    Color _captionColor;
    Device().init(context);

    // Setting properties according to Dark or Light Modes
    if (Device.brightness == Brightness.dark) {
      _video = 'dark';
      _captionColor = Colors.white70;
      _videoCredits = 'Video by Tima Miroshnichenko from Pexels';
    } else {
      _video = 'light';
      _captionColor = Colors.white;
      _videoCredits = 'Video by Pavel Danilyuk from Pexels';
    }

    // Returning the view
    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // FIXME Placeholder Image Jumps before image loads
            // FIXME Doesn't scale well on some devices
            // FIXME Crashes after too many re-initializations
            // ! OOM Crash, comment lines out when testing
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
                    SizedBox(height: Device.height(10)),

                    // # Opacity for the text and icon
                    Opacity(
                      opacity: 0.8,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Device.width(5.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // # Logo
                            Container(
                              width: Device.width(26.0),
                              height: Device.width(26.0),
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
                                        fontWeight: FontWeight.w300,
                                        fontSize: Device.height(7),
                                        color: Colors.white,
                                      ),
                                ),
                                Text(
                                  "Mate",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Device.height(7),
                                        color: Colors.blue,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // # Some Space
                    SizedBox(height: Device.height(38.0)),

                    // # Sign In & Sign Up Buttons
                    Center(
                      child: Column(
                        children: [
                          SignInWithEmailButton(),
                          SizedBox(height: Device.height(4.0)),
                          CreateANewAccountButton(),
                          SizedBox(height: Device.height(8.0)),
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
  }
}
