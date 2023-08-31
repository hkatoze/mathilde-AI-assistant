import 'package:flutter/material.dart';
import 'package:mathilde/views/constants/colors.dart';
import 'package:mathilde/views/home/home.dart';
import 'package:page_transition/page_transition.dart';

class ResultScreen extends StatelessWidget {
  final String? text;

  const ResultScreen({super.key, this.text});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('RESULTAT DU SCAN'),
        backgroundColor: bgColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(30.0),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.85,
              child: Text(
                text!,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: bgColor, shape: const StadiumBorder()),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.topToBottom,
                                duration: Duration(milliseconds: 300),
                                childCurrent: ResultScreen(),
                                reverseDuration: Duration(milliseconds: 300),
                                child: Home(
                                  query: text,
                                )));
                      },
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: Text(
                          "Continuer",
                          style: TextStyle(fontSize: 20),
                        ),
                      ))),
            ),
          ],
        ),
      ));
}
