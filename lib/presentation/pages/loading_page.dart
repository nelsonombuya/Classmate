// # Imports
import 'package:classmate/logic/bloc/loading_bloc.dart';
import 'package:classmate/presentation/pages/sign_in_page.dart';
import 'package:classmate/presentation/widgets/loading_animated_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// # Loading Page
class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // * Starting the LoadingStarted Event
    Bloc loadingBLoC = BlocProvider.of<LoadingBloc>(context);
    loadingBLoC.add(LoadingStarted());

    // * Setting the Splash Logo's Colors according to Dark or Light Modes
    String logo = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? 'white_plain'
        : 'black_plain';

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
                    width: 125,
                    height: 125,
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
                  titleStartTextStyle: GoogleFonts.poppins(fontSize: 32.0),
                  titleEnd: 'Mate',
                  titleEndTextStyle: GoogleFonts.poppins(
                      fontSize: 32.0,
                      textStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600)),
                )),
          ],
        ),
      ),
    );
  }
}
