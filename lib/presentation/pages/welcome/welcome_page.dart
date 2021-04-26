import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/device.dart';
import '../../widgets/asciimoji_widget.dart';
import 'background_video_player_widget.dart';
import 'classmate_logo.dart';
import 'create_new_account_widget.dart';
import 'sign_in_button_widget.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // * Used to show easter egg
  int _eggCounter = 0;
  void _egg() => setState(() => _eggCounter++);

  @override
  Widget build(BuildContext context) {
    Device().init(context);
    String _video = (Device.brightness == Brightness.light) ? 'light' : 'dark';

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // FIXME OOM Crash after too many hot-reloads or hot-restarts
          // ! Comment out BackgroundVideoPlayer widget when you intend on doing this
          BackgroundVideoPlayer(
            video: 'assets/videos/welcome_screen_$_video.mp4',
            placeholder:
                'assets/videos/welcome_screen_${_video}_placeholder.png',
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Device.height(10.0)),
                Padding(
                  child: ClassMateLogo(onTap: _egg),
                  padding: EdgeInsets.symmetric(horizontal: Device.width(5.0)),
                ),
                SizedBox(height: Device.height(38.0)),
                SignInButton(),
                SizedBox(height: Device.height(3.0)),
                CreateANewAccountButton(),
                SizedBox(height: Device.height(3.0)),
                if (_eggCounter >= 5)
                  ASCIImoji(
                    color: CupertinoColors.white,
                    fontSize: Device.height(3.0),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
