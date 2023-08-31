import 'package:flutter/material.dart';
import 'package:mathilde/views/constants/change_theme.dart';
import 'package:mathilde/views/home/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NotificationPage extends StatefulWidget {
  final String url;
  NotificationPage({super.key, required this.url});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var loadingPercentage = 0;
  WebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Mathilde « BOOST »",
            style: TextStyle(
                color: themeChange.darkTheme ? Colors.white : Colors.black,
                fontSize: 21,
                fontWeight: FontWeight.bold),
          ),
          leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/icon.png",
                  scale: 20,
                ),
              )),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRightJoined,
                        duration: Duration(milliseconds: 300),
                        childCurrent: NotificationPage(
                          url: "",
                        ),
                        reverseDuration: Duration(milliseconds: 300),
                        child: Home()));
              },
              child: Container(
                  padding: EdgeInsets.all(5),
                  width: 70,
                  color: Colors.transparent,
                  child: Center(
                      child: Icon(
                    Icons.home,
                    size: 35,
                    color: themeChange.darkTheme
                        ? Colors.white
                        : Colors.black.withOpacity(0.5),
                  ))),
            )
          ],
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: widget.url,
              onWebViewCreated: (WebViewController controller) {
                _controller = controller;
              },
              onPageStarted: (url) {
                setState(() {
                  loadingPercentage = 0;
                });
              },
              onProgress: (progress) {
                setState(() {
                  loadingPercentage = progress;
                });
              },
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (String url) {
                // Injecte le script JavaScript qui masque la barre de menu
                final script = """
            var element = document.querySelector('header');
            if (element != null) {
              element.style.display = 'none';
            }

             var element2 = document.querySelector('footer');
            if (element2 != null) {
              element2.style.display = 'none';
            }
          """;
                _controller!.evaluateJavascript(script);
              },
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
              ),
          ],
        ));
  }
}
