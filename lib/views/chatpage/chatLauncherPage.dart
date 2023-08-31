import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'chatView.dart';

class ChatLauncherPage extends StatelessWidget {
  const ChatLauncherPage({super.key});

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: currentWidth,
              /*   decoration: BoxDecoration(
                  gradient: LinearGradient(tileMode: TileMode.mirror, colors: [
                Color.fromARGB(255, 225, 214, 228),
                Color.fromARGB(255, 189, 219, 243),
              ])), */
              child: Center(
                  child: Column(
                children: [
                  Image.asset(
                    "assets/images/icon_prev_ui.png",
                    scale: 4,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Mathilde",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: currentWidth * 0.11),
                    child: Text(
                      "Type here to get answers Ask any open ended questions",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.scale,
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 300),
                            childCurrent: ChatLauncherPage(),
                            reverseDuration: Duration(milliseconds: 300),
                            child: ChatviewPage(
                              isNewDiscussion: true,
                            )),
                      );
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xFFf1f2f4),
                          borderRadius: BorderRadius.circular(15)),
                      width: currentWidth,
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "Type here...",
                                textAlign: TextAlign.start,
                              ),
                              Container()
                            ],
                          )),
                    ),
                  ),
                ],
              )),
            )));
  }
}
