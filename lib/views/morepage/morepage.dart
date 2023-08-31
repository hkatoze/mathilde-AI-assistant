import 'package:flutter/material.dart';
import 'package:mathilde/views/Explorepage/explorepage.dart';
import 'package:mathilde/views/components/buttonWithIcon.dart';
import 'package:mathilde/views/constants/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'components/webviewpage.dart';
import 'components/morepageItemWithPrefixIcon.dart';
import 'components/morepageItemWithPrefixImageAndSuffixIcon.dart';
import 'components/morepageItemWithSuffixIconAndPrefixIcon.dart';
import 'components/morepageSectionTitle.dart';
import 'components/selectVoiceList.dart';

class Morepage extends StatelessWidget {
  const Morepage({super.key});

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(tileMode: TileMode.mirror, colors: [
        Color.fromARGB(255, 225, 214, 228),
        Color.fromARGB(255, 189, 219, 243),
      ])),
      child: Container(
        width: currentWidth,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          SizedBox(height: currentHeight * 0.02),
          Container(
            width: 100,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: bgColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25)),
            child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Text(
                    "Free",
                    style: TextStyle(
                        color: bgColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                  Text(
                    "0 credit",
                    style: TextStyle(color: bgColor, fontSize: 13),
                  )
                ])),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(100)),
            child: Icon(
              Icons.person_outline_rounded,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 45,
          ),
          MorepageSectionTitle(
            prefixText: "Invite Friends",
            suffixText: "0 friends invited",
          ),
          SizedBox(
            height: 18,
          ),
          ButtonWithIcon(
            title: "Earn Free Pro",
            icon: Icons.card_giftcard,
            bgColor: bgColor,
          ),
          SizedBox(
            height: 30,
          ),
          MorepageSectionTitle(
            prefixText: "App Language",
            suffixText: "",
            underText:
                "You can change your default app interface language at any time. Mathilde can understand your queries answer them in any language, regardless of the language of your app interface.",
          ),
          SizedBox(
            height: 20,
          ),
          MorepageItemWithPrefixImageAndSuffixIcon(
              wording: "English", image: "english-flag.png"),
          SizedBox(
            height: 30,
          ),
          MorepageSectionTitle(
            prefixText: "Settings",
            suffixText: "",
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeftJoined,
                      duration: Duration(milliseconds: 300),
                      childCurrent: Morepage(),
                      reverseDuration: Duration(milliseconds: 300),
                      child: SelectVoiceList()));
            },
            child: MorepageItemWithSuffixIconAndPrefixIcon(
              wording: "Voice",
              suffixIcon: Icons.arrow_forward_ios,
              prefixIcon: Icons.volume_up,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: currentWidth,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xFFf1f2f4),
                borderRadius: BorderRadius.circular(20)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              MorepageItemWithPrefixIcon(
                wording: "Help",
                prefixIcon: Icons.help_outline,
              ),
              SizedBox(
                height: 20,
              ),
              MorepageItemWithPrefixIcon(
                wording: "Restore Purchases",
                prefixIcon: Icons.star,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          height: 35,
                          width: 35,
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 206, 205, 205)),
                          child: Center(
                            child: Icon(Icons.person),
                          )),
                      Text(
                        "   User Id",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("yi3234iyi434355iyuyu35yuyp",
                          overflow: TextOverflow.clip,
                          style: TextStyle(fontSize: 13)),
                      Icon(Icons.copy, size: 15)
                    ],
                  )
                ],
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: currentWidth,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xFFf1f2f4),
                borderRadius: BorderRadius.circular(20)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              MorepageItemWithPrefixIcon(
                wording: "Share the App",
                prefixIcon: Icons.share,
              ),
              SizedBox(
                height: 20,
              ),
              MorepageItemWithPrefixIcon(
                wording: "Rate Us",
                prefixIcon: Icons.star,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftJoined,
                          duration: Duration(milliseconds: 300),
                          childCurrent: Morepage(),
                          reverseDuration: Duration(milliseconds: 300),
                          child: WebviewPage(
                            title: "Terms of Use",
                            url: "haalemtic.com/",
                          )));
                },
                child: MorepageItemWithPrefixIcon(
                  wording: "Term of Use",
                  prefixIcon: Icons.book,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftJoined,
                          duration: Duration(milliseconds: 300),
                          childCurrent: Morepage(),
                          reverseDuration: Duration(milliseconds: 300),
                          child: WebviewPage(
                            title: "Privacy Policy",
                            url: "haalemtic.com/",
                          )));
                },
                child: MorepageItemWithPrefixIcon(
                  wording: "Privacy Policy",
                  prefixIcon: Icons.check_circle,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MorepageItemWithPrefixIcon(
                wording: "Manage Subscriptions",
                prefixIcon: Icons.book,
              ),
            ]),
          ),
          SizedBox(
            height: 30,
          ),
          MorepageSectionTitle(
            prefixText: "More Apps",
            suffixText: "",
            underText: "Would you like to check out our other amazing apps?",
          ),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    ));
  }
}
