// # Imports
import 'package:classmate/logic/bloc/loading_bloc.dart';
import 'package:classmate/presentation/pages/sign_in_page.dart';
import 'package:classmate/presentation/widgets/loading_animated_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// TODO Check for the position of the logo in the splash screen
/// TODO Match Loading Page Logo to logo in Splash Screen
/// TODO Transition into Welcome Page
class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // * Starting the LoadingStarted Event
    Bloc loadingBLoC = BlocProvider.of<LoadingBloc>(context);
    loadingBLoC.add(LoadingStarted());

    // * Setting the Logo's Colors
    var brightness = MediaQuery.of(context).platformBrightness;
    String logo = brightness == Brightness.dark ? 'white_plain' : 'black_plain';

    // * Returning the View
    return BlocListener<LoadingBloc, LoadingState>(
      listener: (context, state) {
        if (state is LoadingComplete) {
          // TODO Include Routes and Page Transitions
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return SignInPage();
          }));
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            // # Logo
            Align(
                alignment: Alignment.center,
                child: Container(
                    width: 200,
                    height: 200,
                    child: Image.asset(
                      'assets/images/logo/$logo.png',
                      fit: BoxFit.contain,
                    ))),

            // # Animated Text
            Positioned(
                right: 0.0,
                left: 0.0,
                bottom: 220.0,
                child: LoadingAnimatedText(
                  titleStart: 'Class',
                  titleEnd: 'Mate',
                )),
          ],
        ),
      ),
    );
  }
}
