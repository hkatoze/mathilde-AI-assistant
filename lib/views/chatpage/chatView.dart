import 'dart:io';
import 'dart:typed_data';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mathilde/models/chatModel.dart';
import 'package:mathilde/models/historyModel.dart';
import 'package:mathilde/models/static_values.dart';

import 'package:mathilde/services/databaseManager.dart';
import 'package:mathilde/services/openai_services.dart';
import 'package:mathilde/services/tts.dart';
import 'package:mathilde/views/constants/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:ui' as ui;
import 'chatPreviewPage.dart';
import 'components/chatbubble.dart';

class ChatviewPage extends StatefulWidget {
  ChatviewPage(
      {super.key,
      required this.isNewDiscussion,
      this.query,
      this.historyModel,
      this.chatListAll});
  final bool isNewDiscussion;
  final String? query;
  final HistoryItemModel? historyModel;
  final List<ChatModel>? chatListAll;

  @override
  State<ChatviewPage> createState() => _ChatviewPageState();
}

class _ChatviewPageState extends State<ChatviewPage> {
  bool isNewDiscussion = false;
  bool audioVoice = false;

  bool waiting = false;
  int id = 0;
  TextEditingController queryController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  int initialChatLength = 0;
  List<ChatModel> chatListAll = [];
  GlobalKey _listKey = GlobalKey();

  Uint8List? _imageFile;
  SpeechToText speechToText = SpeechToText();
  var text = "Say something";
  bool isSpeaking = false;
  void initState() {
    super.initState();

    if (widget.query != null) {
      queryController.text = widget.query!;
    }
    setState(() {
      isNewDiscussion = widget.isNewDiscussion;
    });
    if (isNewDiscussion) {
      setState(() {
        chatListAll.addAll(newDiscussion);
      });
    } else {
      setState(() {
        chatListAll.addAll(widget.chatListAll!);
        initialChatLength = widget.chatListAll!.length;
        id = widget.historyModel!.id!;
      });
    }
  }

  /* void scrollToLast() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          _listKey.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      _scrollController.jumpTo(position.dy);
    });
  } */

  void stopSpeaking() async {
    setState(() {
      isSpeaking = false;
    });
    speechToText.stop();
    queryController.text = text;

    setState(() {
      text = "Say something";
    });
  }

  void lauchSpeaking() async {
    if (!isSpeaking) {
      var available = await speechToText.initialize();
      if (available) {
        setState(() {
          isSpeaking = true;
          speechToText.listen(onResult: (result) {
            setState(() {
              text = result.recognizedWords;
            });
          });
        });
      }
    }
  }

  GlobalKey<OverRepaintBoundaryState> globalKey = GlobalKey();

  void saveData() {
    for (int i = initialChatLength; i < chatListAll.length; i++) {
      DatabaseManager.instance.addChat(ChatModel(
          historiItemId: id,
          date: chatListAll[i].date,
          text: "${chatListAll[i].text}",
          user: "${chatListAll[i].user}"));
    }
  }

  void sendQuery() async {
    setState(() {
      chatListAll.add(ChatModel(
          historiItemId: id,
          date: DateTime.now(),
          text: "${queryController.text.trim()}",
          user: "user"));

      waiting = true;
    });

    var query = queryController.text.trim();
    queryController.clear();

    String mathildeResponse = await ApiServices.sendMessage(query);
    setState(() {
      chatListAll.add(ChatModel(
          date: DateTime.now(), text: "${mathildeResponse}", user: "bot"));
      waiting = false;
    });

    if (audioVoice) {
      TextToSpeech.speak(mathildeResponse);

     
    }

    if (isNewDiscussion) {
      int local_id = await DatabaseManager.instance.addHistoryItem(
          HistoryItemModel(
              botMsg: chatListAll[chatListAll.length - 1].text,
              userMsg: chatListAll[chatListAll.length - 2].text,
              date_sended: chatListAll[chatListAll.length - 2].date));
      setState(() {
        id = local_id;
        isNewDiscussion = false;
      });
    } else {
      DatabaseManager.instance.updateHistoryItem(HistoryItemModel(
          id: id,
          botMsg: chatListAll[chatListAll.length - 1].text,
          userMsg: chatListAll[chatListAll.length - 2].text,
          date_sended: chatListAll[chatListAll.length - 2].date));
    }
  }

  void shareDiscussion(BuildContext context) async {
    var renderObject = globalKey.currentContext!.findRenderObject();

    RenderRepaintBoundary boundary = renderObject as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 3);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final directory = (await getApplicationDocumentsDirectory()).path;
    if (byteData != null) {
      Uint8List pngint8 = byteData.buffer.asUint8List();
      setState(() {
        _imageFile = pngint8;
      });
    }
    File imgFile = new File(directory + "/screenshot.png");

    await imgFile.writeAsBytes(
      _imageFile!,
    );

    /*   final saveImage = await ImageGallerySaver.saveImage(
        Uint8List.fromList(_imageFile!),
        quality: 100,
        name: "screenshot"); */

    await Share.shareFiles(
      ['${directory}/screenshot.png'],
      subject: 'Share ScreenShot',
      text: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: GestureDetector(
              onTap: () {
                saveData();
                Navigator.pop(context);
              },
              child: Container(
                  padding: EdgeInsets.all(5),
                  width: 50,
                  color: Colors.transparent,
                  child: Center(
                      child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.black,
                  )))),
          actions: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    audioVoice = !audioVoice;
                  });
                  TextToSpeech.stop();
                },
                child: Container(
                    padding: EdgeInsets.all(5),
                    width: 50,
                    color: Colors.transparent,
                    child: Center(
                        child: Icon(
                      audioVoice ? Icons.volume_up : Icons.volume_off,
                      size: 30,
                      color: Colors.black,
                    )))),
            GestureDetector(
                onTap: () {
                  shareDiscussion(context);
                },
                child: Container(
                    padding: EdgeInsets.all(5),
                    width: 50,
                    color: Colors.transparent,
                    child: Center(
                        child: Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.black,
                    ))))
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                child: SingleChildScrollView(
                    child: OverRepaintBoundary(
                        key: globalKey,
                        child: RepaintBoundary(
                          child: Container(
                              color: Colors.white,
                              child: Column(
                                children: List.generate(
                                    chatListAll.length,
                                    (index) => Chatbubble(
                                          model: chatListAll[index],
                                          chatListLength: chatListAll.length,
                                          index: index,
                                          isNew: false,
                                          canEdit: true,
                                        )),
                              )),
                        ))),
              )),
              if (waiting)
                Container(
                  child: SpinKitThreeBounce(
                    color: bgColor,
                    size: 20,
                  ),
                ),
              Container(
                height: currentHeight * 0.1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFf6f7fb),
                      border: Border.all(color: Color(0xFFcbcbcb)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isSpeaking
                        ? Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${text}",
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                              SpinKitThreeBounce(
                                color: Colors.grey,
                                size: 13,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                child: AvatarGlow(
                                  endRadius: 75.0,
                                  animate: true,
                                  duration: const Duration(milliseconds: 2000),
                                  glowColor: bgColor,
                                  repeat: true,
                                  repeatPauseDuration:
                                      const Duration(milliseconds: 100),
                                  showTwoGlows: true,
                                  child: GestureDetector(
                                      onTap: () {
                                        stopSpeaking();
                                      },
                                      child: CircleAvatar(
                                          backgroundColor: bgColor,
                                          radius: 13,
                                          child: Icon(
                                            Icons.mic,
                                            size: 18,
                                            color: Colors.white,
                                          ))),
                                ),
                              )
                            ],
                          )
                        : Center(
                            child: TextField(
                              controller: queryController,
                              autofocus: true,
                              maxLines: null,
                              expands: true,
                              onSubmitted: (quey) {
                                sendQuery();
                              },
                              onTap: () {},
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      lauchSpeaking();
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: bgColor,
                                        child: Icon(
                                          Icons.mic_none,
                                          size: 18,
                                          color: Colors.white,
                                        ))),
                                border: InputBorder.none,
                                hintText: "Write your message",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        saveData();
        return true;
      },
    );
  }
}
