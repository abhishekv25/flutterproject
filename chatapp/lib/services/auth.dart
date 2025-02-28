import 'package:chatapp/services/database.dart';
import 'package:chatapp/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurrentUser() async {
    return auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );

    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User? userDetails = result.user;
    String username = userDetails!.email!.replaceAll("@gamil.com", "");
    String firstletter = username.substring(0, 1).toUpperCase();
    await SharedpreferenceHelper().saveUserDisplayName(
      userDetails.displayName!,
    );
    await SharedpreferenceHelper().saveUserEmail(userDetails.email!);
    await SharedpreferenceHelper().saveUserId(userDetails.uid);
    await SharedpreferenceHelper().saveUserImage(userDetails.photoURL!);
    await SharedpreferenceHelper().saveUserName(username);

   if (userDetails != null) {
  Map<String, dynamic> userInfoMap = {
    "Name": userDetails.displayName ?? "No name", // Use fallback if null
    "Email": userDetails.email ?? "No email", // Use fallback if null
    "Image": userDetails.photoURL ?? "No image", // Use fallback if null
    "Id": userDetails.uid,
    "username": username.toUpperCase(),
    "searchkey": firstletter,
  };
  print(userInfoMap);
} else {
  // Handle the case where userDetails is null
  print("User details are null");
}


      await DatabaseMethods()
          .addUser(userInfoMap, userDetails!.uid)
          .then((value) {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Registered Succesfully..",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }
}
