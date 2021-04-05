// # Dart Imports
import 'package:classmate/presentation/widgets/sign_in_header_widget.dart';
import 'package:classmate/presentation/widgets/view_widget.dart';
import 'package:flutter/Material.dart';

// # Sign In Page
class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return View(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // # Welcome Header Text
        SignInHeader(
          heading: 'SIGN IN',
          subheading: 'Sign in to continue',
        ),

        // # Sized Box for spacing
        SizedBox(
          height: 25.0,
        ),

        // # Form
        // Form(
        //   child: Column(
        //     children: [
        //       // # Email
        //       ThemedTextField(
        //           label: 'Email Address',
        //           onSubmitted: signIn,
        //           keyboardType: TextInputType.emailAddress),

        //       // # Sized Box for spacing
        //       SizedBox(
        //         height: 25.0,
        //       ),

        //       // # Password
        //       ThemedTextField(
        //           label: 'Password',
        //           onSubmitted: signIn,
        //           keyboardType: TextInputType.visiblePassword,
        //           obscureText: true),

        //       // # Forgot Password
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           TextButton(
        //               onPressed: () {},
        //               child: Text(
        //                 'Forgot Password?',
        //                 style: GoogleFonts.montserrat(),
        //               )),
        //         ],
        //       ),

        //       // # Sized Box for spacing
        //       SizedBox(
        //         height: 40.0,
        //       ),

        //       // # Sign In Button
        //       Center(
        //         child: LoadingElevatedButton(
        //             onPressed: signIn,
        //             onSuccess: () {},
        //             onFailure: () {},
        //             child: Text('Sign In',
        //                 style: GoogleFonts.montserrat(
        //                     textStyle: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         color: Colors.white)))),
        //       ),
        //     ],
        //   ),
        // ),

        // // # Sized Box for spacing
        // SizedBox(
        //   height: 70.0,
        // ),

        // // # Divider for Coolness
        // OrDivider(),

        // // # Sized Box for spacing
        // SizedBox(
        //   height: 60.0,
        // ),

        // // # Sign Up Button
        // Center(
        //   child: Column(
        //     children: [
        //       SecondaryElevatedButton(
        //         onPressed: () {
        //           Navigator.pushReplacementNamed(context, '/sign_up');
        //         },
        //         child: Text(
        //           'Sign Up',
        //           style: GoogleFonts.montserrat(
        //               textStyle: TextStyle(fontWeight: FontWeight.bold)),
        //         ),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),

        //       // Some Text
        //       Text(
        //         'To create a new account.',
        //         textAlign: TextAlign.center,
        //         style:
        //             GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 12)),
        //       )
        // ],
        // ),
        // ),
      ],
    ));
  }
}
