import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mathilde/services/firebase_services.dart';
import 'package:mathilde/views/constants/colors.dart';
import 'package:mathilde/views/home/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CongratulationsPage extends StatefulWidget {
  String plan;
  String userAddress;
  CongratulationsPage(
      {super.key, required this.userAddress, required this.plan});

  @override
  State<CongratulationsPage> createState() => _CongratulationsPageState();
}

class _CongratulationsPageState extends State<CongratulationsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool isPlaying = false;
  bool isValidated = false;
  double _percent = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _sendRequest();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _sendRequest() async {
    /*    Dio dio = Dio();
    var response = await dio.post(
      'https://vbs-solutions.com/',
      onSendProgress: (int receive, int total) {
        print("${(total * -1)}");
        //print("${(receive)}");
      },
      data: {
        "field1": "value1",
        "field2": "value2",
      },
    ); */

    Timer.periodic(Duration(milliseconds: 500), (timer) async {
      if (_percent < 0.9) {
        setState(() {
          _percent = _percent + 0.1;
        });
      } else {
        timer.cancel();
        setState(() {
          isValidated = true;
        });
      }
    });
    DataBaseService().addSubscription(widget.userAddress, widget.plan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.all(14),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  animateFromLastPercent: true,
                  percent: _percent,
                  center: isValidated
                      ? Container(
                          height: 70,
                          width: 70,
                          child: CircleAvatar(
                            backgroundColor: bgColor.withOpacity(0.15),
                            child: Icon(
                              Icons.check,
                              color: bgColor,
                              size: 45,
                            ),
                          ),
                        )
                      : new Text(
                          "${(_percent * 100).toInt()}%",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                  footer: new Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!isValidated)
                            SpinKitThreeBounce(
                              color: Colors.black,
                              size: 10,
                            ),
                          Text(
                            isValidated ? "Félicitations" : "En cours d'envoie",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                          if (!isValidated)
                            SpinKitThreeBounce(
                              color: Colors.black,
                              size: 10,
                            )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Visibility(
                          visible: isValidated,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.15),
                            child: Text(
                              "Votre demande a été envoyé, le service d'abonnement vous contactera pour la confirmation.",
                              textAlign: TextAlign.center,
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Visibility(
                          visible: isValidated,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.15),
                            child: Text(
                              "En attendant profiter de la version gratuite qui offre tout de même des fonctionnalités assez intéressantes\n😉",
                              textAlign: TextAlign.center,
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Visibility(
                          visible: isValidated,
                          child: Center(
                            child: SizedBox(
                              width: 200,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType
                                              .leftToRightJoined,
                                          duration:
                                              const Duration(milliseconds: 700),
                                          childCurrent: CongratulationsPage(
                                            plan: "",
                                            userAddress: "",
                                          ),
                                          reverseDuration:
                                              const Duration(milliseconds: 700),
                                          child: Home()));
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: bgColor,
                                    shape: const StadiumBorder()),
                                child: const Text("Revenir"),
                              ),
                            ),
                          )),
                    ],
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: bgColor,
                ),
              ],
            ),
          )),
    );
  }
}
