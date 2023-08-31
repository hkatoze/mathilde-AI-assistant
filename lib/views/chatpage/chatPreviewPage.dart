import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:mathilde/models/chatModel.dart';
import 'package:mathilde/models/historyModel.dart';
import 'package:mathilde/services/databaseManager.dart';
import 'package:mathilde/views/components/buttonWithoutIcon.dart';
import 'package:page_transition/page_transition.dart';

import 'chatView.dart';
import 'components/chatbubble.dart';
import 'dart:ui' as ui;

class ChatPreviewPage extends StatefulWidget {
  final HistoryItemModel historyModel;
  ChatPreviewPage({
    super.key,
    required this.historyModel,
  });

  @override
  State<ChatPreviewPage> createState() => _ChatPreviewPageState();
}

class _ChatPreviewPageState extends State<ChatPreviewPage> {
  Uint8List? _imageFile;

  List<ChatModel> chatListAll = [];

  GlobalKey<OverRepaintBoundaryState> globalKey = GlobalKey();

  void initState() {
    super.initState();
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

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Delete chat'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Are you sure want to delete chat ?\nYou will not be able to access this chat if you procede.',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                DatabaseManager.instance
                    .deleteHistoryItem(widget.historyModel.id!);
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: GestureDetector(
            onTap: () {
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
                _showAlertDialog(context);
              },
              child: Container(
                  padding: EdgeInsets.all(5),
                  width: 50,
                  color: Colors.transparent,
                  child: Center(
                      child: Icon(
                    Icons.delete_outline,
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
            height: currentHeight * 0.7,
            child: FutureBuilder<List<ChatModel>>(
                future:
                    DatabaseManager.instance.chatData(widget.historyModel.id!),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ChatModel>> snapshot) {
                  if (snapshot.hasData) {
                    List<ChatModel> datas = snapshot.data!;
                    chatListAll = datas;
                    return SingleChildScrollView(
                      child: OverRepaintBoundary(
                          key: globalKey,
                          child: RepaintBoundary(
                              child: Container(
                            color: Colors.white,
                            child: Column(
                              children: List.generate(
                                  datas.length,
                                  (index) => Chatbubble(
                                        model: datas[index],
                                        chatListLength: datas.length,
                                        index: index,
                                        canEdit: false,
                                        isNew: false,
                                      )),
                            ),
                          ))),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          )),
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: currentWidth * 0.42,
                  child: ButtonWithoutIcon(
                    title: "Keep Asking",
                    bgColor: Colors.white,
                    titleColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 300),
                            childCurrent: ChatPreviewPage(
                              historyModel: widget.historyModel,
                            ),
                            reverseDuration: Duration(milliseconds: 300),
                            child: ChatviewPage(
                              chatListAll: chatListAll,
                              isNewDiscussion: false,
                              historyModel: widget.historyModel,
                            )),
                      );
                    },
                  ),
                ),
                Container(
                  width: currentWidth * 0.42,
                  child: ButtonWithoutIcon(
                    title: "Share",
                    bgColor: Colors.black,
                    titleColor: Colors.white,
                    onPressed: () {
                      shareDiscussion(context);
                    },
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

class UiImagePainter extends CustomPainter {
  final ui.Image image;

  UiImagePainter(this.image);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    // simple aspect fit for the image
    var hr = size.height / image.height;
    var wr = size.width / image.width;

    double ratio;
    double translateX;
    double translateY;
    if (hr < wr) {
      ratio = hr;
      translateX = (size.width - (ratio * image.width)) / 2;
      translateY = 0.0;
    } else {
      ratio = wr;
      translateX = 0.0;
      translateY = (size.height - (ratio * image.height)) / 2;
    }

    canvas.translate(translateX, translateY);
    canvas.scale(ratio, ratio);
    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
  }

  @override
  bool shouldRepaint(UiImagePainter other) {
    return other.image != image;
  }
}

class UiImageDrawer extends StatelessWidget {
  final ui.Image? image;

  const UiImageDrawer({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: UiImagePainter(image!),
    );
  }
}

class OverRepaintBoundary extends StatefulWidget {
  final Widget? child;

  const OverRepaintBoundary({Key? key, this.child}) : super(key: key);

  @override
  OverRepaintBoundaryState createState() => OverRepaintBoundaryState();
}

class OverRepaintBoundaryState extends State<OverRepaintBoundary> {
  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }
}
