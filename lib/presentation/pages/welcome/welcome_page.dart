import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/device_query.dart';
import 'widgets/background_video_player.dart';
import 'widgets/classmate_logo.dart';
import 'widgets/create_new_account_button.dart';
import 'widgets/sign_in_button.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    final DeviceQuery _deviceQuery = DeviceQuery.of(context);
    final String _video =
        (_deviceQuery.brightness == Brightness.light) ? 'light' : 'dark';

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // TODO Verify OOM Crashes
          // FIXME OOM Crash after too many hot-reloads or hot-restarts
          // ! Affects the following pages so far:
          //  - Welcome Page
          //  - Sign In Page
          //  - Sign Up Page
          // ! So make sure to comment out BackgroundVideoPlayer Widget
          // ! When you want to make a lot of minor tested changes to these pages
          BackgroundVideoPlayer(
            video: 'assets/videos/welcome_screen_$_video.mp4',
            placeholder:
                'assets/videos/welcome_screen_${_video}_placeholder.png',
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: _deviceQuery.safeHeight(10.0)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _deviceQuery.safeWidth(5.0),
                  ),
                  child: ClassMateLogo(),
                ),
                SizedBox(height: _deviceQuery.safeHeight(38.0)),
                SignInButton(),
                SizedBox(height: _deviceQuery.safeHeight(3.0)),
                CreateANewAccountButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
