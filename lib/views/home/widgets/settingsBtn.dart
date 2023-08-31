import 'package:flutter/material.dart';
import 'package:mathilde/views/home/home.dart';
import 'package:mathilde/views/settings/settings.dart';
import 'package:mathilde/views/subscription/subscription.dart';
import 'package:page_transition/page_transition.dart';

class SettingsBtn extends StatelessWidget {
  final bool dayLeftIsZero;
  const SettingsBtn({super.key, required this.dayLeftIsZero});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftJoined,
                duration: Duration(milliseconds: 300),
                childCurrent: dayLeftIsZero
                    ? Subscriptionpage(dayLetfIsZero: true)
                    : Home(),
                reverseDuration: Duration(milliseconds: 300),
                child: Settingspage()));
      },
      child: Container(
          padding: EdgeInsets.all(5),
          width: 50,
          color: Colors.transparent,
          child: Center(
              child: Icon(
            Icons.settings,
            size: 35,
            color: Colors.black.withOpacity(0.5),
          ))),
    );
  }
}
