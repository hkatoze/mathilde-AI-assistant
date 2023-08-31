import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mathilde/views/congratulations/congratulations.dart';
import 'package:mathilde/views/constants/change_theme.dart';
import 'package:mathilde/views/constants/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../home/widgets/settingsBtn.dart';
import 'components/subscriptionForm.dart';

class Subscriptionpage extends StatefulWidget {
  final bool dayLetfIsZero;
  Subscriptionpage({super.key, required this.dayLetfIsZero});

  @override
  State<Subscriptionpage> createState() => _SubscriptionpageState();
}

class _SubscriptionpageState extends State<Subscriptionpage> {
  int selectedPlan = 2;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final _user = Provider.of<User?>(context);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "Mathilde",
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
                widget.dayLetfIsZero
                    ? SettingsBtn(
                        dayLeftIsZero: true,
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            width: 70,
                            color: Colors.transparent,
                            child: Center(
                                child: Icon(
                              Icons.close,
                              size: 35,
                              color: themeChange.darkTheme
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.5),
                            ))),
                      )
              ],
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choisissez votre\nplan d'abonnement.",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Agne"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      "Obtenez l'accès à:",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Agne"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check, color: Colors.green),
                        Expanded(
                          child: Text(
                            "  Des questions et réponses illimitées",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Agne"),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check, color: Colors.green),
                        Expanded(
                          child: Text(
                            "  Une vitesse de reponse maximale",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Agne"),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check, color: Colors.green),
                        Expanded(
                          child: Text(
                            "  Une intégration du Modèle Avancé de ChatGPT",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Agne"),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPlan = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:
                                    selectedPlan == 1 ? bgColor : Colors.grey)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "     0.16\$ ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                        fontFamily: "Agne"),
                                  ),
                                  Text(
                                    "par semaine",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Agne"),
                                  ),
                                ],
                              ),
                              Radio(
                                value: 1,
                                hoverColor: Color.fromARGB(255, 241, 236, 236),
                                groupValue: selectedPlan,
                                onChanged: (value) {},
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPlan = 2;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:
                                    selectedPlan == 2 ? bgColor : Colors.grey)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "     0.49\$ ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                        fontFamily: "Agne"),
                                  ),
                                  Text(
                                    "par mois",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Agne"),
                                  ),
                                ],
                              ),
                              Radio(
                                value: 2,
                                hoverColor: Color.fromARGB(255, 241, 236, 236),
                                groupValue: selectedPlan,
                                onChanged: (value) {},
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPlan = 3;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:
                                    selectedPlan == 3 ? bgColor : Colors.grey)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "     4.85\$ ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                        fontFamily: "Agne"),
                                  ),
                                  Text(
                                    "par an",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Agne"),
                                  ),
                                ],
                              ),
                              Radio(
                                value: 3,
                                hoverColor: Color.fromARGB(255, 241, 236, 236),
                                groupValue: selectedPlan,
                                onChanged: (value) {},
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: bgColor,
                                  shape: const StadiumBorder()),
                              onPressed: () {
                                if (_user == null) {
                                  showModalBottomSheet(
                                      elevation: 100,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return SubscriptionForm(
                                            plan: selectedPlan == 1
                                                ? "0.16\$ par semaine"
                                                : (selectedPlan == 2
                                                    ? "0.49\$ par mois"
                                                    : "4.85\$ par an"));
                                      });
                                } else {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType
                                              .rightToLeftJoined,
                                          duration:
                                              const Duration(milliseconds: 700),
                                          childCurrent: Subscriptionpage(
                                            dayLetfIsZero: false,
                                          ),
                                          reverseDuration:
                                              const Duration(milliseconds: 700),
                                          child: CongratulationsPage(
                                              userAddress:
                                                  _user.email.toString(),
                                              plan: selectedPlan == 1
                                                  ? "0.16\$ par semaine"
                                                  : (selectedPlan == 2
                                                      ? "0.49\$ par mois"
                                                      : "4.85\$ par an"))));
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.all(15),
                                child: Text(
                                  "Continuer",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ))),
                    )
                  ]),
            )));
  }
}
