import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  final String url;
  final String title;
  WebviewPage({super.key, required this.url, required this.title});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  var loadingPercentage = 0;
  WebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
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
          title: Text(
            "${widget.title}",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: "${widget.url}",
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
                /*     final script = """
            var element = document.querySelector('header');
            if (element != null) {
              element.style.display = 'none';
            }

             var element2 = document.querySelector('footer');
            if (element2 != null) {
              element2.style.display = 'none';
            }
          """;
                _controller!.evaluateJavascript(script); */
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
