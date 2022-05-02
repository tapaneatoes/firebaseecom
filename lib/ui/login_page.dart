import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseecom/controller/FirebaseController.dart';
import 'package:firebaseecom/ui/customviews/IconButton.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../generated/assets.dart';

class LoginPage extends GetView<FirebaseController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset(Assets.imageFirebase)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 32.0, bottom: 4.0, left: 24, right: 24),
                  child: SizedBox(
                    height: 56.0,
                    child: LeftIconButton(
                      title: "Google",
                      image: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          Assets.imageGoogle,
                          width: 32.0,
                        ),
                      ),
                      backgroundColor: Colors.blue,
                      onClick: () {
                        signInWithGoogle();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 24.0, right: 24.0, bottom: 56.0, top: 8),
                  child: SizedBox(
                    height: 56.0,
                    child: LeftIconButton(
                      title: "Phone",
                      image: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                      onClick: () {
                        startPhoneVerification(
                            context: context,
                            action: AuthAction.signIn,
                            auth: controller.getFirebaseAuth());
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
