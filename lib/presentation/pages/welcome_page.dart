// # Imports
import 'package:classmate/presentation/widgets/background_video_player_widget.dart';
import 'package:flutter/material.dart';

// # Welcome Page
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Properties
    String _video;
    Color _buttonColor;
    String _videoCredits;

    // Setting properties according to Dark or Light Modes
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      _video = 'dark';
      _buttonColor = Colors.white70;
      _videoCredits = 'Video by Tima Miroshnichenko from Pexels';
    } else {
      _video = 'light';
      _buttonColor = Colors.white;
      _videoCredits = 'Video by Pavel Danilyuk from Pexels';
    }

    // Returning the view
    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // FIXME Placeholder Image Jumps before image loads
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
                    SizedBox(height: 80.0),

                    // # Opacity for the text and icon
                    Opacity(
                      opacity: 0.8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // # Logo
                            Container(
                              width: 100.0,
                              height: 100.0,
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                'assets/images/logo/white_plain.png',
                                fit: BoxFit.contain,
                              ),
                            ),

                            // # Class Mate Text
                            Row(
                              children: [
                                Text(
                                  "Class",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      .copyWith(
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
                    SizedBox(height: 300.0),

                    // # Button to Sign In
                    Center(
                      child: Column(
                        children: [
                          ConstrainedBox(
                            constraints:
                                BoxConstraints.tightFor(width: 250, height: 50),
                            child: ElevatedButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/sign_in'),
                              child: Text(
                                'SIGN IN WITH E-MAIL',
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/sign_up'),
                            child: Text(
                              'CREATE A NEW ACCOUNT',
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(color: _buttonColor),
                            ),
                          ),
                          SizedBox(height: 100.0),
                          Text(
                            _videoCredits,
                            style: Theme.of(context).textTheme.caption,
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
