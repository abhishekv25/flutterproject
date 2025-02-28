import 'package:chatapp/services/auth.dart';
import 'package:flutter/material.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            //home image(HR images)
            Image.asset("assests/HR.png"),
            SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                "Welcome to our chart app !! lets try a better experience  ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            //first images (google )
            SizedBox(height: 25.0),
            GestureDetector(
              onTap: () {
                AuthMethods().signInWithGoogle(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    height: 70,
                    padding: EdgeInsets.only(top: 8.0, left: 30.0, bottom: 8.0),

                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 33, 74, 145),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assests/image.png",
                          height: 50,
                          width: 50,

                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 15.0,
                        ), //expand a space from height and width.
                        Text(
                          "Sign up With Google ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
