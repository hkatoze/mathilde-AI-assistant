import 'package:flutter/material.dart';

class SocialBtn extends StatelessWidget {
  String image;
  Color color;
  String text;
  SocialBtn(
      {super.key,
      required this.color,
      required this.image,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Container(
        height: 55,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(20)),
        child: Row(children: [
          SizedBox(
            width: 5,
          ),
          Image.asset(
            "assets/images/${image}.png",
            scale: image == "f" ? 62 : 7,
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${text}",
                style: TextStyle(color: Colors.grey.shade800),
              ),
              SizedBox(
                width: 35,
              )
            ],
          )
        ]),
      ),
    );
  }
}
