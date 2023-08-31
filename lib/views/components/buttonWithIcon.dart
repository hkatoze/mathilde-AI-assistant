import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon(
      {super.key,
      required this.icon,
      required this.title,
      required this.bgColor});
  final String title;
  final IconData icon;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    double currentWidth = MediaQuery.of(context).size.width;
    return Container(
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(bgColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ))),
          onPressed: () {},
          child: Container(
            margin: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${title} ",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Icon(
                  icon,
                  size: 17,
                )
              ],
            ),
          )),
    );
  }
}
