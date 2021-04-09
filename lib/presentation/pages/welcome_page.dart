// # Imports
import 'package:classmate/constants/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

// # Welcome Page
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Setting the Splash Logo's Colors according to Dark or Light Modes
    String _logo = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? 'white_plain'
        : 'white_plain';

    // * Returning the view
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/gifs/studying.gif'),
            fit: BoxFit.cover,
          ),
        ),
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
                          'assets/images/logo/$_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),

                      // # Text
                      Row(
                        children: [
                          Text(
                            "Class",
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.headline2.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                          ),
                          Text(
                            "Mate",
                            textAlign: TextAlign.left,
                            style:
                                Theme.of(context).textTheme.headline2.copyWith(
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
              SizedBox(height: 300),

              // # Button to Sign In
              Center(
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 250, height: 50),
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/sign_in'),
                        icon: Icon(Icons.email_rounded),
                        label: Text('Sign In with E-Mail'),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 250, height: 50),
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/sign_up'),
                        icon: Icon(Icons.email_outlined),
                        label: Text('Sign Up with E-Mail'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Colors.blueGrey[800];
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
