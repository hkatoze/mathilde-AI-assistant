import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathilde/views/constants/change_theme.dart';
import 'package:mathilde/views/constants/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatefulWidget {
  ChatBubble(
      {required this.text,
      required this.user,
      required this.chatLength,
      required this.index});

  String? text;
  int? index;
  int? chatLength;
  String? user;
  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool _isCopied = false;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
          color:
              widget.user == "Moi" ? bgColor.withOpacity(0.05) : Colors.white),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      child: widget.user == "Moi"
                          ? Icon(Icons.person)
                          : ClipOval(
                              child: Image.asset(
                                "assets/images/icon.png",
                                scale: 25,
                              ),
                            ),
                    ),
                    Text("")
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user!,
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Agne',
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (widget.text!.isEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SpinKitThreeBounce(
                            color: Colors.grey,
                            size: 20,
                          ),
                          Container()
                        ],
                      ),
                    if (widget.text!.isNotEmpty)
                      SizedBox(
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Agne',
                          ),
                          child: widget.user == "Mathilde" &&
                                  (widget.index == widget.chatLength! - 1)
                              ? AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  pause: Duration(milliseconds: 10000),
                                  animatedTexts: [
                                    TypewriterAnimatedText(widget.text!,
                                        textStyle: TextStyle(
                                            color: themeChange.darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 18),
                                        speed: Duration(milliseconds: 65)),
                                  ],
                                  onTap: () {},
                                )
                              : Text(
                                  widget.text!,
                                  style: TextStyle(
                                      color: themeChange.darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18),
                                ),
                        ),
                      ),
                  ],
                )),
                Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: Colors.transparent,
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.share,
                                size: 20,
                              ),
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                      ClipboardData(text: widget.text))
                                  .then((value) {
                                Fluttertoast.showToast(
                                    msg: "Message copié",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor:
                                        Colors.green.withOpacity(0.5),
                                    textColor: Colors.white,
                                    fontSize: 11.0);
                              });
                              setState(() {
                                _isCopied = true;
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              width: 50,
                              height: 50,
                              child: Icon(
                                _isCopied ? Icons.done_all : Icons.copy,
                                size: 20,
                              ),
                            )),
                      ],
                    )
                  ],
                )
              ],
            )
          ]),
    );
  }
}
