import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mathilde/models/chatModel.dart';
 
import 'buttonOfChatbubble.dart';

class Chatbubble extends StatelessWidget {
  final ChatModel model;
  final int chatListLength;
  final int index;
  final bool canEdit;
  final bool isNew;
  const Chatbubble(
      {super.key,
      required this.model,
      required this.canEdit,
      required this.chatListLength,
      required this.isNew,
      required this.index});

  void copyChat() {
    Clipboard.setData(ClipboardData(text: model.text)).then((value) {
      Fluttertoast.showToast(
          msg: "Copied",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.green.withOpacity(0.5),
          textColor: Colors.white,
          fontSize: 11.0);
    });
  }

  void regenerate() {}

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 5),
        color: model.user == "bot" ? Color(0xFFf1f2f4) : Colors.transparent,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: model.user == "bot"
                            ? Colors.transparent
                            : Color.fromARGB(255, 209, 209, 209),
                        borderRadius: BorderRadius.circular(6)),
                    child: model.user == "bot"
                        ? Center(
                            child:
                                Image.asset("assets/images/icon_prev_ui.png"),
                          )
                        : Center(
                            child: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 65, 64, 64),
                            ),
                          )),
                SizedBox(
                  width: 10,
                ),
                (model.user == "bot" && chatListLength - 1 == index && !isNew )
                    ? Expanded(
                        child: SizedBox(
                        child: AnimatedTextKit(
                          isRepeatingAnimation: false,
                          pause: Duration(milliseconds: 1000),
                          animatedTexts: [
                            TypewriterAnimatedText("${model.text}",
                                textStyle: TextStyle(fontSize: 14),
                                speed: Duration(milliseconds: 65)),
                          ],
                          onTap: () {},
                        ),
                      ))
                    : Expanded(
                        child: Text(
                        "${model.text}",
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 14),
                      ))
              ],
            ),
            if (model.user == "bot")
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (canEdit)
                      SizedBox(
                        width: currentWidth * 0.27,
                      ),
                    if (!canEdit) Container(),
                    if (!canEdit)
                      GestureDetector(
                          onTap: () {
                            copyChat();
                          },
                          child: Container(
                              padding: EdgeInsets.all(5),
                              width: 50,
                              color: Colors.transparent,
                              child: Center(
                                  child: Icon(
                                Icons.copy,
                                size: 30,
                                color: Colors.black.withOpacity(0.6),
                              )))),
                    if (canEdit && (chatListLength - 1 == index))
                      GestureDetector(
                        onTap: () {},
                        child: ButtonOfChatbubble(
                          title: "Regenerate",
                          icon: Icons.restore,
                        ),
                      ),
                    if (canEdit)
                      GestureDetector(
                        onTap: () {
                          copyChat();
                        },
                        child: ButtonOfChatbubble(
                          title: "Copy",
                          icon: Icons.copy,
                        ),
                      )
                  ],
                ),
              )
          ],
        ));
  }
}
