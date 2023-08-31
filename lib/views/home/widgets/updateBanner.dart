import 'package:flutter/material.dart';
import 'package:mathilde/views/constants/colors.dart';
import 'package:mathilde/views/home/home.dart';
import 'package:mathilde/views/subscription/subscription.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateBanner extends StatefulWidget {
  const UpdateBanner({super.key});

  @override
  State<UpdateBanner> createState() => _UpdateBannerState();
}

class _UpdateBannerState extends State<UpdateBanner>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  @override
  void initState() {
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController!.repeat(reverse: true);
    super.initState();
  }

  _launchPlayStore() async {
    const url = 'https://play.google.com/store/apps/details?id=com.whatsapp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir le Play Store : $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _launchPlayStore();
        },
        child: FadeTransition(
          opacity: _animationController!,
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: bgColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Icon(
                  Icons.update,
                  color: bgColor,
                  size: 20,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Mise à jour disponible",
                  style: TextStyle(
                      color: bgColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}
