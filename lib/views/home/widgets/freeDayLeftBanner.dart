import 'package:flutter/material.dart';
import 'package:mathilde/views/constants/colors.dart';
import 'package:mathilde/views/home/home.dart';
import 'package:mathilde/views/subscription/subscription.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FreeDayLeftBanner extends StatefulWidget {
  const FreeDayLeftBanner({super.key});

  @override
  State<FreeDayLeftBanner> createState() => _FreeDayLeftBannerState();
}

class _FreeDayLeftBannerState extends State<FreeDayLeftBanner> {
  void initState() {
    super.initState();
    _getDayLeft();
  }

  int daysLeft = 30;
  void _getDayLeft() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int initialDays = prefs.getInt('initialDays') ?? 30;
    DateTime lastOpened = DateTime.parse(
        prefs.getString('lastOpened') ?? DateTime.now().toString());

    // Calculate the number of days since the last app open
    int daysSinceLastOpened = DateTime.now().difference(lastOpened).inDays;

    // Calculate the new number of days left
    int newDaysLeft = initialDays - daysSinceLastOpened;

    setState(() {
      daysLeft = newDaysLeft;
    });

    // Save the new number of days left and the current date
    prefs.setInt('initialDays', initialDays);
    prefs.setString('lastOpened', DateTime.now().toString());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop,
                duration: Duration(milliseconds: 300),
                childCurrent: Home(),
                reverseDuration: Duration(milliseconds: 300),
                child: Subscriptionpage(
                  dayLetfIsZero: false,
                )));
      },
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: daysLeft <= 5
                ? Colors.red.withOpacity(0.1)
                : bgColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Icon(
              Icons.error_outlined,
              color: daysLeft <= 5 ? Colors.red : bgColor,
              size: 20,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              "$daysLeft jours d'éssai gratuit restant",
              style: TextStyle(
                  color: daysLeft <= 5 ? Colors.red : bgColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
            )
          ],
        ),
      ),
    );
  }
}
